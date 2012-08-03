truthiness := method(a,
  if(a) then ((a .. " is true") println) else ((a .. " is false") println)
)

list(
  true,
  false,
  nil,
  1,
  0,
  list(),
  list(false),
  Map clone,
  "",
  "0",
  "false"
) foreach(a, truthiness(a))



