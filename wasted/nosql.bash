#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-23
#
# NoSQL 
# =====
#
# Library of functions that work with NoSQL-formatted tables,
# [*nosql*-tables](http://www.troubleshooters.com/lpm/200704/200704.htm).
#
# NoSQL-format is really simple to write with practically any programming
# language. Here I shell out to awk and join. Easier and faster.
#
nosql_FS=$'\t'
nosql_RS=$'\n'
#
# Construct a NoSQL-format table from fixed width columns
# -------------------------------------------------------
#
# The first column is
# implicitly assumed to be a valid and unique key for the row (record). This
# function is generally useful when the format of the source table is
# known. See function `squeue_nosql` in `wasted.bash`, for
# example.
#
# ~~~ {.bash}
nosql_from_fixed_width_table () {
    awk -v FIELDWIDTHS="$1" -v OFS="$nosql_FS" -v ORS="$nosql_RS" '
        {
            i=0
            NR == 1 ? SOH="\x01" : SOH=""
            while( ++i <= NF ) {
                sub( /^ +/, SOH, $i )
                sub( / +$/, "", $i )
            }
            print $0
        }' | sort -n
}
# ~~~
#
#
# Merging two nosql-tables
# ------------------------
#
# ~~~ {.bash}
nosql_paste () {
    local -a header
    local -a a
    local -i i
    local -i j
    local opts=""
    local ofmt="0"
    if [ "$nosql_RS" != $'\n' ]; then
	echo "ERROR: Only newline record separator works with join" 1>&2
	return 1
    fi
    for ((i=1;i<=2;i++)); do
	IFS="$nosql_FS" read -d "$nosql_RS" -r -a a < "${!i}"
	header+=( "${a[@]:$(( i > 1 ))}" )
	opts+=" -a$i"
	for ((j=2;j<=${#a[@]};j++)); do
	    ofmt+=" $i.$j"
	done
    done
    IFS=$'\t' eval 'printf "%s${nosql_RS}" "${header[*]}"'
    join -t $'\t' -e "" $opts -o $ofmt "$@"
}
# ~~~
