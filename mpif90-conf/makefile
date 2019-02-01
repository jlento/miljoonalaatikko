THIS_DIR := $(dir $(lastword $(MAKEFILE_LIST)))

FC = $(notdir $(shell which ftn || which mpif90))

FC_SUITE = $(shell $(FC) --version 2> /dev/null || $(FC) -V 2>&1 | head -1 | grep -o -e IFORT -e GNU -e Cray)

ifeq ($(FC_SUITE),IFORT)
  FCFLAGS += -free -Tf
endif

vpath %.f08 $(THIS_DIR)src

PROG = myapp
OBJS = myapp.o mympi.o myutils.o

.PHONY : clean

$(PROG) : $(OBJS)
	$(FC) -o $@ $^

%.o : %.f08
	$(FC) -c $(FCFLAGS) $<

clean :
	find . -name '*~' -delete
	rm -f *.mod *.o $(PROG)

myapp.o : mympi.o myutils.o
