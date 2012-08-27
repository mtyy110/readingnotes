#!/bin/sh
exec scala "$0" "$@"
!#

import scala.io._
import scala.actors._
import Actor._
import java.net.URL
import scala.util.matching.Regex

// START:loader
object PageLoader {
  val hrefUrlRegex = new Regex("""<a\s+[^>]*\bhref\b\s*=\s*["']?([^'"#\s>][^'"\s>]*)["']?\s*[^>]*\s*>""", "url")
  val rootUrlRegex = new Regex("""^(https?://[^\s/]+).*$""", "rootUrl")
  def getPageString(url: (String, String)): String = {
    if (null != url._2)
    {
      val cs = java.nio.charset.Charset.forName(url._2)
      Source.fromURL(url._1)(io.Codec.apply(cs)).mkString
    }
    else
    {
      Source.fromURL(url._1).mkString
    }
  }

  def getLinkNum(pageString: String): Int = hrefUrlRegex.findAllIn(pageString).length
  def getSizeWithLink(url: (String, String))(pageString: String): Int = {
    val hrefs = hrefUrlRegex.findAllIn(pageString).matchData
    hrefs.foldLeft(pageString.length())((totalSize, u) => {
      val matchUrl = u.group(1)
      var subUrl = ("","")
      var subPageSize = 0
      try {
        
        if (matchUrl.matches("^" + url._1 + ".*$"))
        {
          subUrl = (matchUrl, url._2)
        }
        else if (matchUrl.matches("^https?://.*$"))
        {
          subUrl = (matchUrl, null)
        }
        else
        {
          subUrl = (rootUrlRegex.findFirstMatchIn(url._1).get.group("rootUrl") + "/" + matchUrl, url._2)
        }
        subPageSize = getPageSize(subUrl)
      } catch {
        case _ =>
      }
      totalSize + subPageSize
    })
  }
  
  def getPageSize(url: (String, String)): Int = getPageString(url).length()

  def getPageLinkNum(url: (String, String)): Int = getLinkNum(getPageString(url))
  
  def getPageSizeWithLink(url: (String, String)): Int = {
    val pageString = getPageString(url)
    val hrefs = hrefUrlRegex.findAllIn(pageString).matchData
    getSizeWithLink(url)(pageString)
  }
  def getPageInfo(url: (String, String)): (Int, Int, Int) = {
    val pageString = getPageString(url)
    val pageSize = pageString.length()
    val pageLink = getLinkNum(pageString)
    val totalSize = getSizeWithLink(url)(pageString)
    (pageSize, pageLink, totalSize)
  }
}
// END:loader

val urls = List(
  ("http://www.ubuntu.com/", "UTF-8"),
  ("https://www.githup.com/", "UTF-8"))

// START:time
def timeMethod(method: () => Unit) = {
  val start = System.nanoTime
  method()
  val end = System.nanoTime
  println("Method took " + (end - start) / 1000000000.0 + " seconds.")
}
// END:time

// START:sequential
def getPageSizeSequentially() = {
  for (url <- urls) {
    val pageInfo = PageLoader.getPageInfo(url)
    println(url._1)
    println("Size: " + pageInfo._1)
    println("Links: " + pageInfo._2)
    println("SizeWithLink: " + pageInfo._3)
  }
}
// END:sequential

// START:concurrent
def getPageSizeConcurrently() = {
  val caller = self

  for (url <- urls) {
    actor { caller ! (url._1, PageLoader.getPageInfo(url)) }
  }

  for (i <- 1 to urls.size) {
    receive {
      case (url, (size, linkNum, sizeWithLink)) =>
        println(url)
        println("Size: " + size)
        println("Links: " + linkNum)
        println("SizeWithLink: " + sizeWithLink)
    }
  }
}
// END:concurrent

// START:script
println("Sequential run:")
timeMethod { getPageSizeSequentially }

println("Concurrent run")
timeMethod { getPageSizeConcurrently }

// END:script
