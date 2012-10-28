#!/usr/bin/perl
use warnings;
use strict;
use v5.10;
use TwoFive;

my $dm = TwoFive->new(2, 5, 0);
#say $dm->toString;

my $db7 = TFT $dm;
#say $db7->toString;

say $db7->{r};

say (TF ($dm)->toString);
say (TF (2, 5, 0)->toString);

say (TFT ($dm)->toString);
say (TFT (2, 5, 0)->toString);

say (THIRD (2, 5, 0)->toString);
say $dm->TF->toString;

say $dm->root;
say $dm->third;
say $dm->seventh;

say $dm->getQuality;
say getQuality $dm;
say getQuality (0, 4, 11);