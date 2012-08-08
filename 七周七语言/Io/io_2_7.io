#!/usr/bin/env io 

doFile("TwoDimList.io")

try(
	opt := System args at(1)
	filename := System args at(2)
	file := File with(filename)
	if ("w" != opt and "r" != opt, Exception raise)
	if ("w" == opt,
		x := System args at(3) asNumber
		y := System args at(4) asNumber
		twoDimList := TwoDimList clone
		twoDimList dim(x, y)
		for(i, 0, y - 1, 1, 
			for(j, 0, x - 1, 1, 
				twoDimList set(j, i)
			)
		)

		file openForUpdating
		file write(twoDimList asString),

		twoDimList := doFile(filename)
		twoDimList println
	)
	file close

) catch(Exception,
	seq := Sequence clone
	seq appendSeq("Usage: ")
	seq appendSeq(System args at(0))
	seq appendSeq(" w|r filename [num1 num2]")
	seq println
)
