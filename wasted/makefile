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

TESTENV = SQUEUE="cat $(datadir)/squeue.txt" \
          APSTAT="cat $(datadir)/apstat.txt" \
          LIBDIR=$(srcdir) 

.PHONY: all test install install-libs install-exe install-doc clean real-clean

all: test install

test: $(PROG).bash $(DATA)
	$(TESTENV) $(SHELL) $<

install: install-libs install-exe install-doc

install-exe: $(bindir)/$(PROG)

install-libs: $(LIBS:%=$(libdir)/%)

install-doc: $(DOCS:%=$(docdir)/%)

$(bindir)/$(PROG): $(PROG).bash
	sed -r -e "1 s|\$$|\nLIBDIR=$(libdir)|" -e '/^#[^!]|^#$$/d' $< > $@
	chmod u+rwx $@

$(libdir)/%.bash : %.bash
	sed -r '/^#[^!]|^#$$/d' $< > $@

$(docdir)/%.md : %.bash
	sed -r -e '1 {/^#!\/*/d}' -e 's/^# |^#$$//' $< > $@

clean :
	find . -name '*~' -delete
	rm -f $(LIBS:%=$(libdir)/%) $(bindir)/$(PROG) 

real-clean: clean
	rm -f $(DOCS:%=$(docdir)/%)
