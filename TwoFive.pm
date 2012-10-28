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
    return &_makeWithFunc(sub { my ($r, $t, $s) = @_;
                                return TwoFive->new($r + 5, $s - 1, $t);
                              }, @_);
}

sub TFT {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                return TwoFive->new($r - 1, $s + 5, $t + 6);
                               }, @_);
}

sub third {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                 return TwoFive->new($r, $t-1, $s)
                               }, @_);
}

sub seventh {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                 return TwoFive->new($r, $t, $s-1)
                               }, @_);
}


# takes coderef and either a blessed ref or a list
sub _makeWithFunc {
    my $func = shift;
    my ($r, $t, $s) = (blessed $_[0]) ? ($_[0]->{r}, $_[0]->{t}, $_[0]->{s})
                                      : @_;
    return $func->($r, $t, $s);
}

sub _mod12 {
    my $n = shift;
    return $n % 12;
}



1;