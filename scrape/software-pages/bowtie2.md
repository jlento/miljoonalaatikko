## Bowtie2

### Description

Bowtie is an ultrafast, memory-efficient short read aligner. It aligns
short DNA sequences (reads)  to the human genome at a  rate of over 25
million  35-bp  reads per  hour.  Bowtie  indexes  the genome  with  a
Burrows-Wheeler index to keep its memory footprint small: typically
about 2.2 GB for the human genome (2.9 GB for paired-end).  
  
There are two  versions of Bowtie available: Bowtie2  and Bowtie.  The
more recent  Bowtie2 program  differs significantly from  its ancestor
Bowtie. For example  the command line options are  different for these
two tools.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: **2.3.4**,   2.1.0, 2.2.3, 2.2.5, 2.2.9, 2.3.2, 2.3.3.1  
FGI grid: 2.2.5  
[Chipster] graphical user interface

------------------------------------------------------------------------

### Usage

On Taito

    module load biokit

or

    module load biokit/4.9.3

The  biokit modules  sets up  a  set of  commonly used  bioinformatics
tools, including Bowtie, Bowtie2,  TopHat and Cufflinks. (Note however
that there  are bioinformatics  tools in Taito,  that have  a separate
setup commands.)

In typical  bowtie2 run you first  need to index the  reference genome
with bowtie2-build  command ( Note  you should  do this in  $WRKDIR in
stead of your home directory). For example;

    bowtie2-build genome.fa genome

Alternatively  you can  use  [chipster\_genomes]  command to  download
pe-calclutaed bowtie2 indexes from the CSC Chiptser server to Taito

~~~~
chipster_genomes bowtie2
~~~~

When the  reference genome  has been dowloaded  or indexed  the actual
alignment job  can be launched  with bowtie2 command. For  example for
single end reads this could be done with command:

    bowtie2 -x genome -U reads.fq -S output.sam

For paried end data the minimal bowtie syntax is:

    bowtie2 -x genome -1 first_read_set.fq -2 second_read_set.fq -S output.sam

 

**Usage in Taito**

In  Taito, bowtie  and  bowtie2  jobs should  be  run in  [taito-shell
environment] or as batch  jobs. Below is a sample batch  job file, for
running a  Bowtie2 paired end  alignment in Taito. The  recent Bowtie2
versions scale  well, so you  can effecteively use  up to 16  cores in
your batch job.

    #!/bin/bash -l
    #SBATCH -J bowtie2
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 04:00:00
    #SBATCH -p serial
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=16
    #SBATCH --mem=6000
    #

    module load biokit
    bowtie2-build genome.fasta genome
    bowtie2 -p $SLURM_CPUS_PER_TASK -x genome -1 reads_1.fq -2 reads_2.fq > output.sam

In  the batch  job example  above  one task  (-n 1)  is executed.  The
Bowtie2 job uses 16 cores (--cpus-per-task=16  ) with total of 6 GB of
memory (--mem=6000). The maximum duration of the job is four hours (-t
04:00:00  ).  All the  cores  are  assigned  from one  computing  node
(--nodes=1 ).

You  can submit  the  batch job  file  to the  batch  job system  with
command:

    sbatch batch_job_file.bash

Check the  [chapter 3] of  the Taito  user guide for  more information
about running batch jobs.

#### Running Bowtie2 alignments utilizing grid computing {#yui_patched_v3_11_0_1_1411449836059_517}

Aligning  millions of  reads  to  a large  reference  genome can  take
several   hours   or  even   days.   Using   grid  computing   through
**grid\_bowtie2** command you  can speed up the  alignment process ten
fold or more in the case of very large alignment tasks.

*grid\_bowtie2*  command  splits  the   alignment  task  into  several
subtasks that it submits to be simultaneously executed in the FGI grid
environment. When  all the subtasks  are ready they are  collected and
combined into a single result alignment.

To be able to use *grid\_bowtie2* command you should have:

1.  A valid grid certificate installed in the taito.csc.fi server.
2.  Membership of FGI Virtual Organization

Please check the [FGI User  Guide] for detailed instructions to obtain
and install a grid certificate and to join FGI Virtual organization.

Once you have  the certificate installed and  the Virtual organization
membership is approved, you can submit a *grid\_bowtie2* jobs in Taito
with for example following commands:

    module load biokit

    arcproxy -c validityPeriod=72h

    grid_bowtie2 -1 seq_set1.fq -2 seq_set2.fq -ref ref_genome.fasta -out paired_end_results

grid\_bowtie2 accepts  all the bowtie2  command line options  with one
exception: the reference sequence is always given in fasta format with
option **-ref**.  *Grid\_bowtie2* calculates automatically  the indexs
for the given reference sequence set and stores the indexes to the FGI
grid environment. If  the same fasta formatted reference  file is used
later on  with grid\_bowtie2, the  command will find the  indexes from
the FGI storage element.

The  *grid\_bowtie2*  master  process  monitors the  progress  of  the
bowtie2 sub-jobs in the FGI grid. When a sub-job finishes, the results
are retrieved and new sub-jobs  are submitted.  If the *gird\_bowtie2*
process  is  for some  reason  closed  before  all the  sub-tasks  are
processes, you can easily continue your interrupted job with command:

    bowtie2_gridrun

By  default  this command  lists  the  temporary directories  of  your
unfinished grid\_bowtie2 jobs. The number in the directory name is the
ID    number    of   you    job    (For    example   for    directory:
bowtie2\_27990\_tmpdir the ID  number is 27990). You  can continue the
interrupted grid\_bowtie2 jobs with command:

    bowtie2_gridrun -jobid ID_number

For more information about grid\_bowtie2, run command:

    grid_bowtie2 -help

 

#### More information

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

When you use Bowtie2, please cite:

Langmead   B,   Salzberg   S.    Fast   gapped-read   alignment   with
Bowtie 2. Nature Methods. 2012, 9:357-359.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More information  about Bowtie2  can be found  from the  [Bowtie2 home
page].

------------------------------------------------------------------------

  [Chipster]: http://chipster.csc.fi
  [chipster\_genomes]: https://research.csc.fi/-/chipster_indexes
  [taito-shell environment]: https://research.csc.fi/taito-shell-user-guide
  [chapter 3]: http://research.csc.fi/taito-batch-jobs
  [FGI User Guide]: https://research.csc.fi/fgi-user-guide
  [Bowtie2 home page]: http://bowtie-bio.sourceforge.net/bowtie2/index.shtml
