#!/usr/bin/env io 

TwoDimList := List clone

TwoDimList dim := method(x, y, 
	self removeAll
	self dim1 := y
	self dim2 := x
	for(i, 0, y - 1, 1,
		self append(list())
		for(j, 0, x - 1, 1,
			self at(i) append(0)
		)
	)
)

TwoDimList transpose := method(
	oldDimList := self clone
	self dim((oldDimList dim1), (oldDimList dim2))
	for(i, 0, (self dim2) - 1, 1, 
		for(j, 0, (self dim1) - 1, 1, 
			self setValue(i, j, (oldDimList get(j, i))) 
		)
	)
)

TwoDimList set := method(x, y, 
	self setValue(x, y, y * dim2 + x)
)

TwoDimList setValue := method(x, y, value,
	self at(y) removeAt(x)
	self at(y) insertAt(value, x)
)

TwoDimList get := method(x, y, return self at(y) at(x))
