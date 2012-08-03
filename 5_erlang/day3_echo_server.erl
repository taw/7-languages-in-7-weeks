-module(day3_echo_server).
-export([start/0, loop0/1, worker/2]).

% START of COPYPASTA (more or less)
-define(PORTNO, 2201).

start() -> start(?PORTNO).
start(P) -> spawn_link(?MODULE, loop0, [P]).

loop0(Port) ->
  case gen_tcp:listen(Port, [binary, {reuseaddr, true}, {packet, line}, {active, false}]) of
    {ok, LSock} ->
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
	    client_connection(Socket);
	  {error, Reason} ->
	    Server ! next_worker,
	    io:format("Can't accept socket ~p~n", [Reason])
    end.
% END of COPYPASTA

client_connection(Socket) ->
  case gen_tcp:recv(Socket, 0) of
  	{ok, Packet} ->
      case gen_tcp:send(Socket, Packet) of
  	    {error, _Reason} -> exit(normal);
  	    ok -> client_connection(Socket)
      end;
  	{error, closed} ->
  		0
  	end.
