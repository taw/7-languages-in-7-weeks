#!/usr/bin/env ruby

if ARGV.empty?
  raise "Need a rexexp argument"
end

rx = Regexp.new(ARGV.shift)

ARGF.each{|line|
  puts line if line =~ rx
}
