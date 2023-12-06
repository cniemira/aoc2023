#!/usr/bin/env python3
from functools import reduce


times = (7, 15, 30)
dists = (9, 40, 200)
#times = (35, 93, 73, 66)
#dists = (212, 2060, 1201, 1044)

wins = []

for n_race in range(0, len(times)):
    this_time = times[n_race]
    this_dist = dists[n_race]
    win_opts = 0

    for i in range(1, this_time):
        travel = (this_time - i) * i
        if travel > this_dist:
            win_opts += 1

    wins.append(win_opts)

print(reduce(lambda x, y: x*y, wins))


