#!/usr/bin/env ruby

nums = []
i = 0
while i < 16
  i = i + 1
  nums.push(i)
end

print "Target array is "
p nums

puts
puts "Method 1: "

i = 0
j = 0
while i < 16
  print "#{nums[i]} "
  j = j + 1
  puts if 0 == j % 4 
  i = i + 1
end


puts
puts "Method 2: "
nums.each_slice(4) {|num| p num}
