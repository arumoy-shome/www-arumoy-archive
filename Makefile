SRCFILES:= $(wildcard *.md)
PUBFILES=$(SRCFILES:.md=.html)

%.html: %.md
	pandoc --template=public -o docs/$@ $<

publish: $(PUBFILES)

clean:
	rm $(PUBFILES)

.PHONY: publish clean
