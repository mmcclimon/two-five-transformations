#!/usr/bin/perl
use warnings;
use strict;
use v5.10;
use TwoFive;

=pod
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

say for $dm->toList;

say $dm->getQuality;
say getQuality $dm;
say getQuality (0, 4, 11);
=cut

my $conf = TwoFive->new(5, 9, 4);

my @changes = ($conf);
push @changes, $conf->SEVENTH->THIRD->T(11);
push @changes, $changes[-1]->TF;
push @changes, $changes[-1]->TF->SEVENTH->THIRD;
push @changes, $changes[-1]->TF;
push @changes, $changes[-1]->TF->SEVENTH->THIRD;

say $_->getChordSymbol for @changes;
say "---";
say TwoFive->new("dm7")->TF->TF->T(4)->getChordSymbol;
