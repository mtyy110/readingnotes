#!/bin/sh
exec scala "$0" "$@"
!#

import scala.collection.mutable.HashMap
import scala.io.Source

trait Censor {

  val keywords = new HashMap[String, String]

  def initKeywords(dictFilename: String) = {
    for (line <- Source.fromFile(dictFilename).getLines()) {
      val pair = line.split(',')
      keywords += pair(0) -> pair(1)
    }
  }

  def harmony(origin: String): String = {
    return keywords.foldLeft(origin)((result, pair) => result.replaceAllLiterally(pair._1, pair._2))
  }
}

object TestCensor extends Censor {
  def harmonyByDict(dict: String, sentence: String) {
    initKeywords(dict)
    println(harmony(sentence))
  }
}

TestCensor.harmonyByDict("dict.txt", "Pucky Beans")
