#!/usr/bin/env ruby

ary = ('a'..'p').to_a

subary = []
ary.each{|x|
  subary << x
  if subary.size == 4
    puts subary.join(" ")
    subary = []
  end
}
puts subary.join(" ") unless subary.empty?

puts "----"

ary.each_slice(4){|sa|
  puts sa.join(" ")
}
