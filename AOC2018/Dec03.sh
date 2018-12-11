#!/bin/bash

nall=0
sed -E -e 's/^.*@ //' -e 's/(,|: |x)/ /g' "${0%.*}.dat" | \
    sort -n -k 1 | \
    while read x y nx ny; do
        ((nall += nx * ny))
        for ((i = 0; i < nx; i++)); do
            for ((j = 0; j < ny; j++)); do
                echo $((x + i)) $((y + j))
            done
        done
    done | sort -n -k 1,2 | uniq -d | wc -l
