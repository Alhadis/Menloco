FROM    := Menlo
INTO    := Monaco
RESULT  := Menloco

# Paths
OBJDIR       := fonts
SUBSET       := $(OBJDIR)/$(FROM)-subset.ttf
SUBSET_LIST  := glyph-list.txt


# Wipes the slate clean
clean:
	@rm -rf $(wildcard $(OBJDIR)/*)


xml:    $(OBJDIR)/$(FROM).ttx
subset: $(SUBSET)


# Generates an HTML page displaying the generated font and opens it
preview: tests/glyph-test.txt
	@utils/preview-font.pl --old=$(INTO) --new=$(RESULT) --preview-file=$< > $(OBJDIR)/preview.htm
	@open $(OBJDIR)/preview.htm


# Use FontForge to transfer fonts from Menlo into a copy of Monaco
ff-patch:
	@utils/ff-patch.py \
		--from=$(OBJDIR)/$(FROM).ttf \
		--into=$(OBJDIR)/$(INTO).ttf \
		--save-to=$(OBJDIR)/$(RESULT).ttf \
		--glyphs-file=$(SUBSET_LIST) \
		--font-name=$(RESULT)


# Searches the system for a named font file, copying it into the objects directory
$(OBJDIR)/%.ttf:
	@utils/find-font.sh "$*" "$@"


# Subset a range of glyphs designated by "glyph-list.txt"
$(SUBSET): $(SUBSET_LIST)
	sfnttool -s "$$(perl -pe 's/\s//g' < $<)" $(OBJDIR)/$(FROM).ttf $@


# FontTools XML dump
$(OBJDIR)/%.ttx: $(SUBSET)
	ttx -o $@ $<
	perl -p -i -e 's/\x20{2}/\t/g' $@
