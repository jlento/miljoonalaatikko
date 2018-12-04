#!/bin/bash

line () {
    printf "+%${1}s+\n" '' | tr ' ' '-'
}

boxtext () {
    local x=$(tr '[:print:]' 'x' <<<"$1" | sort | tail -1 | wc -c)
    local y=$(wc -l <<<"$1")
    line $((x+1))
    while read l; do
        printf "| %-$((x-1))s |\n" "$l"
    done <<<"$1"
    line $((x+1))
}
