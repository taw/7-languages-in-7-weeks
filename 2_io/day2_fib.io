fib1 := method(n,
  if(n <= 2, return 1)
  return(fib1(n-1) + fib1(n-2))
)

fib2 := method(n,
  fa := 0
  fb := 1
  t := 0
  for(j,1,n,
    (
      t  = fb
      fb = fa + fb
      fa = t
    )
  )
  return fa
)

for(i,1,10,("fib1(" .. i ..")=" .. fib1(i)) println)
for(i,1,10,("fib2(" .. i ..")=" .. fib2(i)) println)
