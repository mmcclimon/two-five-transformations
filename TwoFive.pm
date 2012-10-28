#!/usr/bin/perl

package TwoFive;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(TF TFT third seventh);

use warnings;
use strict;
use Scalar::Util qw(blessed);

sub new {
    my $class = shift;
    my ($root, $third, $seventh) = @_;
    
    my $self = bless {
        root => _mod12($root),
        r => _mod12($root),
        third => _mod12($third),
        t => _mod12($third),
        seventh => _mod12($seventh),
        s => _mod12($seventh),
    }, $class;
}


sub toString {
    my $self = shift;
    return $self->{r}, " ", $self->{t}, " ", $self->{s};
}


sub TF {
    if (blessed $_[0]) {
        my $chord = shift;
        return  TwoFive->new($chord->{r} + 5, $chord->{s} - 1, $chord->{t});   
    } else {
        my ($r, $t, $s) = @_;
        return TwoFive->new($r + 5, $s - 1, $t);
    }
}

sub TFT {
    if (blessed $_[0]) {
        my $chord = shift;
        return  TwoFive->new($chord->{r} - 1, $chord->{s} + 5, $chord->{t} + 6);
    } else {
        my ($r, $t, $s) = @_;
        return TwoFive->new($r - 1, $s + 5, $t + 6);
    }
}

sub third {
    if (blessed $_[0]) {
        my $chord = shift;
        return  TwoFive->new($chord->{r}, $chord->{t} - 1, $chord->{s});           
    } else {
        my ($r, $t, $s) = @_;
        return  TwoFive->new($r, $t - 1, $s);           
    }
}

sub seventh {
    if (blessed $_[0]) {
        my $chord = shift;
        return  TwoFive->new($chord->{r}, $chord->{t} - 1, $chord->{s});           
    } else {
        my ($r, $t, $s) = @_;
        return  TwoFive->new($r, $t, $s - 1);           
    }
}


sub _mod12 {
    my $n = shift;
    return $n % 12;
}



1;