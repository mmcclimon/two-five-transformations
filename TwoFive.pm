#!/usr/bin/perl

package TwoFive;
use Exporter;

@ISA = qw(Exporter);
@EXPORT = qw(TF TFT THIRD SEVENTH getQuality);

use warnings;
use strict;
use Scalar::Util qw(blessed looks_like_number);
use Carp;

sub new {
    my $class = shift;
    return &newFromChordSymbol(@_) if (!looks_like_number($_[0]));

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

sub toList {
    my $self = shift;
    return ($self->{r}, $self->{t}, $self->{s});
}


sub TF {
    return &_makeWithFunc(sub { my ($r, $t, $s) = @_;
                                return ($r + 5, $s - 1, $t);
                              }, @_);
}

sub TFT {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                return ($r - 1, $s + 5, $t + 6);
                               }, @_);
}

sub THIRD {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                 return ($r, $t-1, $s)
                               }, @_);
}

sub SEVENTH {
    return &_makeWithFunc( sub { my ($r, $t, $s) = @_;
                                 return ($r, $t, $s-1)
                               }, @_);
}

sub T {
    my ($self, $tNum) = @_;
    my @new;
    push @new, _mod12($_ + $tNum) for ($self->toList);
    return TwoFive->new(@new);
}

sub root { return $_[0]->{r} if (blessed $_[0]); }
sub third { return $_[0]->{t} if (blessed $_[0]); }
sub seventh { return $_[0]->{s} if (blessed $_[0]); }

sub getQuality {
    my ($r, $t, $s) = (blessed $_[0]) ? ($_[0]->{r}, $_[0]->{t}, $_[0]->{s})
                                      : @_;
    my $qual3 = _mod12 ($t - $r);
    my $qual7 = _mod12 ($s - $r);
    return "min7" if ($qual3 == 3 && $qual7 == 10);
    return "dom7" if ($qual3 == 4 && $qual7 == 10);
    return "maj7" if ($qual3 == 4 && $qual7 == 11);
    return "unknown";
}

{
    no warnings qw(qw);
    my %numRoots = qw(0 C 1 C#/Db 2 D 3 D#/Eb 4 E 5 F 6 F#/Gb 7 G 8 Ab 9 A 10 Bb 11 B);
    my %noteRoots = qw(C 0 C# 1 Db 1 D 2 D# 3 Eb 3 E 4 F 5 F# 6 Gb 6 G 7 
                       G# 8 Ab 8 A 9 A# 10 Bb 10 B 11);
                       
    sub getChordSymbol {
        my $self = shift;
        my $root = $numRoots{$self->{r}};
        my $suffix = $self->getQuality;
        if ($suffix eq "min7") { $suffix = 'm7' }
        elsif ($suffix eq "maj7") { $suffix = 'M7' }
        elsif ($suffix eq "dom7") { $suffix = '7' }
        else { $suffix = "?" }
        return $root . $suffix;
    }
    
    sub newFromChordSymbol {
        my @letters = split //, shift;
        my $root = uc shift @letters;
        $root .= shift @letters if ($letters[0] =~ /^[b#]$/);
        my $rootNum = $noteRoots{$root};
        my $suffix = join '', @letters;
        
        my @chordTones = ($rootNum);
        if ($suffix eq 'm7') { push @chordTones, ($rootNum + 3, $rootNum + 10) }
        elsif ($suffix eq '7') { push @chordTones, ($rootNum + 4, $rootNum + 10) }
        elsif ($suffix eq 'M7') { push @chordTones, ($rootNum + 4, $rootNum + 11) }
        else { croak "Unrecognized chord symbol given"; }
        return TwoFive->new(@chordTones);
        
        
    }
}
# takes coderef and either a blessed ref or a list
sub _makeWithFunc {
    my $func = shift;
    my ($r, $t, $s) = (blessed $_[0]) ? ($_[0]->{r}, $_[0]->{t}, $_[0]->{s})
                                      : @_;
    return TwoFive->new($func->($r, $t, $s));
}

sub _mod12 {
    my $n = shift;
    return $n % 12;
}



1;