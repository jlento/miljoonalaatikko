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
# the runtime information from APLS and highlights possible overbooking
# of resources.
#
# This implementation is written for demonstration and testing purposes.
# The attention is paid on data structures, code refactoring and
# making the functions general.
#
#
# General notes about the implementation and the data structures
# --------------------------------------------------------------
#
# Linux command line has excellent small programs to work with streams
# of newline separated lines of text. The usefulness of these small
# programs is enchanced with the possibility of easily piping the text
# streams from one function to an another. The purpose of the helper
# functions here is to make it easier to work with tables represented as
# text streams.
#
# Here we work with two flavors of tables. Tables which have sorted and
# unique key columns,
# [*nosql*-tables](http://www.troubleshooters.com/lpm/200704/200704.htm),
# and simple *tabs*-tables, without the key-column restriction. Both
# table formats have a header row as the first row. Columns are
# separated by tabs, and each column header begins with a non-printing
# start-of-header character (ascii `\x01`). Fields cannot contain newline,
# tab or start-of-header characters.
#
# Some operations, such as merging tables, are easier to define on the
# more constrained nosql-format tables. On the other hand, many of the
# operations do not require uniquely keyed
# columns, and can be made more general.
#
# Functions that operate on the nosql-tables have `nosql` in their name,
# and the functions that operate on both the more general tabs-tables, and
# nosql-tables, have `tabs` in their name.
#
# ~~~ {.bash}
source myproviders.bash
source nosql.bash
source tabs.bash
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
nosql_paste <(squeue_nosql) <(apstat_nosql) \
    | tabs_sort 'RES_NODES' -n -r \
    | tabs_paint 'a["RES_NODES"] > a["USED_NODES"]' 'RES_NODES|USED_NODES' \
    | tabs_print
# ~~~
