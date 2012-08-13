my_min_list([Head], Head).
my_min_list([Head|Tail], Min) :- length(Tail, TailLength), TailLength > 0, my_min_list(Tail, TailMin), Min is min(Head, TailMin).
