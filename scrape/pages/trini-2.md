## Trinity

### Description

Trinity is used for de novo reconstruction of transcriptomes from RNA-seq data. Trinity combines three independent software modules:** Inchworm**, **Chrysalis**, and **Butterfly**, applied sequentially to process large volumes of RNA-seq reads. Trinity partitions the sequence data into many individual de Bruijn graphs, each representing the transcriptional complexity at at a given gene or locus, and then processes each graph independently to extract full-length splicing isoforms and to tease apart transcripts derived.

The Trinity module at CSC also includes [TransDecoder](https://transdecoder.github.io/) and [Trinonate](https://trinotate.github.io/) tools to anlyze the results of a Trinity run.

* * *

### Available

##### Version on CSC's Servers

Taito: 2.3.2 , 2.4.0, 2.5.1, 2.6.5, 2.6.6

* * *

### Usage

**Using Trinity in Taito**

In Taito Trinity is set up with commands

    module load biokit/4.9.3
    module load trinity

The biokit module sets up a set of commonly used bioinformatics tools. Trinity however, needs a separate set up command too. The reason for this is that Trinity uses older version of SAMtools software (0.1.19) than what is the default in the biokit selection.  
  
Trinity should be used using interactively in [Taito-shell](/taito-shell-user-guide) or preferably through the batch job system. Below is a sample batch job file for Trinity.

    #!/bin/bash -l
    #SBATCH -J trinity
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 48:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=6
    #SBATCH --mem-per-cpu=4000
    #
    
    module load biokit/4.9.3
    module load trinity
    
    Trinity --seqType fq --max\_memory 22G --left reads.left.fq --right \\
    reads.right.fq --SS\_lib\_type RF --CPU $SLURM\_CPUS\_PER\_TASK \\
    --output trinity\_run\_out --grid\_exec sbatch\_commandlist
    

The command script above reserves 6 computing cores from one node for the job. The maximal run time of the sample job here is 48 hours. About 4 GB of memory is reserved for each core so the total memory reservation is 6 \* 4 GB= 24 GB. Note 1: since Trinity version 2.0 the memory is reserved with option --max\_memory not -JM.  
  
In the actual _Trinity_ command the number of computing cores to be used (--CPU) is set using environment variable: $SLURM\_CPUS\_PER\_TASK. This variable contains the value set the _\--cpus-per-task_ SLURM option.  
  
In Taito you can also use distributed computing to speed up the trinity job. When definition:

    \--grid\_exec sbatch\_commandlist

is added to the command, some phases of the analysis tasks are executed as a set of parallel subjobs in Taito.  (Note 2: since Trinity 2.3.2 setting --grid\_exec sbatch\_commandlist repalaces the previously used --grid\_conf $TRINITY\_HOME/hpc\_conf/taito.slurm ). For large Trinity tasks the settings of the _sbatch\_commandlist_ tool are too limited. In these cases replace _sbatch\_commandlist_ with _sbatch\_commandlist\_trinity_.

    \--grid\_exec sbatch\_commandlist\_trinity

When the batch job file is ready, it can be submitted to the batch queue system with command

    sbatch batch\_job\_file

More information about running batch jobs, can be found from the [chapter three of the Taito user guide](/taito-batch-jobs).

Please check the Trinity site to get [hints for estimating the required resources,](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Computing-Requirements)

### Using autoTrinotate in Taito

To analyse the results of your Trinity job with _autoTrininotate_, you must first create Trinotate-SQLite database that will be used to store the results of your autoTrinotate.  This database is created with command:

    $TRINOTATE\_HOME/admin/Build\_Trinotate\_SQLite\_db.pl _my\_db\_name_

(Note that the command above is different as what is used in the Trinotate home page as the command has been slightly modified for Taito)

After these settings you can launch autoTrinotate with command:

    $TRINOTATE\_HOME/auto/autoTrinotate.pl --Trinotate\_sqlite _my\_db\_name_.sqlite --transcripts _transcripts.fasta_ --gene\_to\_trans\_map _gene\_to\_trans\_map_ --conf $TRINOTATE\_HOME/auto/conf.txt --CPU 4
    

Note that autoTrinotate analysis can require much resources so you should execute the command in Taito-shell or as batch job.

AutoTrioritontate produces a SQLite database file that can be further analyzed with command:

    $TRINOTATE\_HOME/Trinotate

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

*   [Trinity home page](http://trinityrnaseq.github.io/)

* * *