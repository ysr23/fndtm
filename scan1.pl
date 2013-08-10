#!/usr/bin/perl

open(DEV, '/dev/xvda') or die "Can't open: $!\n";

while (read(DEV, $buf, 4096)) {
  print tell(DEV), "\n", $buf, "\n"
    if $buf =~ /screw/;
}
