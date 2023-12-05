#!/usr/bin/env awk -f

BEGIN {
  FS=":";
  t=0;
}
{
  p=0;
  n=split($2, part, "|");
  n=split(part[1], winners, " ");
  n=split(part[2], entries, " ");
  for (i in entries) {
    for (j in winners) {
      if (entries[i] == winners[j]) {
        if (p > 0) {
          p=p*2;
        } else {
          p=1;
        }
      }
    }
  }
  t=t+p;
}
END {
  print t
}
