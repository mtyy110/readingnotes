my_reverse([], []).
my_reverse([Head|Tail], Reverse) :- my_reverse(Tail, TailReverse), append(TailReverse, [Head], Reverse).
