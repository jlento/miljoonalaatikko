#!/bin/bash

# Create phony input files for the exercises

for ((i = 0; i < 20; i++)); do
    mkdir job$i
    touch job${i}/data${i}_in.dat
done
