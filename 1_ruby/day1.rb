#!/usr/bin/env ruby

puts "Hello, world."

puts "Hell, Ruby.".index("Ruby")

10.times{ puts "taw" }

(1..10).each{|i| puts "This is sentence number #{i}." }

puts "Guess a number"
correct = rand(10)
while true
  guess = STDIN.readline.to_i
  if guess == correct
    puts "Correct"
    break
  elsif guess > correct
    puts "Lower"
  else
    puts "Higher"
  end
end
  