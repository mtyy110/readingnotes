#!/bin/sh
exec scala "$0" "$@"
!#

class TicTacToe {
  var board: Array[Int] = new Array[Int](9)
  var player = 1

  def play(row: Int, col: Int): Boolean = {
    var result = false
    val index = row * 3 + col
    if (0 == board(index)) {
      board(index) = player
      result = true
    }
    return result
  }

  def checkRow: Boolean = {
    return (player == board(0) && player == board(1) && player == board(2)) || (player == board(3) && player == board(4) && player == board(5)) || (player == board(6) && player == board(7) && player == board(8))
  }

  def checkCol: Boolean = {
    return (player == board(0) && player == board(3) && player == board(6)) || (player == board(1) && player == board(4) && player == board(7)) || (player == board(2) && player == board(5) && player == board(8))
  }

  def checkCross: Boolean = {
    return (player == board(0) && player == board(4) && player == board(8)) || (player == board(2) && player == board(4) && player == board(6))
  }

  def checkTie: Boolean = {
    return -1 == board.indexOf(0)
  }

  def checkBoard: Int = {
    var result = 0

    if (checkRow || checkCol || checkCross) {
      result = player
    } else if (checkTie) {
      result = -1
    } else {
      result = 0
    }

    return result
  }

  def changePlayer() {
    player = player % 2 + 1
  }

  def printBoard() {
    println("  1 2 3")
    for (i <- 0 until 3) {
      print(i + 1)
      for (j <- 0 until 3) {
        var pv = "."
        val rv = board(i * 3 + j)
        print(" ")
        if (1 == rv) {
          pv = "X"
        } else if (2 == rv) {
          pv = "O"
        }
        print(pv)
      }
      println()
    }
  }
}


var game = new TicTacToe
var seps: Array[Char] = Array(',', ' ')

println("Game start, good luck!")
game.changePlayer()
game.printBoard()

do {
  game.changePlayer
  print("Player")
  print(game.player)
  println(", it's your turn!")
  print("Input the grid's ROW No. and COLOMN No. you selected (seperated by comma): ")

  var line = ""
  var row = 0
  var col = 0
  var isOk = false

  do {
    try {
      line = readLine
      val coordinate = line.trim.split(seps)
      if (2 != coordinate.length)
      {
        throw new Exception
      }
      row = coordinate(0).toInt - 1
      col = coordinate(1).toInt - 1
      if (0 <= row && 2 >= row && 0 <= col && 2 >= col) {
        if (game.play(row, col)) {
          isOk = true
        } else {
          print("The grid ")
          print(line)
          print(" has been selected! Please select another one: ")
        }
      } else {
        print("Grid not exist! Please re-input again: ")
      }
    } catch {
      case ex: Exception => print("Input error! Please re-input again: ")
    }
  } while (!isOk)

  game.printBoard()

} while (0 == game.checkBoard);

if (0 < game.checkBoard) {
  print("Congratulations Player")
  print(game.player)
  println(", you Win!")
} else {
  println("Game over, you tied!")
}
