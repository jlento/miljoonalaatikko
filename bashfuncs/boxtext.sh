#!/bin/bash

hr () {
    local line=$(printf "+%${1}s+\n" '')
    echo ${line// /-}
}

wc-L () {
    local nx=0 line n
    while IFS='' read line; do
        n=${#line}
        (( nx = n > nx ? n : nx ))
    done <<<"$1"
    echo $nx
}

boxtext () {
    local nx=$(wc-L "$1")
    hr $((nx+2))
    while IFS='' read line; do
        printf "| %-${nx}s |\n" "$line"
    done <<<"$1"
    hr $((nx+2))
}
