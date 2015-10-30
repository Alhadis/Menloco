#!/usr/bin/perl

#
# Tiny utility to quickly swap the stroke styles of box-drawing characters
#

use warnings;
use strict;
use utf8;
use open        qw< :std  :utf8	>;
use charnames   qw< :full >;
use feature     qw< unicode_strings say >;
use Getopt::Long qw(:config auto_abbrev);
use Data::Dumper;


my $weight  = "light";
my $dashes  = 0;
my $rounded = 0;

GetOptions(
	"weight=s"  => \$weight,
	"dashes=n"  => \$dashes,
	"rounded"   => \$rounded
);

$weight = "light" if $rounded;  # Force light-weight if rounding corners
$dashes = 0 if $dashes < 2;     # Ignore --dashes if given a value less than 2
$dashes = 4 if $dashes > 4;     # Clamp dashes to 4, no more

my %weights = (
	light       => qw<   ─│┌┐└┘├┤┬┴┼╴╶╷╵   >,
	heavy       => qw<   ━┃┏┓┗┛┣┫┳┻╋╸╺╻╹   >,
	double      => qw<   ═║╔╗╚╝╠╣╦╩╬╴╶╷╵   >
);

my %dashes = (
	light_2     => qw<   ╌╎   >,
	light_3     => qw<   ┄┆   >,
	light_4     => qw<   ┈┊   >,
	heavy_2     => qw<   ╍╏   >,
	heavy_3     => qw<   ┅┇   >,
	heavy_4     => qw<   ┉┋   >
);


# Concatenation of all stroke characters
my @weight_parts = (values %weights);
my @dash_parts   = (values %dashes);


# Cycle through each line of input and modify the stroke styles
my $line;
while(<>){
	$line = $_;
	
	# Unify the weights and dashes for easier matching
	foreach(@weight_parts){ eval "\$line =~ tr/$_/$weights{'light'}/"; };
	foreach(@dash_parts){   eval "\$line =~ tr/$_/─│/"; };
	
	# Apply dashes if we're not using a double-edged weight
	if($dashes && "double" ne $weight){
		eval "\$line =~ tr/─│/$dashes{$weight.'_'.$dashes}/";
	}

	# Now set the desired weight
	eval "\$line =~ tr/$weights{'light'}/$weights{$weight}/";
	
	# Add round corners if told to (light weight only)
	$line =~ tr/┌┐└┘/╭╮╰╯/ if $rounded;
	
	print $line;
}
