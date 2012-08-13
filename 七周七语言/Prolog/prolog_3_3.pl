valid_queen(Q) :- member(Q, [1,2,3,4,5,6,7,8]).
valid_board([]).
valid_board([Head|Tail]) :- valid_queen(Head), valid_board(Tail). 
    
diags1([], []).
diags1([Head|QueensTail], [Diagonal|DiagonalsTail]) :- 
  length(QueensTail, Row),
  Diagonal is Head - Row,
  diags1(QueensTail, DiagonalsTail).
  
diags2([], []).
diags2([Head|QueensTail], [Diagonal|DiagonalsTail]) :- 
  length(QueensTail, Row),
  Diagonal is Head + Row,
  diags2(QueensTail, DiagonalsTail).

eight_queens(Board) :- 
  Board = [_, _, _, _, _, _, _, _],
  valid_board(Board), 
  diags1(Board, Diags1), 
  diags2(Board, Diags2), 
  fd_all_different(Board), 
  fd_all_different(Diags1),   
  fd_all_different(Diags2).
