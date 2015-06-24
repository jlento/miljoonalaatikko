#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-22
#
# Wasted
# ======
#
# Compares the batch job reservation information from SLURM against
# the runtime information from APLS and highlights possible over-booking
# of the resources.
#
#
# General notes
# -------------
#
# Linux command line has a a comprehensive set of small programs that
# work with plain text streams. The output of one program can be easily
# piped to another program, making it possible to combine
# many small programs into a larger program. Here we extend the idea from
# the small programs that work with unstructured text streams
# to small programs that work with tables.
#
#
# Table format
# ------------
#
# In order to make it possible for the programs to exchange tables
# in the form of test streams, the table format needs to be defined.
#
# Here we work with two flavors of tables. Tables which have sorted and
# unique key columns,
# [*nosql*-tables](http://www.troubleshooters.com/lpm/200704/200704.htm),
# and simple *tabs*-tables, without the key-column restriction. See
# the documentation of the `nosql.bash` library for details.
#
#
# Interrogating SLURM and ALPS
# ----------------------------
#
# The implementation of the interfaces to SLURM and ALPS (implemented here in
# `myproviders.bash`) are cleanly separated from following the analysis.
#
#
# Implementation notes
# --------------------
#
# The programs that work with tables are implemented here as bash
# funtions.
#
# ~~~ {.bash}
source myproviders.bash
source nosql.bash
# ~~~
#
#
# Main
# ----
#
# Merge the nosql-tables from SLURM and ALPS, sort the results,
# highlight the possible overbooking, and pretty print the table.
#
# Note, each part of the chain can be implemented and easily tested
# separately.
#
# ~~~ {.bash}
nosql_paste <(squeue_nosql) <(apstat_nosql) |
    tabs_sort 'RES_NODES' -n -r |
    tabs_paint '$"RES_NODES" > $"USED_NODES"' 'RES_NODES' 'USED_NODES' |
    tabs_print
# ~~~
