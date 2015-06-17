#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-16
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
source nosql.bash
source tabs.bash
# ~~~
#
#
# Job reservation information
# ---------------------------
#
# Interrogate SLURM and produce a nosql-table.
#
# If there are changes in the job reservation information provider,
# this is the part that will need to be modified, or rewritten. Note,
# this function can be written with whatever language that the writer is
# familiar with, as long as this function writes a nosql-formatted table
# to the stdout.
#
# To test the script with a data cached in a file, set the environment
# variable OFFLINE to a non-empty string.
# 
# ~~~ {.bash}
squeue_nosql () {
    fmt="%.8i%.12P%.17j%.10u%.12M%.12l%.11D"
    fieldwidths=$(sed 's/[^0-9]/ /g' <<< "$fmt")
    if [ -n "$OFFLINE" ]; then
        cat squeue.txt
    else
        squeue -t R -o "$fmt"
    fi | sed 's/    NODES/RES_NODES/' | \
        column_table_nosql "$fieldwidths"
}
# ~~~
#
#
# Runtime information
# -------------------
#
# Interrogate ALPS and produce a nosql-table.
#
# Implementation notes are the same as for the job
# reservation information above.
#
# ~~~ {.bash}
apstat_nosql () {
    if [ -n "$OFFLINE" ]; then
        cat apstat.txt
    else
        apstat -av
    fi | awk -f tabs.awk --source '
        /Batch System ID = / {
            jobid  = gensub( /[^0-9]/, "", "g", $NF )
        }
        match( $0, /Cmd\[[0-9]+\]: ([^,]+),.*, nodes ([0-9]+),/, n ) {
            if( jobid ) {
                nodes[jobid] = nodes[jobid] + n[2]
                prog[jobid]  = ( prog[jobid] ) ? prog[jobid] " : " n[1] : n[1]
            }
        }
        END {
            split( "JOBID  USED_NODES COMMAND", a )
            nosql_print_header( a )
            for( i in nodes )
            printf( "%s\t%s\t%s\n", i, nodes[i], prog[i] )
        }
    ' | sort -n
}
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
