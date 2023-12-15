#!/usr/bin/env python

import re
import sys
import math

in_file = sys.argv[1]
with open(in_file) as fh:
    raw = fh.readlines()

directions = list(raw[0].strip())
mapping = {}
pos = []

for line in raw[2:]:
    mx = re.match(r'^(\w{3}) = \((\w{3}), (\w{3})\)', line) 
    mapping.update({mx[1]: {'L': mx[2], 'R': mx[3]}})
    if mx[1].endswith('A'):
        pos.append(mx[1])

steps_to_z = []
for cpos in pos:
    steps = 0
    while cpos[2] != 'Z':
        turn = directions[steps % len(directions)]
        cpos = mapping[cpos][turn]
        steps += 1
    steps_to_z.append(steps)

print(math.lcm(*steps_to_z))

#
# stupid brute force method:
#
#while True:
#    turn = directions[steps % len(directions)]
#
#    npos = [mapping[p][turn] for p in pos]
#    pos = npos
#    steps += 1
#
#    if set([i[2] for i in pos]) == set('Z'):
#        break
#
#print(steps)

