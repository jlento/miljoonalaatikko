## Trimmomatic

### Description

Trimmomatic performs a variety of useful trimming tasks for illumina paired-end and single ended data.

* * *

### Available

##### Version on CSC's Servers

Taito: 0.33

* * *

### Usage

In Taito, trimmomatic can be launched with command:

    trimmomatic

This command corresponds the trimmoamatic launch command:  
_java -jar /appl/bio/trimmomatic/Trimmomatic-0.33/trimmomatic-0.33.jar_

The sample adapter sequence sets provided be trimmomatic can be found in Taito in directory: **/appl/bio/trimmomatic/adapters**.

The selection of trimming steps and their associated parameters are supplied on the trimmomatic command line.

The current trimming steps are:

*   ILLUMINACLIP: Cut adapter and other illumina-specific sequences from the read.
*   SLIDINGWINDOW: Perform a sliding window trimming, cutting once the average quality within the window falls below a threshold.
*   LEADING: Cut bases off the start of a read, if below a threshold quality
*   TRAILING: Cut bases off the end of a read, if below a threshold quality
*   CROP: Cut the read to a specified length
*   HEADCROP: Cut the specified number of bases from the start of the read
*   MINLEN: Drop the read if it is below a specified length
*   TOPHRED33: Convert quality scores to Phred-33
*   TOPHRED64: Convert quality scores to Phred-64

Trimmomatic works with FASTQ (using phred + 33 or phred + 64 quality scores, depending on the Illumina pipeline used), either uncompressed or gzipp'ed FASTQ. Use of gzip format is determined based on the .gz extension.

For _single-ended_(SE) data, one input and one output file are specified, plus the processing steps. For _paired-end_ (PE) data, two input files are specified, and 4 output files, 2 for the 'paired' output where both reads survived the processing, and 2 for corresponding 'unpaired' output where a read survived, but the partner read did not.

Note that by default Trimmomatic tries to use all the computing cores of the server where it is launched. In Taito this approach is not feasible and **you should always use command line option -threads to limit the number of cores to be used**. Note that the _\-threads_ option shuld be given immediately after the mode selection (SE or PE).

In taito-shell, this value should be four or less. In the Taito login nodes, you should use just one core and in the batch jobs, this value should be equal to the number of cores reserved ( --cpus-per-task) (max. 16 cores).

A sample trimmomatic command for taito-shell ( character: \\ indicates that the command line continues to the next row) :

    trimmomatic PE -threads 4 -phred64 forward.fq.gz reverse.fq.gz \\
    out\_fw\_paired.fq.gz out\_fw\_unpaired.fq.gz out\_rev\_paired.fq.gz out\_rev\_unpaired.fq.gz \\
    ILLUMINACLIP:/appl/bio/trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 \\
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

Same task as a batch job reserving 8 cores, 12 hours and 8 GB of memory:

    #!/bin/bash
    #SBATCH -J trimmomatic
    #SBATCH -N 1
    #SBATCH -p serial
    #SBATCH -t 12:00:00
    #SBATCH --mem=8000
    #SBATCH -o out\_%j.txt
    #SBATCH -e err\_%j.txt
    #SBATCH --cpus-per-task=8
    
    trimmomatic PE -threads 8 -phred64 forward.fq.gz reverse.fq.gz \\
    out\_fw\_paired.fq.gz out\_fw\_unpaired.fq.gz out\_rev\_paired.fq.gz out\_rev\_unpaired.fq.gz \\
    ILLUMINACLIP:/appl/bio/trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 \\
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

The batch job could be launched with command:

    sbatch _trimmomatic\_script_

More information about running batch jobs can be found form [chapter 3 of the Taito User Guide](/taito-batch-jobs).

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

*   [Trimmomatic home page](http://www.usadellab.org/cms/?page=trimmomatic)

* * *