# 4.3 Using MPI {#CompilerEnvironment-43UsingMPI .western}

Message passing interface (MPI) is a flexible parallel programming
paradigm, and it is the dominant method of parallelization codes in
scientific computing. MPI is suitable for both distributed memory
computers and shared memory architectures. In MPI, each task has an
address space in memory that other tasks cannot directly access. When
exchange of data is needed between tasks, the tasks send '*messages*' to
each other.

[Intel MPI], [MVAPICH2] and [OpenMPI] are available on Taito, however
CSC does not provide support for OpenMPI. The Intel MPI is the default
MPI library. The module commands below enable unloading Intel MPI and
loading MVAPICH2.

    module unload intelmpi
    module load mvapich2

 

## [][1]4.3.1 Compiling and linking MPI programs on Taito {#CompilerEnvironment-431CompilingandlinkingMPIprogramsonTaito .western}

There are compiler wrappers **mpif90**, **mpicc** and **mpiCC** for
compiling Fortran, C and C++ MPI programs, respectively. These wrappers
take care of compiler and linker directives for compiling MPI programs.
Users do not need to specify include file locations, MPI libraries or
their locations. For example, a MPI program (one source code file)
written with the Fortran language ('my\_mpi\_prog.f95') is compiled and
linked as:

    mpif90 my_mpi_prog.f95 -o my_mpi_prog

To compile each of the source code files separately use *-c* flag. The
example below will generate the object code files *my\_mpi\_source1.o*
and *my\_mpi\_source2.o*.

    mpif90 -c my_mpi_source1.f95
    mpif90 -c my_mpi_source2.f95

These can be linked to an executable program (my\_mpi\_prog)

    mpif90 my_mpi_source1.o my_mpi_source2.o -o my_mpi_prog

The **-show** option displays the actual compilation/linking command
generated by the wrapper. For example, try:

    mpif90 -show

 

## [][2]4.3.2 Include files {#CompilerEnvironment-432Includefiles .western}

In order to use MPI in your program, you need to include the MPI library
in your source code by having one of the following lines.

For programs written in Fortran 77 use:

    include 'mpif.h'

and for Fortran 90 or newer use:

    use mpi

For programs written in C/C++ use:

    #include "mpi.h"

 

  [Intel MPI]: http://software.intel.com/en-us/articles/intel-mpi-library-documentation
  {.external-link}
  [MVAPICH2]: http://mvapich.cse.ohio-state.edu/overview/mvapich2
  {.external-link}
  [OpenMPI]: http://www.open-mpi.org/
  [1]: https://research.csc.fi/ {#4.3.1}
  [2]: https://research.csc.fi/ {#4.3.2}