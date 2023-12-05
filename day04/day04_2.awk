#!/usr/bin/env awk -f

BEGIN {
  FS=":";
  t=0;
}
{
  cards[NR]++;
  w=0;
  n=split($2, part, "|");
  n=split(part[1], winners, " ");
  n=split(part[2], entries, " ");
  for (i in entries) {
    for (j in winners) {
      if (entries[i] == winners[j]) {
        w=w+1;
      }
    }
  }

  for (i=cards[NR]; i > 0; i--) {
    for (j=1; j<=w; j++) {
      x = NR+j;
      if (cards[x] > 0) {
        cards[x]++;
      } else {
        cards[x]=1;
      }
    }
  }

  t=t+cards[NR]
}
END {
  print t
}
