## TopHat

### Description

TopHat is a  fast splice junction mapper for RNA-Seq  reads. It aligns
RNA-Seq   reads   to   mammalian-sized   genomes   using   the   ultra
high-throughput  short  read aligner  Bowtie,  and  then analyzes  the
mapping results to identify splice junctions between exons.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.1.0  
FGI grid: 1.3.2, 2.0.0  
[Chipster] graphical user interface

------------------------------------------------------------------------

### Usage

In Taito cluster tophat is initialized with command:

    module load biokit

The biokit module sets up a set of commonly used bioinformatics tools,
including Bowtie,  Bowtie2, TopHat  and Cufflinks. (Note  however that
there are  bioinformatics tools in  Taito, that have a  separate setup
commands.).

In Taito, tophat jobs  should be run as batch jobs.  Below is a sample
batch job file, for running a TopHat job in Taito:

    #!/bin/bash -l
    #SBATCH -J TopHat
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 24:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=4
    #SBATCH --mem-per-cpu=4000
    #

    module load biokit
    tophat -p $SLURM_CPUS_PER_TASK -o tophat_results Homo.sapiens_bwt2_index reads1.fq reads2 

In the  batch job  example above,  one task (-n  1) is  executed.  The
Tophat job  uses 4 cores (--cpus-per-task=4  ) with total of  16 GB of
memory  (--mem-per-cpu=4000).  The  maximum  duration of  the  job  is
twentyfour hours (-t  24:00:00 ). All the cores are  assigned from one
computing node (--nodes=1 ).

You  can submit  the  batch job  file  to the  batch  job system  with
command:

    sbatch batch_job_file.bash

Check the  chapter 3  of the [Taito  user guide] for  more information
about running batch jobs.

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More  information about  TopHat  can be  found  from the [TopHat  home
page].

------------------------------------------------------------------------

  [Chipster]: http://chipster.csc.fi/
  [Taito user guide]: http://research.csc.fi/taito-batch-jobs
  [TopHat home page]: http://tophat.cbcb.umd.edu/
