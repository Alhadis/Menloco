#!/usr/bin/perl
use strict;
use warnings;
use open         qw< :std  :utf8 >;
use charnames    qw< :full >;
use feature      qw< say unicode_strings >;
use Getopt::Long qw< :config auto_abbrev >;
use File::Basename;


# Parse command-line options
my $old          = "";
my $new          = "";
my $preview_file = "";
GetOptions("old=s" => \$old, "new=s" => \$new, "preview-file=s"  => \$preview_file);


# Get the text content we'll use to display the font's preview
open(my $preview_fh, "< :encoding(UTF-8)", $preview_file);
my @preview_lines = <$preview_fh>;
my $preview       = join "", @preview_lines;


# Load the HTML template for displaying/previewing the generated font
chdir(dirname($0));
open(my $template_fh, "< :encoding(UTF-8)", "preview-template.htm");
my @template_lines = <$template_fh>;
my $template       = join "", @template_lines;
my %tokens         = (
	"old"  => $old,
	"new"  => $new,
	"text" => $preview
);
for my $key (sort keys %tokens){
	$template =~ s/\$$key/$tokens{$key}/ge;
}


# Send to STDOUT
print STDOUT "$template\n";
