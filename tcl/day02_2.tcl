#!/usr/bin/env tclsh

set sum 0

proc Game {game args} {
  set game [string trimright $game :]
  set n_blue 0
  set n_green 0
  set n_red 0
  foreach token $args {
    set token [string trim $token ,]
    switch $token {
      blue {
        if [expr $number > $n_blue] {
          set n_blue $number
        }
      }
      green {
        if [expr $number > $n_green] {
          set n_green $number
	}
      }
      red {
        if [expr $number > $n_red] {
          set n_red $number
        }
      }
      default {
        set number $token
      }
    }
  }
  upvar sum mysum
  incr mysum [expr $n_blue * $n_green * $n_red]
}

eval [regsub -all {;} [read [open [lindex $argv 0]]] { _}]
puts $sum
