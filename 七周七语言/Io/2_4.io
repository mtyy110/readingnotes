#!/usr/bin/env io 

List myAverage := method(
	total := 0
	self foreach (value,
		if((value type) == (Number type),
			total = value + total,
			str := Sequence clone
			str appendSeq("Index ")
			str appendSeq(i)
			str appendSeq(": ")
			str appendSeq(value)
			str appendSeq(" is NOT number!")
			Exception raise(str)
		)
	)
	return total / (self size)
)


target := doString(System args at(1))
if((target type) == (List type),
	target myAverage println,
	"Please input a list." println
)
