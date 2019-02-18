## 6.4 Compiling & linking GPU-programs

### 6.4.1 Introduction

In order to make application runnable on GPUs one has to use CUDA
programming language, the OpenCL programming language or the OpenACC
directive based approach.  
For more information on these approaches look at:

CUDA

<https://github.com/csc-training/CUDA/blob/master/course-material/intro-to-cuda-csc.pdf>

<https://devblogs.nvidia.com/parallelforall/even-easier-introduction-cuda/>

OpenACC

<https://devblogs.nvidia.com/parallelforall/getting-started-openacc>/

### 6.4.2 CUDA

The CUDA compiler is called using the

    nvcc 

command. The CUDA compiler will take care of the device code compilation
and pass the rest on to the C/C++/Fortran compiler loaded which can be
changed by loading different versions of the gcc module.

When compiling CUDA code one should pass the compiler what compute
capability the target device supports. In the Taito cluster currently
there are three types of different GPUs that all support different
compute capabilities. The K80 GPUs support compute capability 3.7 and
the newest P100 GPUs support compute capability 6.0. To tell the
compiler what compute capability to target for compute capability 3.7
(K80) use:

    -gencode arch=compute_37,code=sm_37

and for compute capability 6.0 (P100) use:

    -gencode arch=compute_60,code=sm_60

The gencode argument can be repeated multiple times so to compile for
all architectures present in the system use:

    -gencode arch=compute_37,code=sm_37 -gencode arch=compute_60,code=sm_60

### 6.4.3 CUDA and MPI

Building CUDA programs with MPI can be done in two ways, one can either
point the nvcc compiler to use the mpic++ compiler wrappers instead of
gcc directly as a backend compiler or manually include and link MPI
using the nvcc compiler.

To change what backend compiler nvcc uses pass the `-ccbin` flag to
nvcc:

    nvcc -ccbin=mpic++ cuda-mpi.cu

Alternatively one can do the linking normally done by the `mpic++`
wrapper by hand and not need to change the backend compiler:

    nvcc -I$MPI_ROOT/include -L$MPI_ROOT/lib -lmpi cuda-mpi.cu

Please note that the actual include paths and libraries depend on the
MPI library.

### 6.4.4 OpenACC

#### 6.4.4.1 C/C++ OpenACC

To compile and link the application, the PGI environment must be used.
Unless you have strict requirement for using C++ compiler (`pgc++`), it
is often more convenient to deploy PGI's C-compiler with c99 standard
extensions:

    module purge

    module load pgi/16.1 cuda/7.5
    module list

    pgcc -c99 -O3 -Minfo=all -acc -ta=tesla:cc35,7.5,kepler+ daxpy.c -o daxpy.x.acc

Here we only target compute capability 3.5, since PGI does not have
special support for 3.7. The code will still also work on K80 cards.
Since we asked for compiler info via `-Minfo=all`, we will be rewarded
by a rather exhaustive listing of messages.

#### 6.4.4.2 Fortran OpenACC

Compilation goes as follows:

    module purge
    module load pgi/16.1 cuda/7.5
    module list

    pgfortran -O3 -Minfo=all -acc -ta=tesla:cc35,7.5,kepler+ daxpy.F90 -o daxpy.x.acc
