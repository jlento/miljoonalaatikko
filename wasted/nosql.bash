#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-16
#
# NoSQL 
# =====
#
# Library of functions that work with NoSQL-formatted tables,
# [*nosql*-tables](http://www.troubleshooters.com/lpm/200704/200704.htm).
#
#
# Constructing a NoSQL-formatted table
# ------------------------------------
#
# NoSQL-format is really simple to write with practically any programming
# language. The helper function here, `column_table_nosql`, converts a
# text table with fixed column widths to nosql-format. The first column is
# implicitly assumed to be a valid and unique key for the row (record). This
# function is generally useful when the format of the source table is
# known. See function `squeue_nosql` in `wasted.bash`, for
# example.
#
# ~~~ {.bash}
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
# ~~~
#
#
# Merging two tables
# ------------------
#
# A unique way to merge the rows of two tables is simple to define when
# both tables have a row keys as in nosql-format. Also, reading one of
# the tables to memory can be avoided, and the function can be written
# more "stream-like", when the keys (rows) are ordered.
#
# ~~~ {.bash}
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
# ~~~
