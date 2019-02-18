# 4.6 Processor architecture specific compiling

After the hardware extension in January 2015, Taito has two types of
compute nodes:

-   **Intel Sandybridge**: 2 Cpus per node, all together 16 cores
    (original Taito, has been removed)
-   **Intel Haswell**: 2 Cpus per node, all together 24 cores (extension
    part)

*Haswell* procesors have some new instructions such as ***AVX2*** and
***FMA***, that are not available in the Sandy Bridge processors.  This
means that it is possible to compile a binary in such a way that it
won't run on *Sandybridge* nodes but might run very well on *Haswell*
nodes. To get best performance on new and old nodes a code may need two
binaries, one for *Sandybrigde* and another for *Haswell*. The binaries
that are optimized just for one architecture are below called single
code path binaries. But of course Sandybridge optimized code can be run
on Haswell nodes too.

*Gnu* compilers ( *gcc, g++, gfortran* ) versions *4.9 and later* and
*Intel* compilers (*icc, icpc , ifort*) versions *14* *and later*
support Haswell specific compiling. Compilers may support multiple code
paths. That means that a binary can have a *baseline path* and one or
more additional *optimized paths* i.e. compiler creates both Sandybrigde
and Haswell paths. Below are some examples for single and multiple tuned
code path options for Intel and GNU compilers.

Please note, that you should use usual optimization switches like *-O2*,
*-O3*, or *-funroll-all-loops* too, even though these options are not
used in the examples described below.

## 4.6.1 Intel compiler environment

Recent intel compilers of Taito , for example intel/15.0.0,  support
single and multiple code paths. *Baseline code path* is determined by
the architecture specified option ***-x***. Multiple, *feature specific
code paths* are are created with option ***-ax***. These options are
available with *icc*, *icpc* and *ifort* compilers and also with MPI
wrappers (*mpicc*,*mpiCC*, *mpif90*) when intel environment (later than
14 ) is loaded. Compiler will generate a single code path that support
AVX2 and FMA instructions if the options ***-xCORE-AVX2*** and/or
***-fma*** are chosen. An example, this binary will run only on Haswell
nodes.

    icc -xCORE-AVX2 -fma -o example example.c 

Multiple code path example below has a baseline path switch ***-xAVX***
(for Sandybridge) and two other feature specific paths
***-axCORE-AVX2,CORE-AVX-I*** (for Haswell and IvyBridge) Option *-ax*
tells the compiler to generate one or more versions of functions that
will utilize features that these instructions have. This binary will run
on Sandybridge (baseline code path) and Haswell nodes (feature specific
code path).

     icc -xAVX -axCORE-AVX2,CORE-AVX-I -o example example.c

 

## 4.6.2 GNU compiler environment

GNU compilers, for example gcc/4.9.1,  do not support multiple code
paths but compiler can tune the generated code for specified cpu-type.
Option ***-march*** will choose the generated instructions (for example
Sandybridge instructions) but with switch ***-mtune*** compiler can
schedule things so that it runs faster on Haswell cpu. These options are
available *gcc*, *g++* and *gfortran* compilers and and also with MPI
wrappers (*mpicc*, *mpiCC*, *mpif90*) when GNU environment (later than
4.9 ) is loaded.

Single code path example that will run only on Haswell nodes.

     gcc -march=haswell -o example example.c

Tuned code path example that will run both on Sandybridge and Haswell
nodes.

    gcc -march=sandybridge -mtune=haswell -o example example.c

As always if good performance binary is the target it is worthwhile to
try how above mentioned switches might work with your code.

### 4.6.3 Login nodes

Login nodes have Sandybridge architecture. Remember this if you apply
compiler options like *-xHost* (Intel compiler) or *-march=native* (GNU
Compiler). If compilation is done on a login node the binary will have
Sandybridge single code path and if compilation is done on a Haswell
node the binary will have a Haswell single code path.
