Number olddiv := Number getSlot("/")
Number setSlot("/", method(x, 
  if(x == 0, 0, olddiv(x))
))

list(
  2/1,
  4/3,
  3/0
) foreach(x, x println)
