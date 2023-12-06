#!/usr/bin/env python3

this_time = 71530
this_dist = 940200
#this_time = (35937366)
#this_dist = (212206012011044)

winc = 0

for i in range(1, this_time):
    travel = (this_time - i) * i
    if travel > this_dist:
        winc += 1

print(winc)

