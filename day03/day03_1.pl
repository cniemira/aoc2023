#!/usr/bin/env perl

@num = ();
@sym = ();
$sum = 0;

sub max ($$) { $_[$_[0] < $_[1]] }
sub min ($$) { $_[$_[0] > $_[1]] }

while(<>) {
  $num[$.-1] = ();
  $sym[$.-1] = ();

  while ($_ =~ /([^.0-9\s])/g) {
    push $sym[$.-1]->@*, $+[0]-1;
  }

  while ($_ =~ /([0-9]+)/g) {
    push $num[$.-1]->@*, [ $+[0]-1, length($1), $1+0 ];
  }
}

for $i (0..@num) {
  for (0..$#{$num[$i]}) {
    ($end, $len, $val) = @{$num[$i][$_]};

    $x = $end - $len + 1;
    $y = $i; 

    $maxx = $end + 1;
    $minx = max($end - $len, 0);
    $maxy = min($y+1, $#sym);
    $miny = max($i-1, 0);

    my @matches;
    for ($j = $miny; $j <= $maxy; $j++) {
      my %filtered;
      map {$filtered{$_}++} (@{$sym[$j]}, ($minx..$maxx));
      for (keys %filtered) {
        push @matches, $_ if $filtered{$_} > 1;
      }
    }

    if (!$#matches) {
      $sum += $val;
    }
  }
}

print "$sum\n";

