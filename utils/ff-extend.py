#!/usr/bin/env python3
import fontforge
import re
import sys


# Assign a new name to the font
def setFontName(font, name):
	font.fontname = font.fondname = font.familyname = font.fullname = name;
	return font;


# Return the Y ordinates of the highest/lowest points in a glyph
def getExtents( glyph ):
	min = 0;
	max = 0;

	for layer in glyph.layers:
		for contour in glyph.layers[layer]:
			for point in contour:

				if point.y < min:
					min = point.y;
				elif point.y > max:
					max = point.y;

	return [min, max];


# Nudge the Y-position of a glyph's outer-most points
def offsetEdge( edges, glyph, offset ):
	(minY, maxY) = getExtents(glyph);

	for layerName in glyph.layers:
		layer = glyph.layers[layerName];

		for contour in layer:
			for point in contour:

				if (OFFSET_BOTTOM & edges) and point.y <= minY:
					point.y -= offset;
				if (OFFSET_TOP & edges) and point.y >= maxY:
					point.y += offset;


		glyph.layers[layerName] = layer;

# Offset all points' y-values of a glphy
def offsetY( glyph, offset ):
	for layerName in glyph.layers:
		layer = glyph.layers[layerName];

		for contour in layer:
			for point in contour:
				point.y += offset;

		glyph.layers[layerName] = layer;


f = fontforge.open(sys.argv[1]);
OFFSET_BOTTOM   = 1;
OFFSET_TOP      = 2;
OFFSET_BOTH     = 3;
charMap = {
	0x2502: OFFSET_BOTH,
	0x2503: OFFSET_BOTH,
	0x2506: OFFSET_BOTH,
	0x2507: OFFSET_BOTH,
	0x250A: OFFSET_BOTH,
	0x250B: OFFSET_BOTH,
	0x250C: OFFSET_BOTTOM,
	0x250D: OFFSET_BOTTOM,
	0x250E: OFFSET_BOTTOM,
	0x250F: OFFSET_BOTTOM,
	0x2510: OFFSET_BOTTOM,
	0x2511: OFFSET_BOTTOM,
	0x2512: OFFSET_BOTTOM,
	0x2513: OFFSET_BOTTOM,
	0x2514: OFFSET_TOP,
	0x2515: OFFSET_TOP,
	0x2516: OFFSET_TOP,
	0x2517: OFFSET_TOP,
	0x2518: OFFSET_TOP,
	0x2519: OFFSET_TOP,
	0x251A: OFFSET_TOP,
	0x251B: OFFSET_TOP,
	0x251C: OFFSET_BOTH,
	0x251D: OFFSET_BOTH,
	0x251E: OFFSET_BOTH,
	0x251F: OFFSET_BOTH,
	0x2520: OFFSET_BOTH,
	0x2521: OFFSET_BOTH,
	0x2522: OFFSET_BOTH,
	0x2523: OFFSET_BOTH,
	0x2524: OFFSET_BOTH,
	0x2525: OFFSET_BOTH,
	0x2526: OFFSET_BOTH,
	0x2527: OFFSET_BOTH,
	0x2528: OFFSET_BOTH,
	0x2529: OFFSET_BOTH,
	0x252A: OFFSET_BOTH,
	0x252B: OFFSET_BOTH,
	0x252C: OFFSET_BOTTOM,
	0x252D: OFFSET_BOTTOM,
	0x252E: OFFSET_BOTTOM,
	0x252F: OFFSET_BOTTOM,
	0x2530: OFFSET_BOTTOM,
	0x2531: OFFSET_BOTTOM,
	0x2532: OFFSET_BOTTOM,
	0x2533: OFFSET_BOTTOM,
	0x2534: OFFSET_TOP,
	0x2535: OFFSET_TOP,
	0x2536: OFFSET_TOP,
	0x2537: OFFSET_TOP,
	0x2538: OFFSET_TOP,
	0x2539: OFFSET_TOP,
	0x253A: OFFSET_TOP,
	0x253B: OFFSET_TOP,
	0x253C: OFFSET_BOTH,
	0x253D: OFFSET_BOTH,
	0x253E: OFFSET_BOTH,
	0x253F: OFFSET_BOTH,
	0x2540: OFFSET_BOTH,
	0x2541: OFFSET_BOTH,
	0x2542: OFFSET_BOTH,
	0x2543: OFFSET_BOTH,
	0x2544: OFFSET_BOTH,
	0x2545: OFFSET_BOTH,
	0x2546: OFFSET_BOTH,
	0x2547: OFFSET_BOTH,
	0x2548: OFFSET_BOTH,
	0x2549: OFFSET_BOTH,
	0x254A: OFFSET_BOTH,
	0x254B: OFFSET_BOTH,
	0x254E: OFFSET_BOTH,
	0x254F: OFFSET_BOTH,
	0x2551: OFFSET_BOTH,
	0x2552: OFFSET_BOTTOM,
	0x2553: OFFSET_BOTTOM,
	0x2554: OFFSET_BOTTOM,
	0x2555: OFFSET_BOTTOM,
	0x2556: OFFSET_BOTTOM,
	0x2557: OFFSET_BOTTOM,
	0x2558: OFFSET_TOP,
	0x2559: OFFSET_TOP,
	0x255A: OFFSET_TOP,
	0x255B: OFFSET_TOP,
	0x255C: OFFSET_TOP,
	0x255D: OFFSET_TOP,
	0x255E: OFFSET_BOTH,
	0x255F: OFFSET_BOTH,
	0x2560: OFFSET_BOTH,
	0x2561: OFFSET_BOTH,
	0x2562: OFFSET_BOTH,
	0x2563: OFFSET_BOTH,
	0x2564: OFFSET_BOTTOM,
	0x2565: OFFSET_BOTTOM,
	0x2566: OFFSET_BOTTOM,
	0x2567: OFFSET_TOP,
	0x2568: OFFSET_TOP,
	0x2569: OFFSET_TOP,
	0x256A: OFFSET_BOTH,
	0x256B: OFFSET_BOTH,
	0x256C: OFFSET_BOTH,
	0x256D: OFFSET_BOTTOM,
	0x256E: OFFSET_BOTTOM,
	0x256F: OFFSET_TOP,
	0x2570: OFFSET_TOP,
	0x2575: OFFSET_TOP,
	0x2577: OFFSET_BOTTOM,
	0x2579: OFFSET_TOP,
	0x257B: OFFSET_BOTTOM,
	0x257D: OFFSET_BOTH,
	0x257F: OFFSET_BOTH
};

triangleCharacters = [
	0x25b6,
	0x25b7,
	0x25c0,
	0x25c1,
]

for char in charMap:
	offsetEdge(charMap[char], f[char], float(sys.argv[2]));

for char in triangleCharacters:
	offsetY(f[char], float(sys.argv[3]));

f.generate(sys.argv[1]);
f.close();
