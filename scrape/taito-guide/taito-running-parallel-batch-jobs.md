### <span style="font-size: 26px; font-weight: 400;">3.3 Parallel batch jobs</span> {#parallel-batch-jobs .western}

Two approaches are commonly used in creating software that are able to
utilize several computing cores. Message Passing interface (MPI) based
methods and threads based programs (POSIX-threads, OpenMP).
Considering CSC resources, Sisu supercomputer is intended for large MPI
based parallel jobs but smaller MPI jobs can be run in the Taito
supercluster too. In case of threads-based parallel programs, the jobs
should be executed mainly in the Taito supercluster.

## [][1]3.3.1 Threads-based parallel jobs {#Batchjobs-331Threadsbasedparalleljobs}

In case of threads-based parallel computing, the number of parallel
processes (threads) is limited by the structure of the hardware: all the
processes must be running in the same node. Thus in the *Haswell* nodes
Taito cluster, threads-based programs can't use more than 24 computing
cores.

*Sbatch* option **--*****cpus-per-task**=number\_of\_cores* is used the
define the number of computing cores that the batch job task will use.
Option **--nodes=1** ensures that all the reserved cores will be located
in the same node and **-n 1** will assign all the reserved computing
cores for the one same task.

In the case of threads-based jobs, the **--mem** option is recommended
for memory reservation. This option defines the amount of memory needed
per node. Note that if you use **--mem-per-cpu** option instead, the
total memory request of the job will be memory request multiplied by the
*number-of-cpus*. Thus if you modify the number of cores to be used, you
should check the memory reservation too.

Below is a sample batch job that uses bowtie2 software that can use
threads-based parallelization.[][2]

    #!/bin/bash -l
    #SBATCH -J bowtie2
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 02:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1
    #SBATCH --cpus-per-task=6
    #SBATCH -p serial
    #SBATCH --mem=6000
    #

    module load biokit
    bowtie2-build chr_18.fa chr_18
    bowtie2 -p $SLURM_CPUS_PER_TASK -x chr_18 -1 y_1.fq -2 y_2.fq > output.sam 

In the example above, one task (-n 1) that uses 6 cores
(--cpus-per-task=6) with total of 6 GB of memory (--mem=6000) is
reserved for two hours (-t 02:00:00). All the cores are assigned from
one computing node (--nodes=1). When the job starts, the CSC
bioinformatics environment, that includes Bowtie2, is first set up with
command:

~~~~ western
module load biokit
~~~~

After that two bowtie2 commands are executed. The indexing command,
*bowtie2-build*, does not utilize parallel computing. In case of the
*bowtie2* command, the number of cores to be used is defined with
option* -p*. In this case we are using six cores so the definition could
be: *-p 6*. However in this case we use environment variable
$SLURM\_CPUS\_PER\_TASK instead. This variable contains the number of
cores defined by the * -**-cpus-per-task* option. Thus by using
$SLURM\_CPUS\_PER\_TASK we don't have to modify the *bowite2-align*
command if we change the number of cores to be used with the SBATCH
options.

## [][3] 3.3.2 MPI-based parallel jobs {#Batchjobs-332MPIbasedparalleljobs .western}

To compile Fortran + MPI code the following command can be used:

     mpif90 my_mpi_prog.f95 -o my_mpi_program

The output executable program *my\_mpi\_program* is created.

Exemplary script for running MPI-based parallel job:[][4]

    #!/bin/bash -l
    ###
    ### parallel job script example
    ###
    ## name of your job
    #SBATCH -J my_jobname
    ## system error message output file
    #SBATCH -e my_output_err_%j
    ## system message output file
    #SBATCH -o my_output_%j
    ## a per-process (soft) memory limit
    ## limit is specified in MB
    ## example: 1 GB is 1000
    #SBATCH --mem-per-cpu=1000
    ## how long a job takes, wallclock time hh:mm:ss
    #SBATCH -t 11:01:00
    ##the number of processes (number of cores)
    #SBATCH -n 24
    ##parallel queue
    #SBATCH -p parallel
    ## run my MPI executable
    srun ./my_mpi_program

 

## 3.3.3 Interactive MPI-parallel jobs {#Batchjobs-333InteractiveMPI-paralleljobs .western}

The output executable program *my\_mpi\_program* can be run
interactively with commands:

    salloc -n 48 --ntasks-per-node=24 --mem-per-cpu=1000 -t 00:30:00 -p parallel
    srun ./my_mpi_program
    exit

Options:  
**-n** number of processes (number of cores)  
**--ntasks-per-node** On Taito there are 24 cores per node.That way your
job will be distributed so that the number nodes is minimized  
**-t** running time, wallclock, format **hh:mm:ss**
(**hours:minutes:seconds**)  
**--mem-per-cpu** per process memory limit (MB)

Other way (one-liner):

~~~~ western
salloc -n 48 --ntasks-per-node=24 --mem-per-cpu=1000 -t 00:30:00 -p parallel srun ./my_MPI_executable
~~~~

One can also use --**ntasks-per-node** option to control how the job is
distributed to the nodes of the cluster.

## 3.3.4 Choosing between Sandy Bridge or Haswell nodes

Haswell processors can run code optimized for Sandy Bridge processors,
but Sandy Bridge processors cannot run Haswell optimized executables.
Currently there are two hugemem nodes that still use the the older Sandy
Bridge processors. If you have to run binaries that require the older
architecture on hugemem partition, you have to add `--constraint=snb`
option to the batch job script (Sandy Bridge nodes has been removed).

 

 

  [1]: https://research.csc.fi/ {#3.3.1}
  [2]: https://research.csc.fi/ {#slurm3}
  [3]: https://research.csc.fi/ {#3.3.2}
  [4]: https://research.csc.fi/ {#slurm4}
