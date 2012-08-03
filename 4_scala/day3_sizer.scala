/*
 * Mostly copypasta from the book
 */

import scala.io._
import scala.actors._
import Actor._

object PageLoader {
	def getPageSize(url:String) = Source.fromURL(url).mkString.length
}

val urls = List(
	"http://www.amazon.com/",
	"http://www.twitter.com/",
	"http://www.google.com/",
	"http://www.cnn.com/"
)

def timeMethod[Alpha](method: () => Alpha) : (Long, Alpha) = {
	val start = System.nanoTime
	val rv = method()
	val end = System.nanoTime
	return (end-start, rv)
}

def getPageSizeSequentially() = {
	for(url <- urls) {
  	println("Size for " + url + ": " + PageLoader.getPageSize(url))
	}
}

def getPageSizeConcurrently() = {
	var caller = self
	for(url <- urls) {
		actor{ caller ! (url, PageLoader.getPageSize(url)) }
	}
	for(i <- 1 to urls.size) {
	  receive {
      case (url, size) => println("Sizze for " + url + ": " + size)
	  }
	}
}

println("Sequential run:")
printf("Took: %.3fs\n", 1.0e-9 * timeMethod{ getPageSizeSequentially }._1)

println("Concurrent run:")
printf("Took: %.3fs\n", 1.0e-9 * timeMethod{ getPageSizeConcurrently }._1)
