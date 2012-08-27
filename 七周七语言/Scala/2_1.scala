#!/bin/sh
exec scala "$0" "$@"
!#

val stringList = List("length7", "len4", "l2")
val len = stringList.foldLeft(0)((len, s) => len + s.length())
println(len)
