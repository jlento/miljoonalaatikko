## STAR

### Description

STAR (Spliced Transcripts Alignment to a Reference) is a fast NGS read
aligner for  RNA-seq data.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.5.2b

------------------------------------------------------------------------

### Usage

Before you can run the actual alignment job, you must index your fasta
formatted reference genome.  In Taito the working  copies of reference
genome indexes,  as well as any  large files, should be  stored to the
work directory ($WRKDIR). In this example  we store the indexes to the
directory $WRKDIR/star-genomes.

First the reference genome index directory is generated with command:

    mkdir $WRKDIR/star-genome

After that, the indexing can be done with command:

    STAR --runMode genomeGenerate --genomeDir $WRKDIR/star-genome --genomeFastaFiles /path/to/genome/genome.fasta --runThreadN 2

Once  the   indexing  is   done  the  actual   mapping  task   can  be
launched.  STAR will  generate  the mapping  output  using fixed  file
names. Because of that it is recommended  that each STAR job is run in
a  new, empty  directory.  In  Taito you  should create  this new  job
directory  to  your work  directory  ($WRKDIR).  New directory  called
*starjob1* can be created with command:

    mkdir $WRKDIR/starjob1

after that the actual mapping job can be launched with commands:

    cd $WRKDIR/starjob1
    STAR --genomeDir $WRKDIR/star-genomes --readFilesIn my_reads.fastq

The default parameters,  that STAR uses, are typical  for mapping 2x76
or 2x101  Illumina reads  to the  human genome.  In Taito  the default
parameter settings are available in file:

    /appl/bio/star/STAR-STAR_2.4.0a/parametersDefault

In  Taito, all  heavier computing  tasks should  be executed  as batch
jobs.    In   batch  jobs   you   can   also  utilize   thread   based
parallelization. Bellow is  a sample batch job file for  STAR. The job
uses  six computing  cores from  a single  computing node.  The memory
reservation is 24 GB (4GB/core \* 6 cores).

    #!/bin/bash -l
    #SBATCH -J STAR
    #SBATCH -o STAR.stdout
    #SBATCH -e STAR.stderr
    #SBATCH -n 6
    #SBATCH -t 12:00:00
    #SBATCH --nodes=1
    #SBATCH --mem-per-cpu=4000

    # calculate indexes. You don't need to recalculte the indexes if they already exist.
    mkdir $WRKDIR/star-genome
    STAR --runMode genomeGenerate --genomeDir $WRKDIR/star-genome --genomeFastaFiles /path/to/genome/genime.fasta --runThreadN 6

    # Run the mapping task
    mkdir $WRKDIR/starjob1
    cp my_reads.fastq
    STAR --genomeDir $WRKDIR/star-genome --readFilesIn my_reads.fastq --runThreadN 6

The batch job script is launced woith command sbatch. For example:

    sbatch starjob1.sh

More informtion about  running batch jobs in Taito, can  be found from
[chapter 3] of the Taito User Guide.

 

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

[STAR arcticle in Bioinformatics Joural 2012]

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[STAR user manual]

[STAR home page]

------------------------------------------------------------------------

  [chapter 3]: https://research.csc.fi/taito-batch-jobs
  [STAR arcticle in Bioinformatics Joural 2012]: http://bioinformatics.oxfordjournals.org/content/early/2012/10/25/bioinformatics.bts635
  [STAR user manual]: http://code.google.com/p/rna-star/downloads/detail?name=STARmanual_2.3.0.1.pdf&can=2&q=
  [STAR home page]: http://code.google.com/p/rna-star/
