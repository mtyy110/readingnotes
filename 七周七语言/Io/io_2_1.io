#!/usr/bin/env io
num := System args at(1)
if(nil == num,
	"Please set the order num by argument! " println,
	"Recursion: " print
	fib := method(num,
		return if(3 > num, return 1, (fib (num - 1)) + (fib (num - 2)))
	)
	fib(num asNumber) println
	
	"Loops: " print
	fib := method(num,
		oldSum := 1
		newSum := 1
		sum := 1
		for(i, 3, num, 1, sum := newSum + oldSum
			oldSum := newSum
			newSum := sum
		)
		return sum
	)
	fib(num asNumber) println
)
