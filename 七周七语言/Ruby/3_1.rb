#!/usr/bin/env ruby

module ActsAsCsv
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def acts_as_csv
      include InstanceMethods
    end
  end

  module InstanceMethods
    def read
      @csv_contents = []
      filename = self.class.to_s.downcase + '.txt'
      file = File.new(filename)
      @headers = file.gets.chomp.split(', ' )
      file.each do |row|
        @csv_contents << row.chomp.split(', ' )
      end
    end
    attr_accessor :headers, :csv_contents

    def initialize
      read
    end

    def each(&block)
      @csv_contents.each do |content|
        csvrow = CsvRow.new(@headers, content)
        block.call csvrow
      end
    end
  end
end

class CsvRow
  attr_accessor :headrs, :row
  def initialize(headers=[], row=[])
    @headers = headers
    @row = row
  end

  def method_missing name, *args
    head = name.to_s
    (index = @headers.index(head)) and @row[index]
  end
end

class RubyCsv # no inheritance! You can mix it in
  include ActsAsCsv
  acts_as_csv
end

csv = RubyCsv.new
puts "puts column one"
csv.each {|row| puts row.one}
puts
puts "puts column two"
csv.each {|row| puts row.two}
puts
puts "puts column three"
csv.each {|row| puts row.three}
