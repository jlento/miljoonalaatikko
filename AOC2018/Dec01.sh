#!/bin/bash

# Maybe bash is not the best if these quizzes are numerical :)

sum=0
while read number; do
    (( sum += number ))
done < "${0%.*}.dat"
echo Part 1 answer: $sum

sum=0
while true; do
    while read number; do
        (( sum += number ))
        if [ -z "${a[$sum]}" ]; then
            a[$sum]=1
        else
            break 2
        fi
    done < "${0%.*}.dat"
done
echo Part 2 answer: $sum
