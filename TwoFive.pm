#!/usr/bin/perl

package TwoFive;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(TF);

use warnings;
use strict;

sub new {
    my $class = shift;
    my ($root, $third, $seventh) = @_;
    
    my $self = bless {
        root => $root,
        r => $root,
        third => $third,
        t => $third,
        seventh => $seventh,
        s => $seventh,
    }, $class;
}


sub getHarmString {
    my $self = shift;
    return $self->{r}, " ", $self->{t}, " ", $self->{s};
}


sub TF {
    my $chord = shift;
    return  TwoFive->new(
                _mod12 ($chord->{root} + 5),
                _mod12 ($chord->{seventh} - 1),    
                _mod12 ($chord->{third}),
           );
}



sub _mod12 {
    my $n = shift;
    return $n % 12;
}



1;