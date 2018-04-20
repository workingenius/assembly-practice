32: 32.o
	ld -macosx_version_min 10.7.0 -o $@ $<

32.o: 32.asm
	nasm -f macho $< -F dwarf



SUBDIRS := $(wildcard */.)

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@



.PHONY: all $(SUBDIRS)

