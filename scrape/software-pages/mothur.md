## Mothur

### Description

Mothur is a bioinformatics toolkit for the needs of the microbial
ecology related data analysis.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 1.38.1.1,  1.39.5, 1.40.1

Sisu: 1.36.1

------------------------------------------------------------------------

### Usage

**Taito**

In Taito, you can use <span id="DWT647" class="ZmSearchResult"><span
id="DWT649" class="ZmSearchResult"><span id="DWT724"
class="ZmSearchResult">Mothur</span></span></span> with maximum of 24
computing cores.

<span id="DWT651" class="ZmSearchResult"><span id="DWT653"
class="ZmSearchResult"><span id="DWT726"
class="ZmSearchResult">Mothur</span></span></span> jobs can be executed
interactively in [Taito-shell] environment or in batch mode as Taito
batch jobs. In Taito-shell you can use Mothur with 4 computing cores and
128 GB of memory.

In taito-shell, you can start Mothur interactive session with commands

    module load biokit

    mothur

To run larger jobs you should collect your <span id="DWT660"
class="ZmSearchResult"><span id="DWT662" class="ZmSearchResult"><span
id="DWT731" class="ZmSearchResult">Mothur</span></span></span> commands
to a command list and use <span id="DWT664" class="ZmSearchResult"><span
id="DWT667" class="ZmSearchResult"><span id="DWT733"
class="ZmSearchResult">Mothur</span></span></span> in batch mode ( <span
id="OBJ_PREFIX_DWT665_com_zimbra_url" class="Object"><span
id="OBJ_PREFIX_DWT668_com_zimbra_url" class="Object"><span
id="OBJ_PREFIX_DWT734_com_zimbra_url"
class="Object"><http://www.mothur.org/wiki/Batch_mode></span></span></span>)  
  
Once you have a working <span id="DWT670" class="ZmSearchResult"><span
id="DWT672" class="ZmSearchResult"><span id="DWT736"
class="ZmSearchResult">Mothur</span></span></span> command file you can
launch Mothur jobs that can take several days, if needed.

Below is a sample Mothur batch job file.<span id="DWT674"
class="ZmSearchResult"><span id="DWT738" class="ZmSearchResult"> In this
example we assume that the Mothur</span></span> commands are in file:
*my\_<span id="DWT676" class="ZmSearchResult"><span id="DWT678"
class="ZmSearchResult"><span id="DWT740"
class="ZmSearchResult">mothur</span></span></span>\_task.txt*.

    #!/bin/bash -l
    #SBATCH -J mothur
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 48:00:00
    #SBATCH --nodes 1
    #SBATCH -n 1
    #SBATCH --cpus-per-task=16
    #SBATCH -p serial
    #SBATCH --mem=32000
    #

    module load biokit
    mothur my_mothur_task.txt

  
The batch job script above allows your <span id="DWT690"
class="ZmSearchResult"><span id="DWT692" class="ZmSearchResult"><span
id="DWT748" class="ZmSearchResult">Mothur</span></span></span> job to
run in maximum 48 hours using 16 cores and 32 GB of memory. In Taito,
you can use <span id="DWT647" class="ZmSearchResult"><span id="DWT649"
class="ZmSearchResult"><span id="DWT724"
class="ZmSearchResult">Mothur</span></span></span> with maximun of 24
computing cores up to 14 days. For jobs longer than three days, you
should add definition: *\#SBATCH -p longrun* to the batch job file.

Note that you must also define the number of cores to use in the Mothur
command file too.

The batch job script described above (in this case named as: *<span
id="DWT694" class="ZmSearchResult"><span id="DWT696"
class="ZmSearchResult"><span id="DWT750"
class="ZmSearchResult">mothur</span></span></span>\_batch\_job.sh*) can
be submitted to the batch job system  
with command:

    sbatch mothur_batch_job.sh

More information about running batch jobs in Taito can be found from:  
  
<span id="OBJ_PREFIX_DWT701_com_zimbra_url" class="Object"><span
id="OBJ_PREFIX_DWT753_com_zimbra_url"
class="Object"><http://research.csc.fi/taito-batch-jobs></span></span>

 

### <span class="Object"><span class="Object">Sisu</span></span>

Sisu supecomputer is intended for MPI parallel jobs that are able to
utilize more than 64 computing cores. Most of the Mothur tools can use
only one core, but there are some Mothur commands that are able to use
effectively a large batch of computing cores. These include:
**filter.seqs, dist.seqs, summary.seqs, screen.seqs, align.seqs,
classify.seqs, pairwise.seqs**.

If you are using some of the Mothur commands above, you can use Sisu for
the executing the tasks. For example to calculate a pairwise distance
matrix for sequence set *input.fasta* using 128 computing cores, you
could used a batch job file like:

    #!/bin/bash -l
    #SBATCH -J mothur_job
    #SBATCH -o mothur_job%J.out
    #SBATCH -e mothur_job%J.err
    #SBATCH -t 07:30:00
    #SBATCH -N 8
    #SBATCH -p small
    #SBATCH --ntasks-per-node=24

    (( ncores = SLURM_NNODES * 24 ))

    echo "Running mothur with $SLURM_NNODES nodes containing total of $ncores cores"

    module load mothur

    aprun -n $ncores mothur pairwise.txt

In the command script above 8 nodes (-N 8) are reserved. As each nodes
has 24 cores, a total of 192 cores will be used. Note, that the
information about the number of cores to be used must be added to the
mothur command too. In this case the command file *pairwise.txt* could
look like following:

    pairwise.seqs(fasta=input.fasta, processors=192)

The parallel mothur job is submitted in Sisu with command:

    sbatch mothur_job.sh

More information about running batch jobs in Sisu can be found from the
[Sisu user guide].

 

 

 

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Schloss, P.D., et al., Introducing mothur: Open-source,
platform-independent, community-supported software for describing and
comparing microbial communities. Appl Environ Microbiol, 2009.
75(23):7537-41.

The original tools:

Schloss, PD & Handelsman, J. (2006) Introducing SONS, a tool for
OTU-based comparisons of membership and structure between microbial
communities. Applied and Environmental Microbiology. 72:6773-9.

Schloss, PD & Handelsman, J. (2006). Introducing TreeClimber, a test to
compare community structures. Applied and Environmental Microbiology.
72: 2379-84.

Schloss, PD & Handelsman, J. (2005). Introducing DOTUR, a computer
program for defining operational taxonomic units and estimating species
richness. Applied and Environmental Microbiology. 71:1501-6.

Schloss, PD, Larget, BR, & Handelsman J. (2004). Integration of
microbial ecology and statistics: a test to compare gene libraries.
Applied and Environmental Microbiology. 70:5485-92.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [Mothur home page]

------------------------------------------------------------------------

  [Taito-shell]: https://research.csc.fi/taito-shell-user-guide
  [Sisu user guide]: https://research.csc.fi/sisu-user-guide
  [Mothur home page]: http://www.mothur.org
