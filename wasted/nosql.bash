#!/bin/bash
#
# % NoSQL table format
# % juha.lento@csc.fi
# % 2015-06-24
#
# NoSQL table format
# ==================
#
# Library of functions that work with NoSQL-formatted tables,
# [*nosql*-tables](http://www.troubleshooters.com/lpm/200704/200704.htm).
#
# NoSQL table format is really simple to write with practically any
# programming language. It is defined by the following rules:
#
# 1. Table field separator (FS) is tab
# 2. Table record (row) separator (RS) is newline
# 3. All rows have the same number of fields
# 4. First line is a header line
# 5. Each field in the header line begins with a start-of-header (SOH)
#    character (ascii \x01)
# 6. Fields must not contain FS, RS or SOH characters
# 7. The first field of each row is a unique and sorted integer key
#
#
# Tabs table format
# -----------------
#
# Many operations do not require unique and sorted key. Here I refer
# the table format which obeys rules 1 -- 6 as "tabs" format tables.
#
# ~~~ {.bash}
nosql_FS=$'\t'
nosql_RS=$'\n'
nosql_SOH=$'\x01'
# ~~~ {.bash}
#
#
# Validate NoSQL table format
# ---------------------------
#
# The function `nosql_validate` reads NoSQL table from stdin and validates
# it. If the table is valid, the program prints it back to the stdout,
# otherwise, returns with exit code 1 and
# prints nothing to the stdout.
# 
# ~~~ {.bash}
nosql_validate () {
    local f=$(mktemp)
    local -a a
    trap 'rm -f $f' INT EXIT HUP TERM RETURN
    cat > $f
    awk -F "$nosql_FS" '
        function error( msg ) {
            print "ERROR: ", msg > "/dev/stderr"
            exit 1
        }
        NR == 1 {
            for( i=1;i<=NF;i++) {
                sub( /^\x01[^\x01]*$/ , "", $i )
            }
            OFS=""
            if( length($0) > 0 )
                error( "Table does not begin with a valid header." )
        }
        NR > 1 {
            if( NF != prev_NF )
                error( "Number of fields in records differ." )
        }
        NR > 2 {
            if( $1 <= prev_1 )
                error( "First field not sorted or unique." )
        }
        {
            prev_NF=NF
            prev_1 = $1
        }
    ' $f
    if [ $? == 0 ]; then
	cat $f
    else
	return 1
    fi
}
# ~~~
#
#
# Construct a NoSQL-format table from fixed width columns
# -------------------------------------------------------
#
# The function `nosql_from_fixed_width_table` reads lines with fixed width
# column from stdin and writes the corresponding
# NOSQL formatted table to stdout.

# The first column of the input records is
# implicitly assumed to be a valid and unique key for the record. This
# function is generally useful when the format of the source table is
# known. See function `squeue_nosql` in `myproviders.bash`, for
# example.
#
# ~~~ {.bash}
nosql_from_fixed_width_table () {
    awk -v FIELDWIDTHS="$1" -v OFS="$nosql_FS"  '
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
# The function `nosql_paste` reads two files containing NoSQL formatted
# tables, validates them, and writes a single merged NoSQL table to stdout.
#
# ~~~ {.bash}
nosql_paste () {
    __nosql_paste <(nosql_validate < $1) \
                  <(nosql_validate < $2)
}
__nosql_paste () {
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
    IFS="$nosql_FS" eval 'printf "%s\n" "${header[*]}"'
    join --check-order -t "$nosql_FS" -e "" $opts -o $ofmt "$@"
}
# ~~~
#
#
# Pretty printing a table
# -----------------------
#
# Function `tabs_print` reads a NoSQL formatted table from the stdin
# and prints fixed column width table to stdout.
#
# ~~~ {.bash}
tabs_print() {
    LC_ALL=C awk -F "$nosql_FS" --source '
        function drop_nonprinting( s ) {
            gsub( /\x01|(\033\[|\x9b)[ -?]*[@-~]/, "", s )
            return s
        }
        function columnwidths( w,     n, i ) {
            for(i=1;i<=NF;i++) {
                n = length( drop_nonprinting( $i ) )
                w[i] = ( w[i] > n ) ? w[i] : n
            }
        }
        function print_row( r, w,     n, f, i ) {
            n = split( r, f, "\t" )
            for(i=1;i<n;i++) {
                wi = length( drop_nonprinting( f[i] ) )
                pad = w[i] - wi
                printf( "%" pad "s%" wi "s  " ,"" , f[i] )
            }
            print f[n]
        }
        NR == 1 {
            gsub( /\x01/, "", $0 )
        }
        {
            rows[NR] = $0
            columnwidths( w )
        }
        END {
            for(i=1;i<=NR;i++)
                print_row( rows[i], w )
        }'
} 
# ~~~
#
#
# Selecting records and fields
# ----------------------------
#
# The function `tabs_paint` reads tabs-formatted table from stdin and
# prints tabs-formatted table to stdout. The first argument of `tabs_paint`
# is an awk expression that is used to select records. The record fields
# are referenced as `$<FIELD_NAME>` or $<FIELD_NUMBER> in the expression.
# Possible spaces are replaced by underscores in the <FIELD_NAMES>s.
# The second argument is a `|` separated list of field names or
# numbers that should be painted.  See
# the `tabs_paint` call in `wasted.bash`, for example.
#
# This function is an (ugly) example of a function that
# selects records (rows) from the table and then performs actions on
# that record. This function can be easily modified, to drop the
# selected lines, for example.
#
# ~~~ {.bash}
tabs_paint () {
    local -a a
    local -a cols
    local -a sel
    local opts
    local -i i
    local -i j
    IFS="$nosql_FS" read -a a
    IFS="$nosql_FS" eval 'printf "%s\n" "${a[*]}"'
    cols=( "${a[@]/${nosql_SOH}}" )
    IFS="|" eval 'opts="-v columns=${cols[*]} -v select=${2}"'
    for((i=0;i<${#cols[@]};i++)); do
	opts+=" -v ${cols[$i]}=$((i+1))"
    done
    awk -F "$nosql_FS" -v OFS="$nosql_FS" $opts '
        function red ( s ) {
            return "\033[1;31m" s "\033[0m"
        }
        BEGIN {
                n = split( select, sel, "|" )
                split( columns, col, "|" )
                for(i=1;i<=length(col);i++) {
                    for(j=1;j<=n;j++) {
                        if( n == 0 || col[i] == sel[j] || i == sel[j] ) {
                            paint[i] = 1
                        }
                    }
                }
        }
        {
            if('"$1"')
                for(i=1;i<=NF;i++)
                    if( paint[i] )
                        $i = red( $i )
            print $0
        }'
}
# ~~~
#
#
# Sorting the tables
# ------------------
#
# The function `tabs_sort` reads a tabs-formatted table from the stdin
# and writes a (re)sorted tabs-formatted table to the stdout. The first
# argument is name of the column that is used as the key for the sort.
# The remaining arguments are passed to the OS sort command.
#
# ~~~ {.bash}
tabs_sort () {
    key=$1
    shift
    TAB=$(printf "\t")
    SOH=$(printf "\x01")
    IFS='' read -r line
    printf "%s\n" "$line"
    IFS="$TAB" header=($line)
    n=1
    for h in "${header[@]}"
    do
        if [ "$h" == "${SOH}$key" ]; then break; else (( n++ )); fi
    done
    [[ n -gt ${#header[@]} ]] && n=1
    sort -t "$TAB" -k "$n" "$@"
}
# ~~~
