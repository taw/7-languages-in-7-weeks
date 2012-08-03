love(ice_cream).
love(kittens).

write_things_i_love :- love(X), write('I love '),
                       write(X),
                       nl,
                       fail.


sudoku9_rows([
 A1, A2, A3, A4, A5, A6, A7, A8, A9,
 B1, B2, B3, B4, B5, B6, B7, B8, B9,
 C1, C2, C3, C4, C5, C6, C7, C8, C9,
 D1, D2, D3, D4, D5, D6, D7, D8, D9,
 E1, E2, E3, E4, E5, E6, E7, E8, E9,
 F1, F2, F3, F4, F5, F6, F7, F8, F9,
 G1, G2, G3, G4, G5, G6, G7, G8, G9,
 H1, H2, H3, H4, H5, H6, H7, H8, H9,
 I1, I2, I3, I4, I5, I6, I7, I8, I9
],
  [A1, A2, A3, A4, A5, A6, A7, A8, A9],
  [B1, B2, B3, B4, B5, B6, B7, B8, B9],
  [C1, C2, C3, C4, C5, C6, C7, C8, C9],
  [D1, D2, D3, D4, D5, D6, D7, D8, D9],
  [E1, E2, E3, E4, E5, E6, E7, E8, E9],
  [F1, F2, F3, F4, F5, F6, F7, F8, F9],
  [G1, G2, G3, G4, G5, G6, G7, G8, G9],
  [H1, H2, H3, H4, H5, H6, H7, H8, H9],
  [I1, I2, I3, I4, I5, I6, I7, I8, I9]
).

sudoku9_cols([
 A1, A2, A3, A4, A5, A6, A7, A8, A9,
 B1, B2, B3, B4, B5, B6, B7, B8, B9,
 C1, C2, C3, C4, C5, C6, C7, C8, C9,
 D1, D2, D3, D4, D5, D6, D7, D8, D9,
 E1, E2, E3, E4, E5, E6, E7, E8, E9,
 F1, F2, F3, F4, F5, F6, F7, F8, F9,
 G1, G2, G3, G4, G5, G6, G7, G8, G9,
 H1, H2, H3, H4, H5, H6, H7, H8, H9,
 I1, I2, I3, I4, I5, I6, I7, I8, I9
],
  [A1, B1, C1, D1, E1, F1, G1, H1, I1],
  [A2, B2, C2, D2, E2, F2, G2, H2, I2],
  [A3, B3, C3, D3, E3, F3, G3, H3, I3],
  [A4, B4, C4, D4, E4, F4, G4, H4, I4],
  [A5, B5, C5, D5, E5, F5, G5, H5, I5],
  [A6, B6, C6, D6, E6, F6, G6, H6, I6],
  [A7, B7, C7, D7, E7, F7, G7, H7, I7],
  [A8, B8, C8, D8, E8, F8, G8, H8, I8],
  [A9, B9, C9, D9, E9, F9, G9, H9, I9]
).

sudoku9_squares([
 A1, A2, A3, A4, A5, A6, A7, A8, A9,
 B1, B2, B3, B4, B5, B6, B7, B8, B9,
 C1, C2, C3, C4, C5, C6, C7, C8, C9,
 D1, D2, D3, D4, D5, D6, D7, D8, D9,
 E1, E2, E3, E4, E5, E6, E7, E8, E9,
 F1, F2, F3, F4, F5, F6, F7, F8, F9,
 G1, G2, G3, G4, G5, G6, G7, G8, G9,
 H1, H2, H3, H4, H5, H6, H7, H8, H9,
 I1, I2, I3, I4, I5, I6, I7, I8, I9
],
  [A1, A2, A3, B1, B2, B3, C1, C2, C3],
  [D1, D2, D3, E1, E2, E3, F1, F2, F3],
  [G1, G2, G3, H1, H2, H3, I1, I2, I3],
  [A4, A5, A6, B4, B5, B6, C4, C5, C6],
  [D4, D5, D6, E4, E5, E6, F4, F5, F6],
  [G4, G5, G6, H4, H5, H6, I4, I5, I6],
  [A7, A8, A9, B7, B8, B9, C7, C8, C9],
  [D7, D8, D9, E7, E8, E9, F7, F8, F9],
  [G7, G8, G9, H7, H8, H9, I7, I8, I9]
).

fd_all_different_many([]).
fd_all_different_many([H|T]) :- fd_all_different(H), fd_all_different_many(T).

sudoku9(Sudoku9) :-
  sudoku9_rows(Sudoku9, Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9),
  sudoku9_cols(Sudoku9, Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9),
  sudoku9_squares(Sudoku9, Sq1, Sq2, Sq3, Sq4, Sq5, Sq6, Sq7, Sq8, Sq9),
  fd_domain(Sudoku9, 1, 9),
  fd_all_different_many([Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9]),
  fd_all_different_many([Col1, Col2, Col3, Col4, Col5, Col6, Col7, Col8, Col9]),
  fd_all_different_many([Sq1, Sq2, Sq3, Sq4, Sq5, Sq6, Sq7, Sq8, Sq9]).

print_sudoku_row([A,B,C,D,E,F,G,H,I]) :-
  write(A), write(' '), write(B), write(' '), write(C), write('|'),
  write(D), write(' '), write(E), write(' '), write(F), write('|'),
  write(G), write(' '), write(H), write(' '), write(I), nl.

% sad hack
force19([]).
force19([1|T]) :- force19(T).
force19([2|T]) :- force19(T).
force19([3|T]) :- force19(T).
force19([4|T]) :- force19(T).
force19([5|T]) :- force19(T).
force19([6|T]) :- force19(T).
force19([7|T]) :- force19(T).
force19([8|T]) :- force19(T).
force19([9|T]) :- force19(T).

print_solved_sudoku9(Sudoku9) :-
  sudoku9(Sudoku9),
  sudoku9_rows(Sudoku9, Row1, Row2, Row3, Row4, Row5, Row6, Row7, Row8, Row9),
  force19(Sudoku9),
  print_sudoku_row(Row1),
  print_sudoku_row(Row2),
  print_sudoku_row(Row3),
  write('-----+-----+-----'), nl,
  print_sudoku_row(Row4),
  print_sudoku_row(Row5),
  print_sudoku_row(Row6),
  write('-----+-----+-----'), nl,
  print_sudoku_row(Row7),
  print_sudoku_row(Row8),
  print_sudoku_row(Row9).
  
  
print_test1 :- print_solved_sudoku9([
  _, _, 6, _, 9, _, _, 7, 2,
  _, _, 3, _, _, _, _, _, _,
  _, _, 9, 7, _, 2, 1, _, _,

  _, _, 7, 9, _, _, _, _, _,
  _, _, _, _, 1, _, _, _, _,
  _, 1, _, _, 7, _, 8, _, 4,

  _, _, _, _, 5, 6, 2, _, _,
  9, _, 2, _, _, _, _, _, _,
  _, 8, _, _, _, _, _, _, 1
]).
