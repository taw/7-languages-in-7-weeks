Map atPutNumber := method(
  self atPut(
    call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
    call evalArgAt(1)
  )
)
OperatorTable addAssignOperator(":", "atPutNumber")
curlyBrackets := method(
  rv := Map clone
  call message arguments foreach(arg, rv doMessage(arg))
  rv
)

doString("""
{"foo" : "bar", "hello": "world" } asList println
{1:2, 3:4} asList println
""")

XML := Object clone
XML init := method(
  self name := nil
  self children := list()
  self attrs := Map()
)

XML asString := method(indent,
  if(indent isNil, indent := "")
  attr_str := attrs asList map(kv,
    k := kv at(0)
    v := kv at(1)
    (" " .. k .. "=\"" .. v .. "\"")
  ) join("")
  children_str := (children map(c, c asString(indent .. "  "))) join("")

  if(children size == 0,
    (indent .. "<" .. name .. attr_str .. " />\n"),
    (indent .. "<" .. name .. attr_str .. ">\n" .. children_str .. indent .. "</" .. name .. ">\n")
  )
)

XML forward := method(
  rv := XML clone
  rv name := call message name
  (call message arguments) foreach(arg,
    cn := self doMessage(arg)
    # It should only work for first element, not any
    if (cn isKindOf(Map),
      rv attrs := cn,
      (rv children) append(cn)
    )
  )
  rv
)

doString("""
book := XML book({"title": "7 languages", "author": "Bruce Tate"},
  h1("Programming languages"),
  ul(
    li("Io"),
    li("Lua"),
    li("JavaScript")
  ),
  hr,
  p("These and other awesome programming languages are ", b({"class": "totally"}, "awesome"))
)
book println
""")
