#!/bin/bash

hr () {
    local line=$(printf "+%${1}s+\n" '')
    echo ${line// /-}
}

boxtext () {
    local nx=0 line
    while read line; do
        (( ${#line} > nx )) && nx=${#line}
    done <<<"$1"
    hr $((nx+2))
    while read line; do
        printf "| %-${nx}s |\n" "$line"
    done <<<"$1"
    hr $((nx+2))
}
