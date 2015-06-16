#!/bin/bash

tabs_print() {
    LC_ALL=C awk -f tabs.awk --source '
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
        {
            rows[NR] = $0
            columnwidths( w )
        }
        END {
            for(j=1;j<=NR;j++)
                print_row( rows[j], w )
        }'
} 

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
