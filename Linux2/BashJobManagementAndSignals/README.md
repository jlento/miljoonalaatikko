# Multirun

A small wrapper program to perform Single Program Multiple Data (SPMD) type
parallelization.

This kind of workflow is common in parameter search type algorithms, in which
the same program is executed multiple times, starting from different initial
conditions. Often the number of initial conditions, jobs, is larger than can be
efficiently run simultaneously, but on the other hand, running the jobs in
sequence would take too long.

This directory contains three programs. The wrapper program is called
`multirun`, which takes care of keeping a given number of jobs running until all
input data is processed. The program that processes the input data (a single
job) is called `myexe`. The "input data" is created by shell script
`create_input_files.sh`, each job in a separate directory.
