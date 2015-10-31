#!/usr/bin/env python
# -*- coding: utf-8 -*-
import fontforge
import getopt
import re
import sys


# Set UTF-8 encoding
reload(sys)
sys.setdefaultencoding("utf8")


input       = ""
output      = ""
glyphsFile  = ""
fontName    = ""

# Fetch command-line arguments
try:
	options, args = getopt.getopt(sys.argv[1:], "i:o:g:n:", ["input=", "output=", "glyphs-file=", "font-name="])
except getopt.GetoptError:
	usage()
	sys.exit(1)


# Parse their contents
for key, value in options:
	if   key in ("-i", "--input"):        input       = value
	elif key in ("-o", "--output"):       output      = value
	elif key in ("-g", "--glyphs-file"):  glyphsFile  = value
	elif key in ("-n", "--font-name"):    fontName    = value



# List of glyphs to extract from target file
glyphs = open(glyphsFile, "r").read()
glyphs = unicode(re.sub(ur"\s+", "", glyphs), "utf-8")


# Load both fonts in FontForge
input_font  = fontforge.open(input)
output_font = fontforge.open(output)

# Copy each grapheme individually
for g in glyphs:

	try:
		input_font.selection.select(("unicode",), ord(g))
		input_font.copy()
		output_font.selection.select(("unicode",), ord(g))
		output_font.paste()
	except TypeError:
		print "Fuck this shit"

output_font.fontname    = fontName
output_font.fondname    = fontName
output_font.familyname  = fontName
output_font.fullname    = fontName
output_font.generate(output)
