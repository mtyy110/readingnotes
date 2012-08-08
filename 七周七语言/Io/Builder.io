#!/usr/bin/env io 

OperatorTable addAssignOperator(":", "putAttribute")
Builder := Object clone

Builder putAttribute := method(
	arg0 := call message argAt(0)
	arg1 := call message argAt(1)
	(Sequence clone appendSeq(arg0) removeSeq("\"") removeSeq(" ")).."="..(arg1)
)

Builder level := 0
Builder isTag := false
Builder isProperty := false
Builder indentNum := 2

Builder indent := method(
	for(i, 1, level, 1, for(j, 1, indentNum, 1, " " print))
)
Builder jumpInto := method(self level := (self level) + 1)
Builder jumpOutto := method(self level := (self level) - 1)

Builder closeTagHead := method( 
	if(self isTag,
		writeln(">")
		self jumpInto
		self isTag := false
	)
)
Builder forward := method(
	self closeTagHead
	isFirstValue := true
	self indent
	("<"..(call message name)) print
	self isTag := true
	call message arguments foreach(
		arg, 
		content := self doString(arg asString)
		if(self isProperty, 
			content print
			self isProperty := false,
			if(isFirstValue, 
				self closeTagHead 
				isFirstValue := false
			)
			if(content type == "Sequence",
				self indent
				writeln(content)
			)
		)
	)
	self closeTagHead
	self jumpOutto
	self indent
	writeln("</", call message name, ">")
)

Builder curlyBrackets := method(
	self isProperty = true
	ret := Sequence clone
	call message arguments foreach(arg, 
		attr := self doMessage(arg)
		ret appendSeq(" "..(attr))
	)
	ret
)
