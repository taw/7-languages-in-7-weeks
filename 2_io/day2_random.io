random := method(min,max,
  f := File open("/dev/urandom")
  data := f readStringOfLength(16)
  f close
  range_size := max-min+1
  cur := 0
  data foreach(a,
    cur = (cur + a) % range_size
  )
  min + cur
)

num := random(1,100)

"Guess a number 1 to 100" println
for(i,1,10,
  guess := File standardInput readLine asNumber
  if(guess == num) then(
    "You win!" println
    break
  )
  if(guess > num) then(
    "Colder" println
  )
  if(guess < num) then(
    "Hotter" println
  )
)
("Number is " .. num) println