#!/usr/bin/env python

import re
import sys

in_file = sys.argv[1]
with open(in_file) as fh:
    raw = fh.readlines()

directions = list(raw[0].strip())
mapping = {}

for line in raw[2:]:
    mx = re.match(r'^(\w{3}) = \((\w{3}), (\w{3})\)', line) 
    mapping.update({mx[1]: {'L': mx[2], 'R': mx[3]}})

pos = 'AAA'
end = 'ZZZ'
steps = 0

while (pos != end):
    turn = directions[steps % len(directions)]
    pos = mapping[pos][turn]
    steps += 1

print(steps)
