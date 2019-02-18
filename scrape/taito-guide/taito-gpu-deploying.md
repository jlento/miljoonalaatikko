# 6.6 Deploying GPU + MPI-programs

It is possible to utilize multiple GPUs to the benefit of better
application performance. Normally this is done by creating an
MPI-program and making sure each MPI-task is connected to a GPU.

When we have Hyper-Q/MPS activated on Taito-GPU system, each GPU can be
shared between multiple MPI-tasks of the same host CPU.

The MPI message passing is usually done by sending and receiving
messages between host CPUs. However, with the advent of new CUDA-aware
MPI libraries (like OpenMPI & MVAPICH2) it is possible to exchange
messages between GPU resident data, so being able to pass the MPI
implementation a pointer to memory resident on the GPU.

This may be beneficial, since not only your code becomes more readable
(e.g. OpenACC versions), but also you avoid all the hassle in updating
back & forth the data on host CPU just for the sake of making the
message passing to work.

When using multiple nodes one needs to be extra verbose in the batch
script to ensure the correct placement of the tasks. The easiest way to
ensure correct placement is to use the `--ntasks-per-node` flag to
specify how many task each node should be running. The `--gres` flag
should be set to how many GPUs per node the job will use.

For example to run 4 tasks on 2 nodes and use 2 GPUs per node the
following batch script should be used:

    #!/bin/bash
    #SBATCH -N 2
    #SBATCH -n 4
    #SBATCH -p gpu
    #SBATCH -t 00:05:00
    #SBATCH -J gpu_job
    #SBATCH -o gpu_job.out.%j
    #SBATCH -e gpu_job.err.%j
    #SBATCH --gres=gpu:k80:2
    #SBATCH --ntasks-per-node= 2
    #SBATCH

    module purge
    module load gcc cuda
    module list

    srun ./your_binary

 
