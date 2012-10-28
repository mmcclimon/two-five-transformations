#!/usr/bin/perl

package TwoFive;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(TF TFT third seventh);

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


sub toString {
    my $self = shift;
    return $self->{r}, " ", $self->{t}, " ", $self->{s};
}


sub TF {
    if (ref $_[0]) {
        my $chord = shift;
        return  TwoFive->new(
                    _mod12 ($chord->{root} + 5),
                    _mod12 ($chord->{seventh} - 1),    
                    _mod12 ($chord->{third}),
               );   
    } else {
        my ($r, $t, $s) = @_;
        return TwoFive->new($r + 5, $s - 1, $t);
    }
}

sub TFT {
    my $chord = shift;
    return  TwoFive->new(
                _mod12 ($chord->{root} - 1),
                _mod12 ($chord->{seventh} + 5),    
                _mod12 ($chord->{third} + 6),
           );
}

sub third {
    my $chord = shift;
    return  TwoFive->new(
                _mod12 ($chord->{root}),
                _mod12 ($chord->{third} - 1),    
                _mod12 ($chord->{seventh}),
           );    
}

sub seventh {
    my $chord = shift;
    return  TwoFive->new(
                _mod12 ($chord->{root}),
                _mod12 ($chord->{third}),    
                _mod12 ($chord->{seventh} - 1),
           );    
}


sub _mod12 {
    my $n = shift;
    return $n % 12;
}



1;