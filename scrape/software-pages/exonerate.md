## Exonerate

### Description

Exonerate is a generic tool for pairwise sequence comparison. It allows
you to align sequences using a many alignment models, using either
exhaustive dynamic programming, or a variety of heuristics. You can use
Exonerate for example for:

-   Aligning a cDNA to a genomic sequence
-   Aligning a protein to genomic sequence
-   6-frame translated alignment
-   Genome to genome alignment
-   Exhaustive Smith-Waterman-Gotoh alignment

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.2.0  
FGI grid: 2.2.0

------------------------------------------------------------------------

### Usage

In Taito you can use initialize Exonerate with command:

    module load biokit

The biokit module sets up a set of commonly used bioinformatics tools,
including Exonerate (Note however that there are also bioinformatics
tools in Taito, that have a separate setup commands.)

After the setup command the Exonerate commands are recognized.

For example to align cDNA to genomic sequence, you can use exonerate
command with est2genome model

    exonerate --model est2genome query.fasta target.fasta

You can see the command line options for exonerate with command:

    exonerate -h

 

In Taito, Exronerate should be executed in Taito-shell environment or as
a batch . Below is a sample batch job file, for running a Exonerate
batch job in Taito:

    #!/bin/bash -l
    #SBATCH -J exonerate_job
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 08:00:00
    #SBATCH --mem=4000
    #SBATCH -p serial
    #SBATCH -n 1

    module load biokit
    exonerate --model est2genome query.fasta target.fasta

In the batch job example above, one task (-n 1) is executed. The maximum
duration of the job is eight hours (-t 08:00:00 ) and the reserved
memory size is about 4 GB (--mem=4000).

You can submit the batch job file to the batch job system with command:

    sbatch batch_job_file.bash

Check the chapter 3 of the [Taito user guide] for more information about
running batch jobs.

**Running Exonerate alignments utilizing grid computing**

Aligning large amounts of query sequences to a target sequence set can
take several hours or even days. Using grid computing through
**grid\_exonerate** command you can speed up the alignment process ten
fold or more. **grid\_exonerate** command splits the alignment task into
several subtasks that it submits to be simultaneously executed in the
FGCI grid environment. When all the subtasks are ready they are
collected and combined into a single result alignment.

To be able to use grid\_exonerate command you should have:

1.  A valid grid certificate installed in the taito.csc.fi server.
2.  Membership of FGI Virtual Organization

Please check [FGCI user guide] the detailed instructions to obtain and
install a grid certificate and to join FGI Virtual organization.

Once you have the certificate installed and the Virtual organization
membership is approved,  you can submit *grid\_exonerate* jobs with for
example following commands:

    module load biokit

    arcproxy -S fgi.csc.fi -c validityPeriod=72h

    grid_exonerate --model est2genome --query query.fasta --target target.fasta --out result.out

 

Note that in the case of *grid\_exonerate* you must always use options
*--query*, *--target* and *--out* to define the input and output files.

For more information about grid\_exonerate, run command:

    grid_exonerate --help

**Using Exonerate in FGI**

Please check the [Exonerate Run Time Environment] page for the
instructions for using Exonerate in the FGI grid.

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

-   [Exonerate home page]
-   [Exonerate beginners guide]

------------------------------------------------------------------------

  [Taito user guide]: http://research.csc.fi/taito-batch-jobs
  [FGCI user guide]: https://research.csc.fi/fgci-user-guide
  [Exonerate Run Time Environment]: https://confluence.csc.fi/display/fgi/EXONERATE+runtime+environmnet
  [Exonerate home page]: http://www.ebi.ac.uk/~guy/exonerate/index.html
  [Exonerate beginners guide]: http://www.ebi.ac.uk/~guy/exonerate/beginner.html
