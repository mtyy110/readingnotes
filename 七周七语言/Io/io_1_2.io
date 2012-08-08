#!/usr/bin/env io

obj := Object clone
obj target := method("Hello, Io" println)

obj doString("target")
