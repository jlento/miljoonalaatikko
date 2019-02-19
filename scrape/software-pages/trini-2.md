## Trinity

### Description

<span style="text-align: justify;">Trinity is used for de novo
reconstruction of transcriptomes from RNA-seq data. Trinity combines
three independent software modules:</span>** Inchworm**<span
style="text-align: justify;">, </span>**Chrysalis**<span
style="text-align: justify;">, and </span>**Butterfly**<span
style="text-align: justify;">, applied sequentially to process large
volumes of RNA-seq reads. Trinity partitions the sequence data into many
individual de Bruijn graphs, each representing the transcriptional
complexity at at a given gene or locus, and then processes each graph
independently to extract full-length splicing isoforms and to tease
apart transcripts derived.</span>

The Trinity module at CSC also includes [TransDecoder] and [Trinonate]
tools to anlyze the results of a Trinity run.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.3.2 , 2.4.0, 2.5.1, 2.6.5, 2.6.6

------------------------------------------------------------------------

### Usage

**Using Trinity in Taito**

In Taito Trinity is set up with commands

    module load biokit/4.9.3
    module load trinity

The biokit module sets up a set of commonly used bioinformatics tools.
Trinity however, needs a separate set up command too. The reason for
this is that Trinity uses older version of SAMtools software (0.1.19)
than what is the default in the biokit selection.  
  
Trinity should be used using interactively in [Taito-shell] or
preferably through the batch job system. Below is a sample batch job
file for Trinity.

    #!/bin/bash -l
    #SBATCH -J trinity
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 48:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=6
    #SBATCH --mem-per-cpu=4000
    #

    module load biokit/4.9.3
    module load trinity

    Trinity --seqType fq --max_memory 22G --left reads.left.fq --right \
    reads.right.fq --SS_lib_type RF --CPU $SLURM_CPUS_PER_TASK \
    --output trinity_run_out --grid_exec sbatch_commandlist

The command script above reserves 6 computing cores from one node for
the job. The maximal run time of the sample job here is 48 hours. About
4 GB of memory is reserved for each core so the total memory reservation
is 6 \* 4 GB= 24 GB. Note 1: since Trinity version 2.0 the memory is
reserved with option --max\_memory not -JM.  
  
In the actual *Trinity* command the number of computing cores to be used
(--CPU) is set using environment variable: $SLURM\_CPUS\_PER\_TASK. This
variable contains the value set the *--cpus-per-task* SLURM option.  
  
In Taito you can also use distributed computing to speed up the trinity
job. When definition:

    --grid_exec sbatch_commandlist

is added to the command, some phases of the analysis tasks are executed
as a set of parallel subjobs in Taito. (Note 2: since Trinity 2.3.2
setting --grid\_exec sbatch\_commandlist repalaces the previously used
--grid\_conf $TRINITY\_HOME/hpc\_conf/taito.slurm ). For large Trinity
tasks the settings of the *sbatch\_commandlist* tool are too limited. In
these cases replace *sbatch\_commandlist* with
*sbatch\_commandlist\_trinity*.

    --grid_exec sbatch_commandlist_trinity

When the batch job file is ready, it can be submitted to the batch queue
system with command

    sbatch batch_job_file

More information about running batch jobs, can be found from
the [chapter three of the Taito user guide].

Please check the Trinity site to get [hints for estimating the required
resources,]

 

### Using autoTrinotate in Taito

To analyse the results of your Trinity job with *autoTrininotate*, you
must first create Trinotate-SQLite database that will be used to store
the results of your autoTrinotate.  This database is created with
command:

    $TRINOTATE_HOME/admin/Build_Trinotate_SQLite_db.pl my_db_name

(Note that the command above is different as what is used in the
Trinotate home page as the command has been slightly modified for Taito)

After these settings you can launch autoTrinotate with command:<span
id="cke_bm_880E" style="display: none;"> </span>

    $TRINOTATE_HOME/auto/autoTrinotate.pl --Trinotate_sqlite my_db_name.sqlite --transcripts transcripts.fasta --gene_to_trans_map gene_to_trans_map --conf $TRINOTATE_HOME/auto/conf.txt --CPU 4

Note that autoTrinotate analysis can require much resources so you
should execute the command in Taito-shell or as batch job.

AutoTrioritontate produces a SQLite database file that can be further
analyzed with command:

    $TRINOTATE_HOME/Trinotate

 

 

 

 

 

 

 

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

-   [Trinity home page]

------------------------------------------------------------------------

  [TransDecoder]: https://transdecoder.github.io/
  [Trinonate]: https://trinotate.github.io/
  [Taito-shell]: https://research.csc.fi/taito-shell-user-guide
  [chapter three of the Taito user guide]: https://research.csc.fi/taito-batch-jobs
  [hints for estimating the required resources,]: https://github.com/trinityrnaseq/trinityrnaseq/wiki/Trinity-Computing-Requirements
  [Trinity home page]: http://trinityrnaseq.github.io/
