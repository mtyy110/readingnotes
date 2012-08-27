#!/usr/bin/env io 

try(
	lower := System args at(1) asNumber
	upper := System args at(2) asNumber
	count := System args at(3) asNumber
	if (("nan" == lower asString) or ("nan" == upper asString) or ("nan" == count asString) or (lower > upper) or (1 > count),
		Exception raise
	)

	ans := Random value(lower, upper) asString split(".") at(0) asNumber
	num := 0
	while (num != ans and 0 != count,
		("Please Input a number between "..(lower asString).." and "..(upper asString)..": ") println
		num := ReadLine readLine asNumber
		if ("nan" != num asString and lower <= num and upper >= num,
			if (num > ans, "Greater than the answer." println)
			if (num < ans, "Less than the answer." println)
			if (num == ans, "Equal to the answer." println)
			count := count - 1
		)
	)

	if (num == ans,
		"Well done!" println,
		"Game over." println
	)
) catch(Exception,
	("Usage: "..(System args at(0)).." lowerBound upperBound guessCount.") println
)
