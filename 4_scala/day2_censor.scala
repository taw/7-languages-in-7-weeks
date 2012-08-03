import scala.collection.mutable.HashMap

class Censor {
	val replacements : Array[(String,String)] = scala.io.Source.fromFile("censor.txt").getLines.toArray.map(x =>
	  x.split("\t") match {
			case Array(a,b) => (a,b)
			case     _      => throw new Exception("Exactly two elements per line expected")
		}
	)
	val replacement_ht = new HashMap[String,String]()
	replacements foreach(ab => 
		replacement_ht += ab._1 -> ab._2
	)

	val replacement_rx = ("(?i)(" + replacements.map(ab => ab._1).reduceLeft((a,b) => a + "|" + b) + ")").r

	def censor(txt : String) : String = {
		replacement_rx.replaceAllIn(txt, (m =>
			replacement_ht(m.group(1).toLowerCase)
		))
	}
}

val censor = new Censor()
val text = "Shoot the darn pigs!"

println(censor.censor(text))
