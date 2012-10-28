#!/usr/bin/perl
use warnings;
use strict;
use v5.10;
use TwoFive;

my $dm = TwoFive->new(2, 5, 0);
say $dm->getHarmString;

say ((TF $dm)->getHarmString);