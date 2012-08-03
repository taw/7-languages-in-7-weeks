# http://pastebin.com/D6CPKH9B
Matrix := Object clone

Matrix init := method(
  self contents := list()
  self xsize := 0
  self ysize := 0
)

Matrix dim := method(x,y,
  contents = list()
  xsize = x
  ysize = y
  for(i,1,x,
    row := list()
    for(j,1,y,
      row append(0)
    )
    contents append(row)
  )
  self
)
# Oracle will sue me for this
Matrix range_check := method(x,y,
  if(x<1 or y<1 or x>xsize or y>ysize, Exception raise("[" .. x .. "," .. y .. "] out of bonds of matrix"))
)
Matrix get := method(x,y,
  range_check(x,y)
  contents at(x-1) at(y-1)
)
Matrix set := method(x,y,v,
  range_check(x,y)
  contents at(x-1) atPut(y-1,v)
)
Matrix asString := method(
  contents map(row,
    "[" .. (row join(" ")) .. "]"
  ) join("\n")
)
Matrix foreach := method(
  # like method(xi,yi,vi,blk,...)
  # except we do not want to evaluate it
  args := call message arguments
  xi := args at(0) name
  yi := args at(1) name
  vi := args at(2) name
  msg :=  args at(3)
  ctx := Object clone
  ctx setProto(call sender)
  for(i,1,xsize,
    for(j,1,ysize,
      ctx setSlot(xi, i)
      ctx setSlot(yi, j)
      ctx setSlot(vi, get(i,j))
      msg doInContext(ctx)
    )
  )
)
Matrix transpose := method(
  rv := Matrix clone dim(ysize, xsize)
  foreach(x,y,v,
    rv set(y,x,v)
  )
  rv
)

Matrix saveAs := method(path,
  file := File open(path)
  file write(asString, "\n")
  file close
)
Matrix loadFrom := method(path,
  file := File open(path)
  lines := file readLines map(line,
    line removeSuffix("\n") removeSuffix("]") removePrefix("[") split(" ") map(x, x asNumber)
  )
  ysize := lines size
  xsize := lines at(0) size
  rv := Matrix clone dim(xsize, ysize)
  for(i,1,xsize,
    for(j,1,ysize,
      rv set(i,j,lines at(j-1) at(i-1))
  ))
  rv
)


new_matrix := Matrix clone dim(2,3)

new_matrix println
new_matrix contents println

new_matrix set(1,1, 10)
new_matrix set(1,2, 20)
new_matrix set(1,3, -30)
new_matrix set(2,1, 15)
# (2,2) defaults to 0
new_matrix set(2,3, 5)

"Matrix looks like this:" println
new_matrix println

"\nPrinted cell by cell:" println
new_matrix foreach(a,b,c,
  ("Matrix[" .. a .. "," .. b .. "]=" .. c) println
)

"\nTransposed:" println
new_matrix transpose println
new_matrix saveAs("matrix.txt")

matrix2 := Matrix loadFrom("matrix.txt")

"\nLoaded:" println
matrix2 println
