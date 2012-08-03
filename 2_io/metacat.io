# Find the following:
# [+] How to comment
# [+] How to append strings
# [+] How to take arguments for methods
# [+] Default arguments
# [+] How to write object initializers
# [ ] Can initializers take argument?
# [+] Local variables
# [+] method_missing


Cat := Object clone

Cat hello := method(yourname,
  if (yourname isNil) then (yourname = "you") # `if A then B' equivalent to `A and B' ?
  (name .. " meows " .. yourname) println
)

Cat init := method(
  ("Hello init") println
)

# m is argument0, we want (methodname, arg0, arg1, ...)
Cat forward := method(
  m := call message name
  args := call message arguments
  ("I'm just a simple cat, I don't understand what you mean by " .. list(m, args)) println
)

cloud := Cat clone
cloud name := "Cloud the cute kitty"

cloud hello("taw")
cloud hello

cloud jump("very", "high")

cloud perform("hello", "metataw")
cloud performWithArgList("hello", list("metataw"))
