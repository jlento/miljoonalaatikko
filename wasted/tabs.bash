#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-16
#
# Tab separated columns
# =====================
#
# The functions here take tabs-formatted (including nosql-tables)
# as input, and produce tabs-formatted tables.
#
#
# Pretty printing a table
# -----------------------
#
# Pretty printing a table needs to read through the whole table to
# set the column widths. The non-printing control characters need
# to be filtered out from the calculation of the column widths.
#
# ~~~ {.bash}
tabs_print() {
    LC_ALL=C awk --source '
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
        BEGIN{
            FS  = "\t"
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
# The `tabs_paint` function here is an example of a function that
# select records (rows) from the table and then performs actions on
# that record. Here the conditon that is used to select a record
# is given as a first argument to the function, and should be a valid
# awk expression where the fields are referenced as `a["FIELD_NAME"]`.
# The second argument lists the fields that should be painted. See
# the `tabs_paint` call in `wasted.bash`, for example.
#
# This function can be easily modified, to drop the selected lines, for 
# example.
#
# ~~~ {.bash}
tabs_paint () {
    awk -f tabs.awk --source '
        function red ( s ) {
            return "\033[1;31m" s "\033[0m"
        }
        FNR == 1 {
            split( gensub( "\x01", "", "g" ), h, "\t" )
            nosql_print_header( h )
            n = split( "'"$2"'", pp, "|")
            for( i in pp )
                p[pp[i]] = 1
            for( i in h )
                if( n == 0 || i in p || h[i] in p )
                    paint[i] = 1
            next
        }
        {
            split( $0, b, "\t" )
            for( i in b )
                 a[h[i]] = b[i]
            if('"$1"') {
                for( i in b ) {
                    if( paint[i] )
                        b[i] = red( b[i] )
                }
            }
            nosql_print_fields( b )
        }'
}
# ~~~
#
#
# Sorting the tables
# ------------------
#
# The table formats tabs and nosql can easily be (re)sorted using the
# standard unix `sort` command.
#
# This convenience function, `tabs_sort`, accepts the name of the column
# that should be used as a sorting key as the first argument, and sets
# tab-character as the field separator. The remaining
# arguments are passed to sort command.
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
