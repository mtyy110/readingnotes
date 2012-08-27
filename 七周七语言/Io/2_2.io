#!/usr/bin/env io 

diviend := System args at(1) asNumber
divisor := System args at(2) asNumber

"Before: " println
(diviend / divisor) println

oldSlash := Number getSlot("/")
Number / := method(denominator, 
	return if(0 == denominator, 0,
		call target oldSlash(doMessage(call message argAt(0)))
	)
)

"After: " println
(diviend / divisor) println
