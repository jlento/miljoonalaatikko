# 4.2 Mathematical libraries {#CompilerEnvironment-42Mathematicallibraries .western}

## [][1]4.2.1 MKL (Intel Math Kernel Library) {#CompilerEnvironment-421MKLIntelMathKernelLibrary .western}

Intel MKL is a mathematical library collection that is optimized for
Intel processors. On Taito, MKL can be used with both Intel and GNU
compilers for Fortran and C/C++ programming. However cluster libraries
(BLACS, ScaLAPACK and Cluster FFT functions) will work only with
*IntelMPI* on Taito.

MKL includes the following groups of routines:

-   BLAS (Basic Linear Algebra Subprograms)
-   Sparse BLAS
-   LAPACK (Linear Algebra PACKage)
-   PBLAS (Parallel Basic Linear Algebra Subprograms)
-   BLACS (Basic Linear Algebra Communication Subprograms)
-   ScaLAPACK (Scalable LAPACK)
-   Sparse Solver routines (direct sparse solver PARDISO, direct sparse
    solver DSS, iterative sparse solvers RCI, preconditioners for
    iterative solution process)
-   Vector Mathematical Functions (VML, arithmetic, power,
    trigonometric, exponential, hyperbolic, special, and rounding)
-   Vector Statistical Functions (VSL, random numbers, convolution and
    correlation, statistical estimates)
-   General Fast Fourier Transform (FFT) Functions
-   Cluster FFT functions
-   Partial Differential Equations (PDE) support tools (Trigonometric
    Transform routines, Poisson routines)
-   Nonlinear least squares problem solver routines
-   Data Fitting functions (spline-based)
-   Support Functions (timing, thread control, memory management, error
    handling, numerical reproducibility)

MKL library has two integer interfaces 32-bit (they call it: LP64) and
64-bit integer (ILP64) interfaces. So if you work with data arrays that
have more than 2<sup>31</sup>-1 elements ILP64 interface is for you.

MKL supports sequential and threaded programming modes. Intel MKL is
based on the OpenMP threading. See: [Improving performance with
threading] for more information.

[Users Guide and Reference manual]

## [][2]4.2.2 Usage of MKL in Taito {#CompilerEnvironment-422UsageofMKLinTaito .western}

Make sure that *mkl* module has been loaded. If not give command:

`module load mkl`

Basic information can be found from link:

-   [What You Need to Know Before You Begin Using the Intel Math Kernel
    Library]

Load one of the supported compiler environments. Because MKL includes
many libraries and programming interfaces a link line can be a long
list. To find a correct line for a case, specify your choices using
*Intel Math Kernel Library (MKL) Link Line Advisor *tool:

-   <http://software.intel.com/sites/products/mkl/>

Table 4.5 lists the setting you should use with the *Link Line Advisor*.

**Table 4.5** *Link Line Advisor* tips for Taito:

Select Intel® product

Intel MKL 11.0 (or another installed version)

Select OS

Linux

Select compiler

Intel or Gnu Fortran or C/C++

Select architecture

Intel 64

Select dynamic or static linking

both options (static/dynamic) are OK

Select interface layer

LP64 or ILP64 (what is the integer range in your code)

Select sequential or multi-threaded layer

sequential and threaded programming modes are supported

Select OpenMP library

This is needed only for threaded applications and/or enable threading in
MKL

Select cluster library

Select these If a code is using ScaLAPACK, BLACS or Cluster FFT

Select MPI library

IntelMPI

Select the Fortran 95 interfaces

Select this only if your application has a Intel MKL Fortran module
interface. (if your code has a standard BLAS/LAPACK interface you do not
select these)

Link with Intel® MKL libraries explicitly

 

Copy the results (link line and compiler option results) into a
*Makefile*. In command line compiling and linking case remove all
brackets that the advisor gives (for example if there is a variable
(MKLROOT) in brackets then remove the brackets.

When you run an OpenMP (threaded) application there are environment
variables for threading control. Before running an application set the
OMP\_NUM\_THREADS variable. For example 16 threads:

`  export OMP_NUM_THREADS=16`

MKL has also some additional [MKL thread control environment variables].

**<span lang="en">For quick linking Intel compile</span><span
lang="en">r</span>**<span lang="en"> supports variants of
the</span>*<span lang="en"> -mkl </span>*compiler option. The compiler
links your application using the LP64 interface and it does not use
Intel MKL Fortran module 95 interfaces.

-   *-mkl* or *-mkl=parallel* to link with threaded MKL

-   *-mkl=sequential* to link with sequential MKL

-   *-mkl=cluster* to link with cluster libraries that use IntelMPI

for example:

`f95 -o my_code my_code.f90 -mkl=sequential`

Add option *-static-intel* if you want to use static linking, dynamic
linking is the default.

**MKL include files**

This [link] has a include file table (for Fortran and C/C++).

 

 

  [1]: https://research.csc.fi/ {#4.2.1}
  [Improving performance with threading]: https://software.intel.com/en-us/node/528539
  [Users Guide and Reference manual]: https://software.intel.com/en-us/intel-mkl/documentation
  [2]: https://research.csc.fi/ {#4.2.2}
  [What You Need to Know Before You Begin Using the Intel Math Kernel
  Library]: https://software.intel.com/en-us/node/528330
  [MKL thread control environment variables]: http://software.intel.com/en-us/articles/intel-math-kernel-library-intel-mkl-intel-mkl-100-threading
  {.external-link}
  [link]: https://software.intel.com/en-us/node/528477
