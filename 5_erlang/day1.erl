-module(day1).
-export([word_count/1]).
-export([beers/0]).
-export([winorfail/1]).

word_count([]) -> 0;
word_count([32|T]) -> word_count(T);
word_count([_|T]) -> 1 + word_count_w(T).

word_count_w([]) -> 0;
word_count_w([32|T]) -> word_count(T);
word_count_w([_|T]) -> word_count_w(T).

beers(0) -> 0;
beers(N) -> io:format("~B bottles of beer on the wall.~n", [N]), beers(N-1).

beers() -> beers(100).

winorfail(success) -> io:format("success~n");
winorfail({error, Message}) -> io:format("error: ~s~n", [Message]).
