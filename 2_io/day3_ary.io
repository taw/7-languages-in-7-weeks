squareBrackets := method(
  rv := list()
  call message arguments foreach(a,
    rv append(doMessage(a))
  )
  rv
)

doString("""
[1, 42, "foo", [5, 7]]
""") println
