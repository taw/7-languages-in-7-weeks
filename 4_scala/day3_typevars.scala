import scala.io._

def timeMethod[Alpha](method: () => Alpha) : (Long, Alpha) = {
	val start = System.nanoTime
	val rv = method()
	val end = System.nanoTime
	return (end-start, rv)
}

def time_page_get (url : String) = {
	val (time, page) = timeMethod[String](() => Source.fromURL(url).mkString)
	printf("Page %s has %s bytes and took %.3fs\n", url, page.size, time*1.0e-9)
}

time_page_get("http://www.cnn.com/")
