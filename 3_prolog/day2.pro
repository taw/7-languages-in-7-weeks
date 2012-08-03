fib(1, 1).
fib(2, 1).
fib(K, N) :- K > 2, K1 is K-1, K2 is K-2, fib(K1,N1), fib(K2,N2), N is N1+N2.
% fib(10, N).
% X = 55

min_element([X], X).
min_element([X|[Y|Tail]], Z) :- X =< Y, min_element([X|Tail], Z).
min_element([X|[Y|Tail]], Z) :- X > Y,  min_element([Y|Tail], Z).
% min_element([13,42,7,89,44], X).
% X = 7

myappend([], X, X).
myappend([H|T], X, [H|TX]) :- myappend(T, X, TX).

myreverse([], X, X).
myreverse([H|T], R, X) :- myreverse(T, [H|R], X).
myreverse(X, Xrev) :- myreverse(X, [], Xrev).


select_min_element([X], X, []).
select_min_element([X|[Y|Tail]], Z, [Y|Rest]) :- X =< Y, select_min_element([X|Tail], Z, Rest).
select_min_element([X|[Y|Tail]], Z, [X|Rest]) :- X > Y,  select_min_element([Y|Tail], Z, Rest).

mysort([], []).
mysort([H|T], [Min|RestSorted]) :- select_min_element([H|T], Min, Rest), mysort(Rest, RestSorted).

% Copypasta from http://stackoverflow.com/questions/745095/towers-of-hanoi-puzzle-prolog
move(1,X,Y,_) :-  
    write('Move top disk from '), 
    write(X), 
    write(' to '), 
    write(Y), 
    nl. 
move(N,X,Y,Z) :- 
    N>1, 
    M is N-1, 
    move(M,X,Z,Y), 
    move(1,X,Y,_), 
    move(M,Z,Y,X).  
