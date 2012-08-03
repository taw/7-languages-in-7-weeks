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
  def get_page_size(url:String) : Int = {
    try {
      Source.fromURL(url).mkString.length
    }
    catch {
      case e  => {
        printf("FAIL: %s\n", e)
        return 0
      }
    }
  }

	def count_link_sizes(url:String) = {
    var caller = self
	  val links = extract_links(url)
	  var total_size : Int = 0
	  for(url2 <- links) {
  	  actor{ caller ! (url2, PageLoader.get_page_size(url2)) }
	  }
  	for(i <- 1 to urls.size) {
  	  receive {
        case (url:String, size:Int) => total_size += size
  	  }
  	}
  	total_size
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

def get_link_sizes_concurrently() = {
	var caller = self
	for(url <- urls) {
		actor{ caller ! (url, PageLoader.count_link_sizes(url)) }
	}
	for(i <- 1 to urls.size) {
	  receive {
      case (url, size) => println("Link size count for " + url + ": " + size)
	  }
	}
}

time_method { get_link_sizes_concurrently }
