#!/usr/bin/env io 

array := list(list(), list(1), list(2, 3), list(4, 5, 6))

sum := method(array,
	total := 0
	array foreach(subArray,
		total := if(subArray isEmpty, 0, subArray sum) + total
	)
	return total
)

sum(array) println
