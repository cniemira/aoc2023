#!/usr/bin/env perl

@num = ();
@sym = ();
$sum = 0;

sub max ($$) { $_[$_[0] < $_[1]] }
sub min ($$) { $_[$_[0] > $_[1]] }

while(<>) {
  $num[$.-1] = ();
  $sym[$.-1] = ();

  while ($_ =~ /(\*)/g) {
    push $sym[$.-1]->@*, $+[0]-1;
  }

  while ($_ =~ /([0-9]+)/g) {
    push $num[$.-1]->@*, [ $+[0]-1, length($1), $1+0 ];
  }
}

for $y (0..@sym) {
  for $x (@{$sym[$y]}) {
    $maxy = min($y+1, $#sym);
    $miny = max($y-1, 0);

    my @matches;
    for ($i=$miny; $i<=$maxy; $i++) {
      for (@{$num[$i]}) {
        ($end, $len, $val) = @$_;
        $minx = max($end - $len, 0);
        $maxx = $end + 1;
        if ($minx <= $x <= $maxx) {
          push @matches, $val;
        }
      }
    }

    if ($#matches == 1) {
      $sum += $matches[0] * $matches[1];
    }

  }
}

print "$sum\n";

