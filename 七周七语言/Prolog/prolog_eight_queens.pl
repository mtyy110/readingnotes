queen(Q) :-
	Q = (Row, Col),
	Region = [1,2,3,4,5,6,7,8],
	member(Row, Region),
	member(Col, Region).

valid_queens(Qa, Qb) :-
	Qa = (Rowa, Cola),
	Qb = (Rowb, Colb),
	queen(Qa),
	queen(Qb),
	\+(Rowa = Rowb),
	\+(Cola = Colb),
	Sr is Rowa - Rowb,
	Sl is Cola - Colb,
	RSl is Colb - Cola,
	\+(Sr = Sl),
	\+(Sr = RSl).

valid_list(Q, []) :- queen(Q).
valid_list(Q, [Head|Tail]) :- valid_queens(Q, Head), valid_list(Q, Tail).
valid_list([]).
valid_list([Head|Tail]) :- valid_list(Head, Tail), valid_list(Tail).

eight_queens([(Row1, Col1), (Row2, Col2), (Row3, Col3), (Row4, Col4), (Row5, Col5), (Row6, Col6), (Row7, Col7), (Row8, Col8)]) :-
	List = [(Row1, Col1), (Row2, Col2), (Row3, Col3), (Row4, Col4), (Row5, Col5), (Row6, Col6), (Row7, Col7), (Row8, Col8)],
	valid_list(List).
