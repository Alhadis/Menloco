FROM    := Menlo
INTO    := Monaco
RESULT  := Menloco

# Paths
OBJDIR       := fonts
SUBSET       := $(OBJDIR)/$(FROM)-subset.ttf
SUBSET_LIST  := glyph-list.txt

# Programs that this makefile relies on to execute its tasks
NEEDED_TOOLS := perl fontforge python
NEEDED_ERROR := "ERROR: One or more required tools are unavailable:\n\t"


# Primary tasks
all:         check merge preview
preview:     $(OBJDIR)/preview.htm
xml:         $(OBJDIR)/$(FROM).ttx
subset:      $(SUBSET)


# Use FontForge to transfer fonts from Menlo into a copy of Monaco
merge: $(OBJDIR)/$(FROM).ttf $(OBJDIR)/$(INTO).ttf
	@utils/ff-patch.py \
		--from=$(OBJDIR)/$(FROM).ttf \
		--into=$(OBJDIR)/$(INTO).ttf \
		--save-to=$(OBJDIR)/$(RESULT).ttf \
		--glyphs-file=$(SUBSET_LIST) \
		--font-name=$(RESULT)


# Generates an HTML page displaying the generated font and opens it
$(OBJDIR)/preview.htm: tests/glyph-test.txt $(OBJDIR)/$(RESULT).ttf
	@utils/preview-font.pl --old=$(INTO) --new=$(RESULT) --preview-file=$< > $@
	@open $@


# Searches the system for a named font file, copying it to the objects directory
$(OBJDIR)/%.ttf:
	@utils/find-font.sh "$*" "$@"


# Subset a range of glyphs designated by "glyph-list.txt"
$(SUBSET): $(SUBSET_LIST)
	sfnttool -s "$$(perl -pe 's/\s//g' < $<)" $(OBJDIR)/$(FROM).ttf $@


# FontTools XML dump
$(OBJDIR)/%.ttx: $(SUBSET)
	ttx -o $@ $<
	perl -p -i -e 's/\x20{2}/\t/g' $@


# Wipe the slate clean
clean:
	@rm -rf $(wildcard $(OBJDIR)/*)


# Verifies the availability of programs needed to run these tasks
check:
	@hash $(NEEDED_TOOLS) 2>/dev/null || { >&2 echo $(NEEDED_ERROR) $(NEEDED_TOOLS); exit 1;  }

.PHONY: clean check
