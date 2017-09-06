%% Short sudoku solver for use with swi-prolog

%% Written by Joe Bloggs [2017-09-06 Wed]

:- use_module(library(clpfd)).

sudoku(Rows) :-  
  append(Rows, Vs), Vs ins 1..9,
  maplist(all_distinct, Rows),
  transpose(Rows, Columns), 
  maplist(all_distinct, Columns), 
  Rows = [A,B,C,D,E,F,G,H,I], 
  blocks(A, B, C), blocks(D, E, F), blocks(G, H, I), 
  maplist(label, Rows). 

blocks([], [], []). 
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :- 
  all_distinct([A,B,C,D,E,F,G,H,I]),      
  blocks(Bs1, Bs2, Bs3).


%% Enter sudoku data in matrix below, and then to get a solution in the prolog interpreter do:
%% ?- solve(A,B,C,D,E,F,G,H,I).

solve(A,B,C,D,E,F,G,H,I) :-
    Puzzle = [
	[_,_,_,_,_,1,_,2,_],  
	[_,_,_,5,_,_,4,_,3],  
	[_,_,_,_,7,_,8,1,_],  
	[_,6,_,3,_,8,_,_,5],  
	[_,_,2,_,_,_,1,_,_],  
	[8,_,_,7,_,2,_,4,_],  
	[_,1,5,_,6,_,_,_,_],  
	[7,_,6,_,_,5,_,_,_],  
	[_,2,_,4,_,_,_,_,_]
    ],
    Puzzle = [A,B,C,D,E,F,G,H,I],
    sudoku([A,B,C,D,E,F,G,H,I]).

%:- write(solve(A,B,C,D,E,F,G,H,I)), nl, halt.
