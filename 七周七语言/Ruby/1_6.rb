#!/usr/bin/env ruby

ans = rand(10)
num = -1

while ans != num
  print "Please input a number between 0 and 9: "
  num = gets().to_i()
  if num.between?(0, 9)
    puts "Greater than the answer." if ans < num
    puts "Less than the answer." if ans > num
    puts "Equal to the answer." if ans == num
  end
end
    

