#!/bin/bash

part1 () {
    sed -E -e 's/^.*@ //' -e 's/(,|: |x)/ /g' "${0%.*}.dat" | \
        sort -n -k 1 | \
        while read x y nx ny; do
            for ((i = 0; i < nx; i++)); do
                for ((j = 0; j < ny; j++)); do
                    echo $((x + i)) $((y + j))
                done
            done
        done | sort -n -k 1,2 | uniq -d | wc -l
}

part2 () {
    sed -E 's/( @ |,|: |x)/ /g' "${0%.*}.dat" | \
        sort -n -k 2 | \
        while read id x y nx ny; do
            for ((i = 0; i < nx; i++)); do
                for ((j = 0; j < ny; j++)); do
                    echo $((x + i)) $((y + j)) $id $((nx * ny))
                done
            done
        done | \
            sort -n -k 1,2 | awk '{print $3,$4,$1,$2}' | \
            uniq -f 2 -u | cut -d ' ' -f 1,2 | \
            sort -n -k 1.2 | uniq -c | awk '$1==$3{print $2}'
}

echo "Part 1 answer: $(part1)"
echo "Part 2 answer: $(part2)"
