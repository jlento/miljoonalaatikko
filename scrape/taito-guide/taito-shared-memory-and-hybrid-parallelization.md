# 4.4 Shared memory and hybrid parallelization {#CompilerEnvironment-44Sharedmemoryandhybridparallelization .western}

The Haswell compute nodes on Taito contain two twelve core processors
(24 cores per node). Hence, it is possible to run shared memory parallel
(OpenMP) programs efficiently within a node with twenty four threads at
maximum.

## [][1][][2] 4.4.1 How to compile {#CompilerEnvironment-441Howtocompile .western}

Both Intel and GNU compilers support OpenMP. Use the following compiler
flags enable OpenMP support.

**Table 4.6** OpenMP compiler flags

| Compiler | Flag     |
|----------|----------|
| Intel    | -openmp  |
| GNU      | -fopenmp |

Here are examples for OpenMP and mixed (i.e. hybrid) OpenMP/MPI
compiling (upper line: Intel compiler, second line: GNU-compiler

    f95 -openmp -o my_openmp_exe my_openmp.f95
    mpif90 -fopenmp -o my_hybrid_exe my_hybrid.f95

See [OpenMP web site] for more information including standards and
tutorials.

#### Include files {#CompilerEnvironment-Includefiles .western}

For Fortran 77 use following line:

    include 'omp_lib.h'

For Fortran 90 (and later) use:

    use omp_lib

For C/C++ use:

    #include <omp.h>

## [][3][][4] 4.4.2 Running OpenMP programs {#CompilerEnvironment-442RunningOpenMPprograms .western}

The number of OpenMP threads is specified with an environment variable
**OMP\_NUM\_THREADS.** Running a shared memory program typically
requires requesting a whole node. Thus, a twenty four thread OpenMP job
can be run interactive on Haswell processors as shown in following
examples. If you find out that OpenMP sections of your code do not give
run-to-run numerical stability try (with Intel compiled code) to set the
variable KMP\_DETERMINISTIC\_REDUCTION=yes.

Sample session for Intel compiled OpenMP program:

    export KMP_AFFINITY=compact
    export KMP_DETERMINISTIC_REDUCTION=yes   #(if necessary and intel compiler version is 13 or later)
    export OMP_NUM_THREADS=24
    salloc -N1 --cpus-per-task=24 --mem-per-cpu=1000 -t 01:00:00
    srun ./my_openmp_exe
    exit

Sample session for GNU compiled OpenMP program:

    export OMP_PROC_BIND=TRUE
    export OMP_NUM_THREADS=24
    salloc -n 1 -N 1 --cpus-per-task=24 --mem-per-cpu=1000 -t 01:00:00
    srun ./my_openmp_exe
    exit

The corresponding batch queue script would be (below just for Intel
compiled OpenMP program)[][5]:

    #!/bin/bash -l
    #SBATCH -J my_openmp
    #SBATCH -e my_output_err_%j
    #SBATCH -o my_output_%j
    #SBATCH --mem-per-cpu=1000
    #SBATCH -t 01:00:00
    #SBATCH -N 1
    #SBATCH -n 1
    #SBATCH --cpus-per-task=24
    export KMP_AFFINITY=compact
    export KMP_DETERMINISTIC_REDUCTION=yes    #(if necessary and intel compiler version is 13 or later)
    export OMP_NUM_THREADS=24
    srun ./my_openmp_exe

In the above example replace "export KMP\_AFFINITY=compact" with "export
OMP\_PROC\_BIND=TRUE" if a code is compiled by GNU compiler. The
KMP\_DETERMINISTIC\_REDUCTION do not help with GNU compiled code.

## [][6][][7] 4.4.3 Hybrid parallelization {#CompilerEnvironment-443Hybridparallelization .western}

In many cases it is beneficial to combine MPI and OpenMP
parallelization. More precisely, the inter-node communication is handled
with MPI and for communication within the nodes OpenMP is used. For
example, on Haswell, consider an eight-node job in which there is one
MPI task per node and each MPI task has twenty four OpenMP threads,
resulting in a total core (and thread) count of 192. Running a hybrid
job can be done interactively as above with the exception that more
nodes are specified and for each node one MPI task is requested. The
**parallel** partition must be requested to run the program because
there are more than one node. That is, for a 8 x 24 job the following
flags are used

    export KMP_AFFINITY=compact
    export KMP_DETERMINISTIC_REDUCTION=yes   #(if necessary and intel compiler version is 13 or later)
    export OMP_NUM_THREADS=24
    salloc -p parallel -N 8 -n 8 --cpus-per-task=24 --mem-per-cpu=1000 -t 02:00:00
    srun ./my_hybrid_exe
    exit

The corresponding batch queue script would be (for Intel compiled
code)[][8]:

    #!/bin/bash -l
    #SBATCH -J my_hybrid
    #SBATCH -e my_output_err_%j
    #SBATCH -o my_output_%j
    #SBATCH --mem-per-cpu=1000
    #SBATCH -t 02:00:00
    #SBATCH -N 8
    #SBATCH -n 8
    #SBATCH --cpus-per-task=24
    #SBATCH -p parallel
    export OMP_NUM_THREADS=24
    export KMP_AFFINITY=compact
    export KMP_DETERMINISTIC_REDUCTION=yes  #(if necessary and intel compiler version is 13 or later)
    srun ./my_hybrid_exe

In the above example replace "export KMP\_AFFINITY=compact" with "export
OMP\_PROC\_BIND=TRUE" if a code is compiled by GNU compiler. The
KMP\_DETERMINISTIC\_REDUCTION do not help with GNU compiled code.

## [][9][][10] 4.4.4 Binding threads to cores {#CompilerEnvironment-444Bindingthreadstocores .western}

The compilers on Taito support thread/core affinity which binds threads
to cores for better performance. This is enabled with compiler-specific
environment variables as follows (Sandy Bridge):

**Intel:**

`export KMP_AFFINITY=compact`

**GNU:**

`export OMP_PROC_BIND=TRUE`

If one does not set these variables and values all threads in a node
might run in a same core. Learn more about [Intel thread affinity
interface]. Support information for GNU compilers for tread affinity can
be found [here].

 

  [1]: https://research.csc.fi/
  {#Sharedmemoryandhybridparallelization-Howtocompile}
  [2]: https://research.csc.fi/ {#4.4.1}
  [OpenMP web site]: http://openmp.org/wp {.external-link}
  [3]: https://research.csc.fi/
  {#Sharedmemoryandhybridparallelization-RunningOpenMPprograms}
  [4]: https://research.csc.fi/ {#4.4.2}
  [5]: https://research.csc.fi/ {#slurm7}
  [6]: https://research.csc.fi/
  {#Sharedmemoryandhybridparallelization-Hybridparallelization}
  [7]: https://research.csc.fi/ {#4.4.3}
  [8]: https://research.csc.fi/ {#slurm8}
  [9]: https://research.csc.fi/
  {#Sharedmemoryandhybridparallelization-Bindingthreadstocores}
  [10]: https://research.csc.fi/ {#4.4.4}
  [Intel thread affinity interface]: https://software.intel.com/en-us/node/522691
  [here]: http://gcc.gnu.org/onlinedocs/libgomp/GOMP_005fCPU_005fAFFINITY.html#GOMP_005fCPU_005fAFFINITY
  {.external-link}
