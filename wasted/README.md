wasted
======

This program, `wasted`, finds out jobs that possible waste CPU resources.

The program works in Cray XT5, `sisu.csc.fi`, by comparing squeue
resource reservation info and apstat runtime info. Try
`make install; ./bin/wasted`
in some temporary directory in `sisu`.

Running `make test` uses cached example input data from files, and can be
executed on any linux box.


Project goal
------------

Can I write a bash program that is factored to testable and re-usable
units?
