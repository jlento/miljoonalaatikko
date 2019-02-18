## Bowtie

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

Taito: 1.2.2, 1.1.1,  
[Chipster] graphical user interface

------------------------------------------------------------------------

### Usage

On Taito

    module load biokit

or

    module load biokit/4.9.3

The biokit modules set up a set of commonly used bioinformatics tools,
including Bowtie,  Bowtie2, TopHat  and Cufflinks. (Note  however that
there are  bioinformatics tools in  Taito, that have a  separate setup
commands.)

In typical  bowtie run you  first need  to index the  reference genome
with bowtie-build  command (  Note you  should do  this in  $WRKDIR in
stead of your home directory). For example;

    bowtie-build genome.fa genome

Alternatively  you can  use  [chipster\_genomes]  command to  download
pe-calclutaed bowtie2 indexes from the CSC Chiptser server to Taito:

~~~~
chipster_genomes bowtie
~~~~

When the  reference genome  has been dowloaded  or indexed  the actual
alignment job  can be  launched with bowtie  command. For  example for
single end reads this could be done with command:

    bowtie genome reads.fq > output.sam

**Usage in Taito**

In Taito, bowtie  and bowtie2 jobs should be run  as batch jobs. Below
is a sample batch job file, for running a bowtie job in Taito:

    #!/bin/bash -l
    #SBATCH -J bowtie
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 04:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=8
    #SBATCH --mem=8000
    #

    module load biokit
    bowtie-build genome.fasta genome
    bowtie -p $SLURM_CPUS_PER_TASK genome reads.fq > output.sam

In  the batch  job example  above  one task  (-n 1)  is executed.  The
Bowtie2 job  uses 8 cores (--cpus-per-task=8  ) with total of  6 GB of
memory (--mem=8000). The maximum duration of the job is four hours (-t
04:00:00  ).  All the  cores  are  assigned  from one  computing  node
(--nodes=1 ).

You  can submit  the  batch job  file  to the  batch  job system  with
command:

    sbatch batch_job_file.bash

Check the  [chapter 3] of  the Taito  user guide for  more information
about running batch jobs.

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

When you use Bowtie, please cite:

Langmead  B,   Trapnell  C,   Pop  M,   Salzberg  SL.   Ultrafast  and
memory-efficient alignment of short DNA sequences to the human genome.
Genome Biol 10:R25.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More  information about  Bowtie can  be  found from  the [Bowtie  home
page].

------------------------------------------------------------------------

  [Chipster]: http://chipster.csc.fi
  [chipster\_genomes]: https://research.csc.fi/-/chipster_indexes
  [chapter 3]: http://research.csc.fi/taito-batch-jobs
  [Bowtie home page]: http://bowtie-bio.sourceforge.net/index.shtml
