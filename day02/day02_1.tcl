#!/usr/bin/env tclsh

set sum 0

proc Game {game args} {
  set game [string trimright $game :]
  set number 0
  foreach token $args {
    set token [string trim $token ,]
    switch $token {
      blue {
       if [expr $number > 14] {
         return
       }
      }
      green {
        if [expr $number > 13] {
         return
	}
      }
      red {
        if [expr $number > 12] {
         return
        }
      }
      default {
        set number $token
      }
    }
  }
  upvar sum mysum
  incr mysum $game
}

eval [regsub -all {;} [read [open [lindex $argv 0]]] { _}]
puts $sum
