#!/bin/bash

column_table_nosql () {
    awk -f tabs.awk --source '
        BEGIN{FIELDWIDTHS="'"${1}"'"}
        NR == 1 {
            for( i = 1; i <= NF; i++ )
                a[i] = strip( $i )
            nosql_print_header( a )
            next
        }
        {
            for( i = 1; i <= NF; i++ )
                a[i] = strip( $i )
            nosql_print_fields( a )
        }' | sort -n
}

nosql_paste () {
  awk -f tabs.awk --source '
    BEGIN {
        n1 = nosql_read_header( h1, ARGV[1] )
        n2 = nosql_read_header( h2, ARGV[2] )
        if( h1[1] != h2[1] ) {
            print "First fields (keys) should match"
            print "Key, File 1: " h1[1]
            print "Key, File 2: " h2[1]
            exit 1
        }
        for( i=2; i<= n2; i++ )
            h1[n1+i-1] = h2[i]
        nosql_print_header( h1 )
        e1 = 1
        e2 = 1
        for( k1 in r1 ) {}
        for( k2 in r2 ) {}
        empty1=gensub(/0/, "\t", "g", sprintf("%0*d", n1 -1, 0) )
        empty2=gensub(/0/, "\t", "g", sprintf("%0*d", n2 -1, 0) )
        do {
            if( ! length( r1 ) && e1 ) {
                e1 = nosql_read_record( r1, ARGV[1] )
                for( k1 in r1 ) {}
            }
            if( ! length( r2 ) && e2 ) {
                e2 = nosql_read_record( r2, ARGV[2] )
                for( k2 in r2 ) {}
            }
            if( ! e1 && ! e2 ) break
            if( ( ! e1 || ( k2 > k1 ) ) && e2 ) {
                r2[k2] = empty1 r2[k2]
                nosql_print_record( r2 )
                delete r2[k2]
                continue
            }
            if( ( ! e2 || ( k1 > k2 ) ) && e1 ) {
                r1[k1] = r1[k1] empty2
                nosql_print_record( r1 )
                delete r1[k1]
                continue
            }
            if( ( e1 && e2 ) && ( k1 == k2 ) ) {
                r1[k1] = r1[k1] "\t" r2[k2]
                nosql_print_record( r1 )
                delete r1[k1]
                delete r2[k2]
                continue
            }
            print "!!! Internal error or bad input in nosql_paste !!!"
        } while( e1 || e2 )
    }'  "$1" "$2"
}
