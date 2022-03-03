# Taken from <https://gist.github.com/kristopherjohnson/7466917>
# Converts Markdown to other formats (HTML, PDF, DOCX, RTF, ODT, EPUB) using Pandoc
# <http://johnmacfarlane.net/pandoc/>
#
# Run "make" (or "make all") to convert to all other formats
#
# Run "make clean" to delete converted files

# Convert all files in this directory that have a .md suffix
SRCFILES:= $(wildcard *.md)
PUBFILES=$(SRCFILES:.md=.html)

%.html: %.md
	pandoc --template=public -o docs/$@ $<

# Targets and dependencies

.PHONY: all clean

all : $(PUBFILES)

clean:
	- rm $(PUBFILES)
