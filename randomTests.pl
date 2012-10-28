#!/usr/bin/perl
use warnings;
use strict;
use v5.10;
use TwoFive;

my $dm = TwoFive->new(2, 5, 0);
say $dm->toString;

my $G7 = TF $dm;
say $G7->toString;

my $gm7 = third $G7;
say $gm7->toString;