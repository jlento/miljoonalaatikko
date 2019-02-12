## BWA

### Description

Burrows-Wheeler Aligner (BWA) is an efficient program that aligns relatively short nucleotide sequences against a long reference sequence such as the human genome. It implements three algorithms, BWA-MEM (**mem**), BWA-Backtrack (**aln**) and BWA-SW (**bwasw**). BWA-Backtrack works for query sequences shorter than 200bp. The other two algorithms are used longer reads up to around 100kbp. BWA-MEM is recommend for reads longer than 70 gb.  Both algorithms do gapped alignment.

BWA can be used to align both single-end and paired end reads to a reference genome or sequence set.

* * *

### Available

##### Version on CSC's Servers

Taito: **0.7.17**, 0.7.15  
FGI grid: 0.6.1  
[Chipster](http://chipster.csc.fi/) graphical user interface

* * *

### Usage

To initialize the program in Taito you need to give command:

    module load biokit

The basic syntax of BWA commands is:

    bwa <command> \[options\]

**Reference genome indexing**

CSC does not maintain pre-compiled BWA indexes for reference genomes. Thus normally the fist step in creating alignment with BWA is downloading the reference genome and indexing it. Please note that your $HOME directory is often too small for working with complete genomes. In stead you should do the analysis in temporary directories like $WRKDIR.

You can use for example command ensemblfetch or wget to download a reference genome to CSC. For example

    ensemblfetch homo\_sapiens

The command above retrieves the human genome sequence to a file called. Homo\_sapiens.GRCh37.75.dna.toplevel.fa. You can calculate the BWA indexes for this file with command:

    bwa index -a bwtsw homo\_sapiens.GRCh37.75.dna.toplevel.fa

Note that for small less than 2 GB reference genomes you could use faster,  "is" indexing algorithm ( bwa index -a is )

**Single-end alignment**

Once the indexing is ready you can carry out the alignment for singe-end reads with command:

    bwa mem Homo\_sapiens.GRCh37.63.dna.toplevel.fa reads.fastq > aln.sam

If you wish to use the aln (BWA-Backtrack) algorithm you need to do the alignment in two steps.

First calculate the actual alignment:

    bwa aln Homo\_sapiens.GRCh37.63.dna.toplevel.fa reads.fastq > aln\_sa.sai

The result file is in BWA specific .sai format that you can convert to SAM format with bwa samse command:

    bwa samse Homo\_sapiens.GRCh37.63.dna.toplevel.fa aln\_sa.sai reads.fastq > aln.sam

**Paired end alignment**

If you use the MEM algorithm you can do the paired-end alignment with just one command:

    bwa mem Homo\_sapiens.GRCh37.63.dna.toplevel.fa read1.fq read2.fq > aln.sam

In this case of BWA-Backtrack algorithm you should first do a separate alignment run for each read file:

    bwa aln Homo\_sapiens.GRCh37.63.dna.toplevel.fa reads1.fq > aln1.sai
    
    bwa aln Homo\_sapiens.GRCh37.63.dna.toplevel.fa reads2.fq > aln2.sai

The two sai alignment files are combined with command bwa sampe:

    bwa sampe Homo\_sapiens.GRCh37.63.dna.toplevel.fa aln1.sai aln2.sai reads1.fq reads2.fq > aln.sam

#### Running BWA batch jobs in Taito

In Taito, BWA is initialized with command:

    module load biokit

The biokit module sets up a set of commonly used bioinformatics tools. (Note however that there are bioinformatics tools in Taito, that have a separate setup commands.)

In Taito, BWA jobs should be run as batch jobs. Below is a sample batch job file, for running a BWA job in Taito:

    #!/bin/bash -l
    #SBATCH -J bwa
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 24:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=4
    #SBATCH --mem-per-cpu=8000
    #
    
    #load the bio tools
    module load biokit
    
    # Index the reference genome
    bwa index -a bwtsw Homo\_sapiens.GRCh37.71.dna.toplevel.fa
    
    # Run the alignnments
    bwa mem -t $SLURM\_CPUS\_PER\_TASK Homo\_sapiens.GRCh37.63.dna.toplevel.fa reads1.fq reads2.fq > aln.sam

In the batch job example above one BWA task (-n 1) is executed. The BWA job uses 4 cores (--cpus-per-task=4 ) with total of 32 GB of memory (--mem-per-cpu=8000). The maximum duration of the job is four hours (-t 04:00:00 ). All the cores are assigned from one computing node (--nodes=1 ).

You can submit the batch job file to the batch job system with command:

    sbatch batch\_job\_file.bash

See the chapter 3 of the [Taito user guide](http://research.csc.fi/taito-batch-jobs) for more information about running batch jobs.

#### Running BWA alignments utilizing grid computing

Aligning millions of reads to a large reference genome can take several hours or even days. Using grid computing through grid\_bwa command you can speed up the alignment process ten fold or more. grid\_bwa command splits the alignment task into several subtasks that it submits to be simultaneously executed in the FGI grid environment. When all the subtasks are ready they are collected and combined into a single result alignment.

To be able to use grid\_bwa command you should have:

1.  A valid grid certificate installed in the hippu.csc.fi server.
2.  Membership of FGI Virtual Organization

Please check the detailed instructions to obtain and install a grid certificate and to join FGI Virtual organization.

Once you have the certificate installed and the Virtual organization membership is approved,  you can submit a grid\_bwa jobs with for example following commands:

    module load bwa
    
    module load nordugrid-arc
    
    arcproxy -c validityPeriod=72h
    
    grid\_bwa aln -query seq\_set1.fq -query2 seq\_set2.fq -ref ref\_genome.fasta -out paired\_end\_results

For more information about grid\_bwa, run command:

    grid\_bwa -help

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

More information about BWA can be found from:

*   [BWA home page](http://bio-bwa.sourceforge.net/)
*   [BWA manual](http://bio-bwa.sourceforge.net/bwa.shtml)
*   grid\_bwa scripts for local installation
*   [Grid BWA article in EMBnet Journal](http://journal.embnet.org/index.php/embnetjournal/article/view/294/707)

* * *