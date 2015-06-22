#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-22
#
# ~~~ {.bash}
source nosql.bash
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
