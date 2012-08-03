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

var links = extract_links("http://www.scala-lang.org/")

for(url <- links){
	println(url)
}
