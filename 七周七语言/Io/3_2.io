#!/usr/bin/env io 

curlyBrackets := method(
	l := List clone
	call message arguments foreach(arg,
		a := doMessage(arg)
		l append(a)
	)
	return l
)

doFile("CurlyBracketList.txt") println
