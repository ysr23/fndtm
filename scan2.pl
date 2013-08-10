#!/usr/bin/perl
 
open(DEV, '/dev/xvda') or die "Can't open /dev/xvda: $!\n";
 

open(OUT, '>tmp1.txt') or die "Can't open tmp1.txt: $!\n";
 
seek(DEV, 946192864, 0) or die "Can't seek: $!\n";
 
read(DEV, $buf, 40000) or die "Can't read: $!\n";
 
print OUT "$buf\n";
 
 
open(OUT, '>tmp2.txt') or die "Can't open tmp2.txt: $!\n";
 
seek(DEV, 970662368, 0) or die "Can't seek: $!\n";
 
read(DEV, $buf, 40000) or die "Can't read: $!\n";
 
print OUT "$buf\n";
