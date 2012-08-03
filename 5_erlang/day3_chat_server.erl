-module(day3_chat_server).
-export([start/0, loop0/1, worker/2, broadcast_loop/0]).
-define(PORTNO, 2202).

% Main loop

start() -> start(?PORTNO).
start(P) -> spawn_link(?MODULE, loop0, [P]).

loop0(Port) ->
  case gen_tcp:listen(Port, [{reuseaddr, true}, {packet, line}, {active, false}]) of
    {ok, LSock} ->
      register(broadcast, spawn(?MODULE, broadcast_loop, [])),
	    spawn(?MODULE, worker, [self(), LSock]),
	    loop(LSock);
    Other ->
	     io:format("Can't listen to socket ~p~n", [Other])
  end.

loop(LSock) ->
  receive
    next_worker -> spawn_link(?MODULE, worker, [self(), LSock])
  end,
  loop(LSock).

worker(Server, LSock) ->
  case gen_tcp:accept(LSock) of
	  {ok, Socket} ->
	    Server ! next_worker,
	    broadcast ! {register, Socket},
	    client_connection(Socket);
	  {error, Reason} ->
	    Server ! next_worker,
	    io:format("Can't accept socket ~p~n", [Reason])
    end.
% END of COPYPASTA

% String functions
sjoin(Ary) -> string:join(Ary, "").

chomp([13,10]) -> [];
chomp([10]) -> [];
chomp([]) -> [];
chomp([H]) -> [H];
chomp([H|T]) -> [H|chomp(T)].

% TCP I/O
read_line(Socket) ->
  case gen_tcp:recv(Socket, 0) of
  	{ok, Line} -> chomp(Line);
    {error, _Reason} -> exit(normal)
	end.

send_line(Socket, Line) ->
  case gen_tcp:send(Socket, Line) of
    {error, _Reason} -> exit(normal);
    ok -> 0
  end.

% Broadcaster process
% Just try writing to sockets even when they're dead, it's not pretty but it will do for now
broadcast_loop() -> broadcast_loop([]).
broadcast_loop(Sockets) ->
  receive
    {register, Socket} ->
      io:format("Got socket ~p~n", [Socket]),
      broadcast_loop([Socket|Sockets]);
    {line, Line} ->
      io:format("Got line ~p~n", [Line]),
      [gen_tcp:send(Socket, Line) || Socket <- Sockets]
  end,
  broadcast_loop(Sockets).

% Client processes

client_connection(Socket) ->
  UserName = read_line(Socket),
  send_line(Socket, sjoin(["Hello <", UserName, ">", "\n"])),
  client_connection(Socket, UserName).

client_connection(Socket, UserName) ->
  broadcast ! {line, sjoin(["<", UserName, "> ", read_line(Socket), "\n"])},
  client_connection(Socket, UserName).

% c(day3_chat_server). day3_chat_server:start().
