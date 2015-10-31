# Font files to read from/write to
INPUT         := fonts/input/Menlo.ttc
OUTPUT        := fonts/output/Monaco.ttf
GLYPHS_FILE   := glyph-list.txt
FONT_NAME     := "Monaco Stitched"


all: patch

patch:
	@./patch.py --input=$(INPUT) --output=$(OUTPUT) --glyphs-file=$(GLYPHS_FILE) --font-name=$(FONT_NAME)
