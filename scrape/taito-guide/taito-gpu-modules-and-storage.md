## 6.3 Module and storage environment on Taito-GPU

Taito-GPU shares the same module and storage environment as the rest of
the Taito cluster system. The actual module tree is, however, optimized
for GPU usage and thus different. Regarding file system directories, see
more from [Chapter 1.5 of Taito User Guide].

Please pay attention to your module environment. Due to dynamic linking
nature of application program it is recommended that you always have
exactly the same environment when running your application as when you
used to compile & link it.

For cuda programs use the `cuda-env` module, this module will load cuda,
a compatible version of the GCC compiler and a compatible MPI
implementation. An example of how to load the cuda-env module:

    module purge
    module load cuda-env

If you opt for directive based OpenACC approach, use the `openacc-env`
module to load a working enviroment:

    module purge
    module load openacc-env

In case of multi-GPU MPI application it is advisable to enable also
CUDA-aware message passing. This allows the MPI implementation to
directly process device pointers with no need by the user to transfer
them from device to host before the transfer. A version of OpenMPI that
is built with GPU support is automatically loaded with the
`cuda-env `and `openacc-env` modules.

  [Chapter 1.5 of Taito User Guide]: https://research.csc.fi/taito-disk-environment
