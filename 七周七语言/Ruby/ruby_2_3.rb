#!/usr/bin/env ruby

def filename
  "ruby_2_2.rb"
end

def keyword
  "vi"
end

line_no = 0
file = IO.readlines(filename)
file.each do |line_content|
  line_no = line_no + 1
  puts "#{line_no}: #{line_content}" if line_content.include?(keyword)
end
