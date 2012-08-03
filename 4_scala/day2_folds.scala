val list_of_strings = List(
	"hello", "world", "and", "magickality"
)
println(list_of_strings.foldLeft(0)((sum,str) => sum + str.size))
printf("Expected - %d\n", 24)



