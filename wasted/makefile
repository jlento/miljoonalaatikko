SHELL=/bin/bash
DESTDIR = $(PWD)

srcdir  = ./src
datadir = ./data
vpath %.txt $(datadir)
vpath %.md  $(srcdir)

bindir  = $(DESTDIR)/bin
libdir  = $(DESTDIR)/lib

PROG = wasted
LIBS = myproviders.bash nosql.bash
DATA = squeue.txt apstat.txt

TESTENV = SQUEUE="cat $(datadir)/squeue.txt" \
          APSTAT="cat $(datadir)/apstat.txt"

.PHONY: all build test install install-libs install-exe clean realclean

all: build test install

build: $(PROG).bash $(LIBS)

test: $(PROG).bash $(LIBS) $(DATA)
	$(TESTENV) $(SHELL) $<

install: install-libs install-exe

install-exe: $(bindir)/$(PROG)

install-libs: $(LIBS:%=$(libdir)/%)

$(bindir)/$(PROG): $(PROG).bash
	mkdir -p "$(bindir)"
	sed -r -e "1 s|\$$|\nLIBDIR=$(libdir)|" $< > $@
	chmod u+rwx $@

$(libdir)/%.bash : %.bash
	mkdir -p "$(libdir)"
	cp -f $< $@

%.bash : %.md
	awk '/```bash/{f=1;next} /```/{f=0} f' $< > $@

clean :
	find . -name '*~' -delete
	rm -f $(PROG) $(LIBS) $(PROG).bash

uninstall: clean
	rm -f $(bindir)/$(PROG) $(addprefix $(libdir)/,$(LIBS))
	rmdir $(bindir) $(libdir) 2> /dev/null ; :
