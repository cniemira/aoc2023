#!/usr/bin/env python

import re
import sys

in_file = sys.argv[1]
with open(in_file) as fh:
    raw = fh.readlines()

readings = []
for line in raw:
    readings.append(
        [int(i) for i in line.strip().split()]
        )

def forecast(vals):
    if set(vals) != set([0]):
        nvals = [b-a for a, b in zip(vals, vals[1:])]
        return vals[-1] + forecast(nvals)
    return 0

summation = 0
for reading in readings:
    proj = forecast(reading)
    summation += proj

print(summation)

