
SLURM and ALPS interfaces
-------------------------

SLURM and ALPS information providers output the data in NoSQL-table
format.

```bash
source "${LIBDIR:=../lib}/nosql.bash"
__squeue_fmt="%.8i%.12P%.17j%.10u%.12M%.12l%.11D"
: ${SQUEUE:="squeue -t R -o '$__squeue_fmt'"}
: ${APSTAT:=apstat -av}
```


Job reservation information
---------------------------

Interrogate SLURM and produce a nosql-table.

If there are changes in the job reservation information provider,
this is the part that will need to be modified, or rewritten. Note,
this function can be written with whatever language that the writer is
familiar with, as long as it writes a nosql-formatted table
to the stdout.

The `test` target in `makefile` shows an example how to test the
function using cached data from from a file instead of interacting
with live SLURM in sisu.

```bash
squeue_nosql () {
    fieldwidths=${__squeue_fmt//[^[:digit:]]/ }
    ${SQUEUE} | sed 's/    NODES/RES_NODES/' | \
        nosql_from_fixed_width_table "$fieldwidths"
}
```


Runtime information
-------------------

Interrogate ALPS and produce a nosql-table.

Implementation notes are the same as for the job
reservation information above.

```bash
apstat_nosql () {
    ${APSTAT} | awk -v OFS="$nosql_FS" -v SOH="$nosql_SOH" '
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
            s = "JOBID USED_NODES COMMAND"
            print SOH gensub( " ", OFS SOH, "g", s )
            for( i in nodes )
               print i, nodes[i], prog[i]
        }
    ' | sort -n
}
```
