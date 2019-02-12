## Canu

### Description

Canu is a fork of the Celera Assembler, designed for high-noise single-molecule sequencing (such as the PacBio RS II or Oxford Nanopore MinION).

Canu is a hierachical assembly pipeline which runs in four steps:

*   Detect overlaps in high-noise sequences using MHAP
*   Generate corrected sequence consensus
*   Trim corrected sequences
*   Assemble trimmed corrected sequences

* * *

### Available

##### Version on CSC's Servers

Taito: 1.6, 1.7, 1.8

* * *

### Usage

To load Canu:

    module load java/oracle/1.8
    module load canu
    

To see full list of options:

    canu -options
    

Canu will split your assembly job to many smaller subjobs and will then submit these subjobs to the queue system. That means that Canu front-end program does not need to be run as a batch job. It can be run simply from the command line.

**Example**

These commands will run the example _E. coli_ assembly as described in the [Canu Quick Start guide](http://Canu Quick Start guide).

First load the sample data:

    curl -L -o p6.25x.fastq http://gembox.cbcb.umd.edu/mhap/raw/ecoli\_p6\_25x.filtered.fastq
    

Then run Canu:

    canu -p ecoli -d ecoli-auto genomeSize=4.8m -pacbio-raw p6.25x.fastq "gridOptions=-t 72:00:00" maxMemory=32 maxThreads=4
    

With this command Canu will correct the reads, then trim the reads and then assemble the reads to unitigs. You'll notice the Canu front-end program will submit the subjobs, print some information and exit. This will be quite fast. You can then use the **squeue** and **sacct** commands to check the progress of the subjobs (See [Taito User Guide](https://research.csc.fi/taito-using-slurm-commands-to-execute-batch-jobs) for more details on these commands).

    sacct
    squeue -u <username>

* * *

### Discipline

Biosciences  

* * *

### References

Berlin K, Koren S, Chin CS, Drake PJ, Landolin JM, Phillippy AM Assembling Large Genomes with Single-Molecule Sequencing and Locality Sensitive Hashing. [Nature Biotechnology](http://www.nature.com/nbt/journal/v33/n6/abs/nbt.3238.html). (2015).

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

The developers provide a [quick start guide](http://canu.readthedocs.io/en/stable/quick-start.html) and a more detailed [tutorial](http://canu.readthedocs.io/en/stable/tutorial.html).

* * *