#!/bin/bash

# Create phony input files for the exercises

for ((i = 0; i < 20; i++)); do
    oi=$(printf "%02d" $i)
    mkdir job_${oi}
    touch job_${oi}/data_${oi}_in.dat
done
