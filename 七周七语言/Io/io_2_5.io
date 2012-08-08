#!/usr/bin/env io 

doFile("TwoDimList.io")

try(
	x := System args at(1) asNumber
	y := System args at(2) asNumber

	twoDimList := TwoDimList clone
	twoDimList dim(x, y)

	for(i, 0, y - 1, 1, 
		for(j, 0, x - 1, 1, 
			twoDimList set(j, i)
			seq := Sequence clone
			seq appendSeq("Index (")
			seq appendSeq(j)
			seq appendSeq(", ")
			seq appendSeq(i)
			seq appendSeq(") ")
			seq appendSeq("is ")
			seq appendSeq(twoDimList get(j, i))
			seq println
		)
	)

	twoDimList println

) catch(Exception,
	"Please input the array's dimensions X and Y." println
)
