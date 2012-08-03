List myAverage := method(
  if(size == 0, return(0))
  foreach(x, (
    x isKindOf(Number) else(Exception raise(x .. " is not a number, cannot average"))
  ))
  sum / size
)

list(1,2,6) myAverage println
list() myAverage println
list(2,"fail") myAverage println
