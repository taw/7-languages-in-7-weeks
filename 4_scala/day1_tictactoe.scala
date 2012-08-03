class TicTacToe() {
	var grid: Array[Array[Int]] = new Array[Array[Int]](3);
	for(i <- 0 to 2) {
	  grid(i) = new Array[Int](3);
  }
	
	def at(x: Int, y:Int) : Int = {
		return grid(x)(y);
	}

	def set(x: Int, y:Int, v:Int) = {
		grid(x)(y) = v;
	}

	def winning_set(a : Int, b : Int, c : Int) : Int = {
	  if(a != 0 && a == b && a == c) {
	 	  return a;
  	} else {
      return 0;
    }
	}
	def full_grid_covered : Boolean = {
		!grid.exists(row => 
		  row.exists(c => c == 0)
		)
	}

  def winner : Int = {
    var winner = 0;
    for(i <- 0 to 2) {
      winner = winning_set(at(i,0), at(i,1), at(i,2));
      if(winner != 0) return winner;
      winner = winning_set(at(0,i), at(1,i), at(2,i));
      if(winner != 0) return winner;
    }
    winner = winning_set(at(0,0), at(1,1), at(2,2));
    if(winner != 0) return winner;
    winner = winning_set(at(2,0), at(1,1), at(0,2));
    if(winner != 0) return winner;
    if(full_grid_covered) return -1;
		return 0;
  }

  def winner_string : String = {
		if(winner == 1) "The winner is X\n"
		else if(winner == 2) "The winner is O\n"
	  else if(winner == -1) "The game is a tie\n"
		else "There is no winner yet\n"
	}

  override def toString = {
		grid.map(row => 
		  row.map(cell => 
		    if(cell == 0) "   "
		    else if(cell == 1) " x "
		    else " o "
			).reduceLeft((a,b) => a + "|" + b)
		).reduceLeft((a,b) => a + "\n---+---+---\n" + b) + "\n" + winner_string
  }
}

val gridrx = new scala.util.matching.Regex("""^([123]),([123])$""", "x", "y")

val ttt = new TicTacToe()
val current_format = Array(" ", "X", "O")
var current=1

while(ttt.winner == 0){
  print(ttt)
	print("Select your move (format = 1,1 to 3,3) for "+current_format(current)+"\n")
	val line = readLine()
	gridrx findFirstIn line match {
	  case Some(gridrx(x,y)) => {
			val xi = x.toInt-1
			val yi = y.toInt-1
			if(ttt.at(xi,yi) != 0) {
			  print("Cell "+xi+","+yi+" already taken, try another cell\n")
			} else {
			  ttt.set(xi,yi,current)
  		  current = 3 - current
			}
	  }
	  case None => {
	    print("Wrong format `" + line + "', try again\n")
	  }
	}
}
/* 
ttt.set(1,1,1)
ttt.set(2,0,2)
ttt.set(1,2,1)
print(ttt)
*/
