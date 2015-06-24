SHELL=/bin/bash
DESTDIR = $(PWD)

srcdir  = ./src
datadir = ./data
vpath %.txt   $(datadir)
vpath %.bash  $(srcdir)

bindir  = $(DESTDIR)/bin
libdir  = $(DESTDIR)/lib
docdir  = $(DESTDIR)/doc

PROG = wasted
LIBS = myproviders.bash nosql.bash
SRC  = $(PROG).bash $(LIBS)
DOCS = $(SRC:%.bash=%.md)
DATA = squeue.txt apstat.txt
INSTALL-TARGETS=$(LIBS:%=$(libdir)/%) $(bindir)/$(PROG) $(DOCS:%=$(docdir)/%)

.PHONY: all test install clean real-clean

all: test install install-doc clean real-clean

test: $(PROG).bash $(DATA)
	OFFLINE=true LIBDIR=$(srcdir) DATADIR=$(datadir) $(SHELL) $<

install: $(LIBS:%=$(libdir)/%) $(bindir)/$(PROG) install-doc

install-doc: $(DOCS:%=$(docdir)/%)

$(LIBS:%=$(libdir)/%): $(libdir)/% : %
	sed -r '/^#[^!]|^#$$/d' $< > $@

$(bindir)/$(PROG): $(PROG).bash
	sed -r -e "1 s|\$$|\nLIBDIR=$(libdir)|" -e '/^#[^!]|^#$$/d' $< > $@
	chmod u+rwx $@

$(DOCS:%=$(docdir)/%): $(docdir)/%.md : %.bash
	sed -r -e '1 {/^#!\/*/d}' -e 's/^# |^#$$//' $< > $@

clean :
	find . -name '*~' -delete
	rm -f $(LIBS:%=$(libdir)/%) $(bindir)/$(PROG) 

real-clean: clean
	rm -f $(DOCS:%=$(docdir)/%)
