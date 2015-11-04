#!/usr/bin/perl
use warnings;
use strict;
use utf8;

use open    qw< :std  :utf8     >;
use feature qw< say unicode_strings >;

#
# This script assumes supplied input is a newline-separated list of characters
#

my $glyph;
my $codepoint;
while(<>){
	chomp($_);
	$glyph     = $_;
	$codepoint = sprintf "%lx", ord($glyph);
	say "$glyph	U+" . uc $codepoint;
}
