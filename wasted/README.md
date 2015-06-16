wasted
======

Find out jobs that possible waste CPU resources.

Works in Cray XT5, sisu.csc.fi, by comparing squeue resource
reservation info and apstat runtime info.

Two versions of implementation, `wasted_draft`, and `wasted.bash`. The
first is a quick implementation and the second one is a
demonstration/test of making it more general.


Files
-----

`wasted.bash`
: the main program and two information provider scripts

`nosql.bash`
: helper funtions to work with nosql-format tables

`tabs.bash`
: helper funtions to work with tabs-format tables

`tabs.awk`
: helper funtions to work with tabs-format table's headers and records

`squeue.txt` and `apstat.txt`
: test input data

`wasted_draft`
: not the worst kind of usual implementation

