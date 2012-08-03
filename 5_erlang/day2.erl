-module(day2).
-export([htlookup/2]).
-export([langdb/0]).
-export([shopping/1]).
-export([silly_shopping_list/0]).
-export([tictactoe/1]).
-export([tictactoe_test1/0]).
-export([tictactoe_test2/0]).
-export([tictactoe_test3/0]).
-export([tictactoe_test4/0]).

% day2:htlookup(day2:langdb(), java).

htlookup([{KW, VAL}|_], KW) -> VAL;
htlookup([_|T], KW) -> htlookup(T, KW).

langdb() -> [
  {ruby, "OO language"},
  {java, "Corporate crap"},
  {erlang, "all your base"},
  {haskell, "functional hipstery"}
].

% day2:shopping(day2:silly_shopping_list()).

shopping(List) -> [{Product, Quantity*Price} || {Product, Quantity, Price} <- List].

silly_shopping_list() -> [
  {iphones, 10, 500.0},
  {pepsi_max, 2, 1.85},
  {katanas, 1, 1200.0}
].

tictactoe3([[x,x,x]|_], _) -> x;
tictactoe3([[o,o,o]|_], _) -> o;
tictactoe3([_|T], CanMove) -> tictactoe3(T, CanMove);
tictactoe3([], CanMove) -> CanMove.

canmove([]) ->  tie;
canmove([e|_]) -> not_yet;
canmove([_|T]) -> canmove(T).

tictactoe(Board) ->
  [A, B, C,
   D, E, F,
   G, H, I] = Board,
  Threes = [
    [A,B,C], [D,E,F], [G,H,I],
    [A,D,G], [B,E,H], [C,F,I],
    [A,E,I], [C,E,G]
  ],
  tictactoe3(Threes, canmove(Board))
.

% winner - o
tictactoe_test1() -> [
  x,x,o,
  x,o,x,
  o,x,o
].

% winner - x
tictactoe_test2() -> [
  e,x,e,
  o,x,o,
  e,x,e
].

% winner - not_yet
tictactoe_test3() -> [
  e,o,e,
  o,x,o,
  e,x,x
].

% winner - tie
tictactoe_test4() -> [
  o,o,x,
  x,x,o,
  o,x,x
].
