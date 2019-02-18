# 3.1 Constructing a batch job file

## [][1]3.1.1 Batch Job Script Wizard {#batch-job-script-wizard style="text-align: justify;"}

The most common way to use the SLURM batch job system is to first create
a *batch job file* that is submitted to the scheduler with command
***sbatch**.* You can create batch job files with normal text editors or
you can use the <span lang="en-IE">*Batch Job Script Wizard* tool, in
the *Scientist's User Interface*(
<https://sui.csc.fi/group/sui/batch-job-script-wizard> ), (see **Figure
3.1**). In the Batch Job Script Wizard, you first select the server you
want to use and then fill in the settings for the batch job. The Batch
Job Script Wizard can't directly submit the job, but with the "Save
Script" you can save the batch job file directly to your home directory
at CSC. After that you can use the *My Files* tool to further edit and
launch the batch job (see paragraph 3.1.5).</span>

![][2]

**Figure 3.1** Batch Job Script Wizard in the scientist's user interface
(<https://sui.csc.fi/group/sui/batch-job-script-wizard>)

 

## [][3]3.1.2 Structure of a batch job file {#structure-of-a-batch-job-file style="font-style: normal;"}

Below is an example of a SLURM batch job file made with a text editor:

    #!/bin/bash -l
    #SBATCH -J hello_SLURM
    #SBATCH -o output.txt
    #SBATCH -e errors.txt
    #SBATCH -t 01:20:00
    #SBATCH -p serial
    #
    echo "Hello SLURM"

The first line of the batch job file (*<span
style="font-style: normal">\#!/bin/bash -l</span>*<span
style="font-style: normal">)</span>*<span style="font-style: normal">
</span>*defines that the *bash* shell will be used. The following five
lines <span style="font-style: normal">contain information for the batch
job scheduler. The syntax of the lines is:</span>

~~~~ western
#SBATCH -sbatch_option argument
~~~~

  
In the example above we use five *sbatch* options: ***-J*** that defines
a name for the batch job (hello\_SLURM in this case), ***-o*** defines
file name for the standard output and ***-e*** for the standard error.
***-t*** defines that the maximum duration of the job is in this case 1
hour and 20 minutes. ***-p*** defines that the job is to be send to
*serial partition*. After the batch job definitions comes the commands
that will be executed. In this case there is just one command: *echo
"Hello SLURM"* that prints text "Hello SLURM" to standard output.

The batch job file above can be submitted to the scheduler with command:

    sbatch file_name.sh 

  
The batch job file above includes only the most essential job
definitions. However, it is often mandatory or useful to use other <span
style="font-style: normal">**sbatch** </span>options too. The options
needed to run parallel jobs are discussed more in detail in the
following chapters. Table 3.1 contains some of the most commonly used
*sbatch* options. The full list of *sbatch* options can be listed with
command:

    sbatch -h

<span style="line-height: 1.5;">or</span>

~~~~
man sbatch
~~~~

**Table 3.1** Most commonly used *sbatch* options

| **Slurm option**              | **Description**                                                                                                                        |
|-------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| --begin=*time*                | Defer job until HH:MM MM/DD/YY.                                                                                                        |
| -c, --cpus-per-task=*ncpus*   | Number of cpus required per task.                                                                                                      |
| -C, --constraint=*value*      | In Taito, the --constraint=hsw option can be used to select hugemem nodes with Haswell processors and ssd-based temporary directory.   |
| -d, --dependency=*type:jobid* | Defer job until condition on jobid is satisfied.                                                                                       |
| -e, --error=*err*             | File for batch script's standard error.                                                                                                |
| --ntasks-per-node=*n*         | Number of tasks to per node.                                                                                                           |
| -J, --job-name=*jobname*      | Name of the job.                                                                                                                       |
| --mail-type=*type*            | Notify on state change: BEGIN, END, FAIL or ALL.                                                                                       |
| --mail-user=*user*            | Who to send email notification for job state changes.                                                                                  |
| -n, --ntasks=*ntasks*         | Number of tasks to run.                                                                                                                |
| -N, --nodes=*N*               | Number of nodes on which to run.                                                                                                       |
| -o, --output=*out*            | File for batch script's standard output.                                                                                               |
| -t, --time=*minutes*          | Time limit in format *hh*:*mm*:*ss*.                                                                                                   |
| --mem=MB                      | Maximum amount of real memory per node required by the job in megabytes. (Recommended for serial jobs and shared memory parallel jobs) |
| --mem-per-cpu=MB              | Maximum amount of real memory per allocated CPU required by the job in megabytes.(Recommended for MPI parallel jobs)                   |
| -p                            | Specify queue (partition) to be used. In Taito the available queues are: serial, parallel, longrun, test and hugemem.                  |

In the second batch job example below options *--mail-type* and
*--mail-user* are used to make the batch system to send e-mail to
address <kkayttaj@uni.fi> when to job ends. Further the job is defined
to reserve 4GB of memory. In the output and error file definitions *%j*
is used to use the job id-number in the file name, so that if the same
batch job file is used several times, the old output and error files
will not get overwritten.[][4]

    #!/bin/bash -l
    #SBATCH -J hello_SLURM
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 01:20:00
    #SBATCH -n 1
    #SBATCH -p serial
    #SBATCH --mail-type=END
    #SBATCH --mail-user=kkayttaj@uni.fi
    #SBATCH --mem=4096
    #

    echo "Hello SLURM"
    ./my_command

 

## [][5] {#section align="JUSTIFY"}

## 3.1.3 Queues and resource requests {#queues-and-resource-requests align="JUSTIFY"}

Setting optimal values for the requested computing time, memory and
number of cores to be used is not always a simple task. It is often
useful to first send short test jobs to get a rough estimate of the
computing time and memory requirements of the job. It is safer to
reserve more computing time than needed, but remember that jobs with
large computing time request  may, and often have to, wait longer time
in the queue than shorter jobs.

All the batch queues have maximum durations and maximum amount of nodes
that a job can use. You can check these limits with command
***[sinfo].*** For example:

    sinfo -o "%10P %.5a %.10l  %.10s %.16F "
    PARTITION  AVAIL  TIMELIMIT    JOB_SIZE   NODES(A/I/O/T)
    serial*       up 3-00:00:00           1      358/0/0/358
    parallel      up 3-00:00:00        1-28      358/0/0/358
    longrun       up 14-00:00:0           1      358/0/0/358
    test          up      30:00         1-2          2/0/0/2
    hugemem       up 7-00:00:00           1          6/0/0/6

 

The *sinfo* output above tells that the cluster has five *partitions*
(**parallel**, **serial**, **longrun**, **test** and **hugemem**). For
example, the maximum execution time in *parallel* queue is three days
(3-00:00:00) and the jobs can use use up to 28 Haswell nodes (28 \* 24=
672 cores). Similarly the maximum duration of jobs submitted to *test*
queue is 30 minutes (30:00).

The cluster partition you are using should match the reservations for
computing time, core number and memory. By default a job is submitted to
the *serial* partition, where you can run serial jobs or parallel jobs
that use up to 24 cores (one Haswell node) and require at most three
days of run time. The maximum memory that can be reserved for a job in
the *serial* partition is 256 GB. If your job requests exceeds these
limits, you must use option ***-p*** to choose a partition, which meets
the resource requests.

For example a serial job that requires 6 days of computing time can be
executed in the *longrun* partition[][6]

    #!/bin/bash -l
    #SBATCH -J longrun_SLURM
    #SBATCH -o output.txt
    #SBATCH -e errors.txt
    #SBATCH -t 6-00:00:00
    #SBATCH -p longrun
    #

    ./my_long_job

 

A small parallel job, that requires 1.0 TB of memory can be executed in
the *hugemem* partition[][7]

    #!/bin/bash -l
    #SBATCH -J longrun_SLURM
    #SBATCH -o output.txt
    #SBATCH -e errors.txt
    #SBATCH -t 06:00:00
    #SBATCH -n 1
    #SBATCH --mem-per-cpu=1000000
    #SBATCH -p hugemem
    #

    ./my_bigmemory_job

 

Estimating the memory request is even more difficult as it is dependent
on several things like algorithm and software and the analysis task. In
most case 1-4 GB is enough but you may need to increase the memory size
in the case of some application.

Command [<span style="font-style: normal">**sjstat**</span>] can be used
to check the available memory for nodes in different partitions. The
*sjstat* command lists the scheduling pool data and the running jobs.
The scheduling pool data can be used to check the available memory in
different partitions. You can check just the scheduling pool data by
adding option *-c* to the command:

    sjstat -c

    Scheduling pool data:
    -------------------------------------------------------------
    Pool        Memory  Cpus  Total Usable   Free  Other Traits
    -------------------------------------------------------------
    serial*    128600Mb    24    348    348      0  hsw,haswell,snb,sandybridge
    serial*    258000Mb    24     10     10      0  hsw,haswell,snb,sandybridge
    parallel   128600Mb    24    348    348      0  hsw,haswell,snb,sandybridge
    parallel   258000Mb    24     10     10      0  hsw,haswell,snb,sandybridge
    longrun    128600Mb    24    348    348      0  hsw,haswell,snb,sandybridge
    longrun    258000Mb    24     10     10      0  hsw,haswell,snb,sandybridge
    test       128600Mb    24      2      2      2  hsw,haswell,snb,sandybridge
    hugemem   1551000Mb    32      2      2      0  bigmem,snb,sandybridge
    hugemem   1551000Mb    40      4      4      0  bigmem,hsw,haswell,ssd

The sample listing above tells e.g. that resource pool *test* contains 2
nodes, each having 128 GB of memory and 24 cores.

**Table 3.2** Available batch job queues in supercluster taito.csc.fi.

|                  |                             |                      |
|------------------|-----------------------------|----------------------|
| **Queue**        | **Maximum number of cores** | **Maximum run time** |
| serial (default) | 24 (one node)               | 3 days               |
| parallel         | 672 (28 nodes)              | 3 days               |
| longrun          | 24 (one node)               | 14 days              |
| hugemem          | 32/40 (one node\*)          | 7/14 days\*\*        |
| test             | 48 (two nodes)              | 30 min               |

\* Sandy Bridge / Haswell (one Sandy Bridge node consists of 32 and
Haswell one of 40 cores)  
\*\* For exceptionally long hugemem jobs, the [maximum run time can be
extended up to 14 days] using SBATCH option --qos=hugememlong .

 

##  

[][8]

## 3.1.4 Choosing between processor architectures in hugemem queue

If a code is compiled with Haswell processor specific optimization
parameters, it will not work in the Sandy Bridge processors. In these
cases it is necessary to submit the job so that it will use only Haswell
based nodes. This can be specified with by adding following constraint
parameter to the batch job file:

    #SBATCH --constraint=hsw

 

Similarly, if you for some reason want to use only Sandy bridge
processors, you should use constraint (Sandy bridge nodes has been
removed):

    #SBATCH --constraint=snb

 

Currently only the **hugemem queue** has nodes with Sandy Bridge
processors. By adding defintion --constraint=hsw  to your batch job
script you can ensure that in the newer Haswell based *hugemem* nodes
that have the fast SSD based local temporary storage.

 

[][9]

## 3.1.5 Using Scientist's User Interface to execute batch jobs {#using-scientists-user-interface-to-execute-batch-jobs .western}

*My Files* tool in Scientist's User interface web portal
(<https://sui.csc.fi/group/sui/my-files>) can be used to transfer and
access data in CSC's storage systems (see C[hapter 5.1 of CSC computing
environment user guide] for details). In addition to data management, My
Files allows users to submit batch jobs for execution. In My Files,
select computing host (for example, Taito) and then browse in $WRKDIR in
directory where your job script is saved. Then select job script file
and right-click with mouse. This will open a context menu showing action
"*Submit Batch Job*". Selecting this action will send your job script
for computation. 

![][10]

**Figure 3.2** Submitting job with My Files in Scientist's User
Interface (<https://sui.csc.fi/group/sui/my-files>)

 

 

 

  [1]: https://research.csc.fi/ {#3.1.1}
  [2]: https://research.csc.fi/documents/48467/84606/batch-job-wizard.jpg/9467ad68-2cd4-4e1c-92be-9dea672483a8?t=1395125836776
  [3]: https://research.csc.fi/ {#3.1.2}
  [4]: https://research.csc.fi/ {#slurm2}
  [5]: https://research.csc.fi/ {#3.1.3}
  [sinfo]: https://research.csc.fi/ {#sinfo}
  [6]: https://research.csc.fi/ {#slurm9}
  [7]: https://research.csc.fi/ {#slurm10}
  [<span style="font-style: normal">**sjstat**</span>]: https://research.csc.fi/
  {#sjstat}
  [maximum run time can be extended up to 14 days]: https://research.csc.fi/-/how-can-i-run-hugemen-jobs-that-are-longer-than-7-days-
  [8]: https://research.csc.fi/ {#3.1.4}
  [9]: https://research.csc.fi/ {#3.1.5}
  [hapter 5.1 of CSC computing environment user guide]: https://research.csc.fi/csc-guide-data-transport-with-scientist-s-user-interface
  [10]: https://research.csc.fi/documents/48467/84606/submit-job-my-files.png/9dea4eb9-b42b-4f72-a88e-e0f4fc61a960?t=1395403415245
