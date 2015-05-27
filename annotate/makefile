CC=gcc
CFLAGS=-Ofast -fopt-info-vec-missed
SOURCES=pngwriter.c ex7_heat.c ex7_main.c
OBJS=$(patsubst %.c,%.o,$(SOURCES))
LIBS=-lpng
EXE=heat

.SUFFIXES:

all: $(EXE)

ex7_heat.c: ex7_heat.h

ex7_main.c: ex7_heat.h

pngwriter.c: pngwriter.h

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $< 

$(EXE): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)

.PHONY: clean

clean:
	rm *.o $(EXE)
