function nosql_print_header( h,     i ) {
    printf( "\x01%s", h[++i] )
    for( i = 2; i <= length( h ); i++ )
	printf( "\t\x01%s", h[i] )
    printf ( "\n" )
}
function nosql_print_fields( a,     i ) {
    printf( "%s", a[++i] )
    for( i = 2; i <= length( a ); i++ )
	printf( "\t%s", a[i] )
    printf ( "\n" )
}

function nosql_read_header( h,     fname,     l ) {
    getline l < fname
    n = split( gensub( "\x01", "", "g", l ), h, "\t" )
    return n
}

function nosql_read_record( r,     fname,     l ) {
    getline l < fname
    if( l != "" ) {
        r[gensub( /\t.*$/, "", "g", l )] = gensub( /[^\t]*\t/, "", "1", l )
        return 1
    }
    else
        return 0
}

function nosql_print_record( r,     k ) {
    for( k in r )
        print k "\t" r[k]
}

function strip( s ) {
    return gensub( /^ +| +$/, "", "g", s )
}
