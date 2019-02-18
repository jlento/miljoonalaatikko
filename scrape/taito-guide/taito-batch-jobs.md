# 3. Batch jobs {#batch-jobs align="JUSTIFY"}

CSC uses batch job systems to execute computing tasks in clusters and
supercomputers. In this chapter we provide introduction to the **SLURM**
(Simple Linux Utility for Resource Management) batch job system that is
used in Taito supercluster.

Batch job systems are essential for effective usage of large computing
servers. First of all, the batch job system takes care that the server
does not get overloaded: Users can submit large amounts of jobs to be
executed and the batch job system takes automatically care that optimal
number of jobs are running, while rest of the jobs are queueing until
sufficient resources are available. Further, most of the batch job
systems have a "*fair share*" functionalities that take care that, on
the long run, all the users get equal possibilities to use resources.
For example in a case where user *A* has submitted 500 jobs before user
*B* submits his job, the user *B* don't have to wait that all the jobs
of user *A* have been processed. Instead, the batch job system gives
higher priority to the job of user *B* compared to user *A*, as user *A*
is already using much more computing resources that user *B*.

When a batch job system is used, the commands to be executed are not
started immediately like in normal interactive usage. Instead the user
creates a file that contains the Linux commands to be executed. In
addition to the commands, this so called *batch job file* normally
contains information about the resources that the job needs ( for
example: required computing time, memory and number of cores ). The
batch job file is submitted to the batch job system with a *job
submission command*. After that the batch job system checks the resource
requirements of the job, sends the job to a suitable queue and starts
the job when sufficient resources are available. If the job exceeds the
requested values (e.g. requires more computing time than what was
requested) the batch job system kills the job. After job submission,
user can follow the progress of the job or cancel the job if needed.

 

## [3.1 Constructing SLURM batch job files] {#Batchjobs-31ConstructingSLURMbatchjobfiles .western}

[3.1.1 Batch job wizard][]  
[3.1.2 Stucture of a batch job file][]  
[3.1.3 Queues and resource requests][]  
[3.1.4 Choosing between processor architectures][]  
[3.1.5 Using Scientist's User Interface to execute batch jobs]

 

## [3.2 Using SLURM commands to execute batch jobs] {#Batchjobs-32UsingSLURMcommandstoexecutebatchjobs}

 

## [3.3 Parallel batch jobs] {#Batchjobs-33Parallelbatchjobs .western}

[3.3.1 Threads based parallel jobs][]  
[3.3.2 MPI based parallel jobs]

 

## [3.4 Interactive batch jobs] {#Batchjobs-333InteractiveMPI-paralleljobs .western}

 

## [3.5 Array jobs in Taito]

[3.5.1 Defining an array job][]  
[3.5.2 Simple array job example][]  
[3.5.3 Using a file name list in an array job][]  
[3.5.4 Using array jobs in workflows with sbatch\_commandlist]

 

## [3.6 Profiling applications using Allinea Performance Reports]

[3.6.1 Using Performance Reports][]  
[3.6.2 Examining the results]

 

**Batch job examples in this guide**

[Simple batch job]

[Simple batch job with email notifications]

[Long batch job]

[Batch job with large memory reservation]

[Thread based parallel batch job example]

[MPI based parallel batch job example]

[Simple array batch job]

[Array batch job using file name list]

[Using sbatch\_commandlist in a workfow]

[Batch job example for OpenMP parallel job]

[Batch job example for hybrid parallel job]

 

 

 

  [3.1 Constructing SLURM batch job files]: https://research.csc.fi/taito-constructing-a-batch-job-file
  [3.1.1 Batch job wizard]: https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.1
  [3.1.2 Stucture of a batch job file]: https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.2
  [3.1.3 Queues and resource requests]: https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.3
  [3.1.4 Choosing between processor architectures]: https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.4
  [3.1.5 Using Scientist's User Interface to execute batch jobs]: https://research.csc.fi/taito-constructing-a-batch-job-file#3.1.5
  [3.2 Using SLURM commands to execute batch jobs]: https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs
  [3.3 Parallel batch jobs]: https://research.csc.fi/taito-running-parallel-batch-jobs
  [3.3.1 Threads based parallel jobs]: https://research.csc.fi/taito-running-parallel-batch-jobs#3.3.1
  [3.3.2 MPI based parallel jobs]: https://research.csc.fi/taito-running-parallel-batch-jobs#3.3.2
  [3.4 Interactive batch jobs]: https://research.csc.fi/taito-interactive-batch-jobs
  [3.5 Array jobs in Taito]: https://research.csc.fi/taito-array-jobs
  [3.5.1 Defining an array job]: https://research.csc.fi/taito-array-jobs#3.5.1
  [3.5.2 Simple array job example]: https://research.csc.fi/taito-array-jobs#3.5.2
  [3.5.3 Using a file name list in an array job]: https://research.csc.fi/taito-array-jobs#3.5.3
  [3.5.4 Using array jobs in workflows with sbatch\_commandlist]: https://research.csc.fi/taito-array-jobs#3.5.4
  [3.6 Profiling applications using Allinea Performance Reports]: https://research.csc.fi/taito-allinea-perf
  [3.6.1 Using Performance Reports]: https://research.csc.fi/taito-allinea-perf#3.6.1
  [3.6.2 Examining the results]: https://research.csc.fi/taito-allinea-perf#3.6.2
  [Simple batch job]: https://research.csc.fi/taito-constructing-a-batch-job-file#slurm1
  [Simple batch job with email notifications]: https://research.csc.fi/taito-constructing-a-batch-job-file#slurm2
  [Long batch job]: https://research.csc.fi/taito-constructing-a-batch-job-file#slurm9
  [Batch job with large memory reservation]: https://research.csc.fi/taito-constructing-a-batch-job-file#slurm10
  [Thread based parallel batch job example]: https://research.csc.fi/taito-running-parallel-batch-jobs#slurm3
  [MPI based parallel batch job example]: https://research.csc.fi/taito-running-parallel-batch-jobs#slurm4
  [Simple array batch job]: https://research.csc.fi/taito-array-jobs#slurm5
  [Array batch job using file name list]: https://research.csc.fi/taito-array-jobs#slurm6
  [Using sbatch\_commandlist in a workfow]: https://research.csc.fi/taito-array-jobs#slurm7
  [Batch job example for OpenMP parallel job]: https://research.csc.fi/taito-shared-memory-and-hybrid-parallelization#slurm7
  [Batch job example for hybrid parallel job]: https://research.csc.fi/taito-shared-memory-and-hybrid-parallelization#slurm8
