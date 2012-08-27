my_sort(List, Sort) :- length(List, ListLength), ListLength > 0, min_list(List, Min), append([Min], TailSort, Sort), delete(List, Min, TailList), my_sort(TailList, TailSort).
my_sort([], []).
