#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import fontforge
import getopt
import sys
import re


font_file   = ""
save_to     = ""
glyphs_file = ""


# Get options from command-line
try:
	options, args = getopt.getopt(sys.argv[1:], "f:s:g", ["font-file=", "save-to=", "glyphs-file="])
except getopt.GetoptError:
	usage()
	sys.exit(1)


# Store their values
for key, value in options:
	if   key in ("-f", "--font-file"):    font_file   = value
	elif key in ("-s", "--save-to"):      save_to     = value
	elif key in ("-g", "--glyphs-file"):  glyphs_file = value


# List of glyphs to extract from specified font
glyphs = open(glyphs_file, "r").read()
glyphs = unicode(re.sub(ur"\s+", "", glyphs), "utf-8")


# Open the subject file in FontForge
f = fontforge.open(font_file)

for g in glyphs:
	codepoint = ord(g)
	f[codepoint].export(save_to + "/" + str(codepoint) + ".svg")

f.close()
