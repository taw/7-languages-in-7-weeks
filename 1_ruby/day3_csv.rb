#!/usr/bin/env ruby

class CsvRow
  def initialize(headers, values)
    @ht = Hash[headers.zip(values)]
    
  end
  def method_missing(m)
    if @ht.include?(m)
      @ht[m]
    else
      super
    end
  end
end


class RubyCSV
  include Enumerable
  
  def initialize(path)
    @data = File.readlines(path).map{|line| line.chomp.split(/\s*,\s*/)}
    @headers = @data.shift.map(&:to_sym)
  end
  
  def each
    @data.each{|cells|
      yield CsvRow.new(@headers, cells)
    }
  end
end

csv = RubyCSV.new('sample.txt')
csv.each{|row| puts row.one}
