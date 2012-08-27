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
		)
	)

	"Before transpose: " println
	twoDimList println

	twoDimList transpose

	"After transpose: " println
	twoDimList println

) catch(Exception,
	"Please input the array's dimensions X and Y." println
)



