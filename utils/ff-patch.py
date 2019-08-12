#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import fontforge
import getopt
import re
import sys


take        = ""
into        = ""
save_to     = ""
glyphs_file = ""
font_name   = ""

# Fetch command-line arguments
try:
	options, args = getopt.getopt(sys.argv[1:], "f:i:s:g:n:", ["from=", "into=", "save-to=", "glyphs-file=", "font-name="])
except getopt.GetoptError:
	usage()
	sys.exit(1)


# Parse their contents
for key, value in options:
	if   key in ("-f", "--from"):         take        = value
	elif key in ("-i", "--into"):         into        = value
	elif key in ("-s", "--save-to"):      save_to     = value
	elif key in ("-g", "--glyphs-file"):  glyphs_file = value
	elif key in ("-n", "--font-name"):    font_name   = value



# List of glyphs to extract from target file
glyphs = open(glyphs_file, "r").read()
glyphs = re.sub(r"\s+", "", glyphs)


# Load both fonts in FontForge
take   = fontforge.open(take)
into   = fontforge.open(into)

# Copy each grapheme individually
for g in glyphs:
	take.selection.select(("unicode",), ord(g))
	take.copy()
	into.selection.select(("unicode",), ord(g))
	into.paste()

	# Match the advance width of inserted glyphs to what the target font has
	# set on the uppercase 'E' glyph
	into[ord(g)].width = into[0x50].width

into.fontname = into.fondname = into.familyname  = into.fullname = font_name
into.generate(save_to)
