import scala.io._
import scala.actors._
import Actor._

def parse_html(url:String) = {
	val parserFactory = new org.ccil.cowan.tagsoup.jaxp.SAXFactoryImpl
	val parser = parserFactory.newSAXParser()
	val source = new org.xml.sax.InputSource(url)
	val adapter = new scala.xml.parsing.NoBindingFactoryAdapter
	adapter.loadXML(source, parser)
}

def resolve_relative_url(base_url:String, rel_url:String) : String = {
  val u1 = new java.net.URI(base_url)
  u1.resolve(rel_url).toString
}

def extract_links(url:String) = {
	val xmldoc = parse_html(url)
	var links = Set[String]()

  for(a <- (xmldoc \\ "a")){
      a.attribute("href") match {
        case Some(n) => links += resolve_relative_url(url, n.text)
        case None => ()
      }
  }
	links
}

object PageLoader {
	def count_links(url:String) = {
	  val links = extract_links(url)
    links.size
	}
}

def time_method(method: () => Unit) : Unit = {
	val start = System.nanoTime
	val rv = method()
	val end = System.nanoTime
	printf("Took: %.3fs\n", 1.0e-9 * (end-start))
}

val urls = List(
	"http://www.amazon.com/",
  "http://www.twitter.com/",
	"http://www.google.com/",
	"http://www.bbc.co.uk/"
)

def get_link_counts_concurrently() = {
	var caller = self
	for(url <- urls) {
		actor{ caller ! (url, PageLoader.count_links(url)) }
	}
	for(i <- 1 to urls.size) {
	  receive {
      case (url, size) => println("Link count for " + url + ": " + size)
	  }
	}
}

time_method { get_link_counts_concurrently }

// Usage: scala-2.9 -classpath tagsoup-1.2.1.jar day3_link_counter.scala 
