#!/usr/bin/perl
use strict;
use warnings;
use open         qw< :std  :utf8 >;
use charnames    qw< :full >;
use feature      qw< say unicode_strings >;
use Getopt::Long qw< :config auto_abbrev >;



# Parse command-line options
my $old          = "";
my $new          = "";
my $preview_file = "";
GetOptions("old=s" => \$old, "new=s" => \$new, "preview-file=s"  => \$preview_file);


# Get the text content we'll use to display the font's preview
open(my $preview_fh, "< :encoding(UTF-8)", $preview_file);
my @preview_lines = <$preview_fh>;
my $preview       = join "", @preview_lines;


# Generate the HTML to send to STDOUT
my $template = <<EOF;
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>Font Preview</title>
<style>
\@font-face{ font-family: "$old"; src: url("$old.ttf") format("truetype"); }
\@font-face{ font-family: "$new"; src: url("$new.ttf") format("truetype"); }
body{
	white-space: pre;
	font: 1em/1 "$old";
}
.result{ font-family: "$new"; }
.l{ font-size: 4em; }
</style>
</head>

<body class="result"><div class="s">$preview</div><div class="l">$preview</div></body>
<script>window.onclick=function(){document.body.classList.toggle("result");}</script>
</html>
EOF


print STDOUT "$template\n";
