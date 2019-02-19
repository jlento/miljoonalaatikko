## QIIME

### Description

QIIME (Quantitative Insights Into Microbial Ecology) is a package for
comparison and analysis of microbial communities, primarily based on
high-throughput amplicon sequencing data (such as SSU rRNA) generated on
a variety of platforms, but also supporting analysis of other types of
data (such as shotgun metagenomic data). QIIME takes users from their
raw sequencing output through initial analyses such as OTU picking,
taxonomic assignment, and construction of phylogenetic trees from
representative sequences of OTUs, and through downstream statistical
analysis, visualization, and production of publication-quality graphics.

On 2017 a totally rewritten version of Qiime: Qiime2 was released. The
development of the original Qiime version has stopped. At the moment
both Qiime2 and Qiime 1.9.1 are available in Taito.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2-2018.4, 1.9.1 , 1.8.0

------------------------------------------------------------------------

### Usage

## Qiime2 in Taito {#qiime2-in-taito .Subheading}

To use Qiime2 in Taito you should run following setup commands:

~~~~ Subheading
module load qiime
source activate qiime2-2018.4
source tab-qiime
~~~~

After that you can start Qiime2 with command:

    qiime

Please check [Qiime2 home page] for more instructions.

##   {#section .Subheading}

## Qiime 1.9.1 in Taito {#qiime-1.9.1-in-taito .Subheading}

Note: All the documentation below refer to the old Qiime versions.

To use  QIIME 1.9.1  in Taito you first need to run set-up commands

    module load biokit
    module load qiime/1.9.1

After that you can start executing QIIME commands like:

    check_id_map.py -m Fasting_Map.txt -o mapping_output

 

### Using parallel computing

In Taito cluster you can run some QIIME tasks using parallel computing.
The parallelization has been implemented by CSC so that it utilizes the
batch job system of Taito.

If you are using **QIIME wrapper scripts** that can utilize
parallelization (i.e. has option **-a** available) it is enough that you
add option *-a* to the command (excluding denoising tools. See below).
For example:

    pick_de_novo_otus.py -i split_library_output/seqs.fna -o otus -a

Adding option *-a* to the command makes the QIIME command to create a
set of commands that will be automatically executed as an array job in
the batch job system of Taito. Thus you can utilize the full capacity of
Taito cluster without constructing and managing the batch jobs yourself.
QIIME will do that for you.

QIIME wrapper scripts that can utilize parallel computing:

-   [***alpha\_rarefaction.py*** – A workflow script for performing
    alpha rarefaction]
-   [***beta\_diversity\_through\_plots.py*** – A workflow script for
    computing beta diversity distance matrices and generating PCoA
    plots]
-   [***core\_diversity\_analyses.py*** – A workflow for running a core
    set of QIIME diversity analyses.]
-   [***jackknifed\_beta\_diversity.py*** – A workflow script for
    performing jackknifed UPGMA clustering and building jackknifed
    Emperor PCoA plots.]
-   [***pick\_closed\_reference\_otus.py*** – Closed-reference OTU
    picking/Shotgun UniFrac workflow.]
-   [***pick\_de\_novo\_otus.py*** – A workflow for de novo OTU picking,
    taxonomy assignment, phylogenetic tree construction, and OTU table
    construction.]
-   [***pick\_open\_reference\_otus.py*** – Perform open-reference OTU
    picking]

 

It is recommended to run the QIIME commands either as interactive
processes in [taito-shell.csc.fi] environment or as [batch jobs]. Note
that if you launch a parallel QIIME tasks as a batch job, you don't need
to reserve more than one core in your batch job script file. This is
because the wrapper that executes the parallel QIIME tasks automatically
writes a second batch job file that includes the resource reservations
for the parallel part of your QIIME workflow.

In the case of **QIIME commands**, following commands are available as
parallel versions. In these cases you just need to use the command
starting with definition *parallel\_* in stead of the normal QIIME
command.

-   [*parallel\_alpha\_diversity.py* – Parallel alpha diversity]
-   [*parallel\_assign\_taxonomy\_blast.py* – Parallel taxonomy
    assignment using BLAST]
-   [*parallel\_assign\_taxonomy\_rdp.py* – Parallel taxonomy assignment
    using RDP]
-   [*parallel\_assign\_taxonomy\_uclust.py* – Parallel taxonomy
    assignment using the uclust consensus taxonomy assignment]
-   [*parallel\_beta\_diversity.py* – Parallel beta diversity]
-   [*parallel\_blast.py* – Parallel BLAST]
-   [*parallel\_identify\_chimeric\_seqs.py* – Parallel chimera
    detection]
-   [*parallel\_map\_reads\_to\_reference.py* –]
-   [*parallel\_merge\_otu\_tables.py* – Parallel merge BIOM tables]
-   [*parallel\_multiple\_rarefactions.py* – Parallel multiple file
    rarefaction]
-   [*parallel\_pick\_otus\_blast.py* – Parallel pick otus using BLAST]
-   [*parallel\_pick\_otus\_sortmerna.py* – Parallel pick otus using
    SortMeRNA]
-   [*parallel\_pick\_otus\_trie.py* – Parallel pick otus using a trie]
-   [*parallel\_pick\_otus\_uclust\_ref.py* – Parallel pick otus using
    uclust\_ref]
-   [*parallel\_pick\_otus\_usearch61\_ref.py* – Parallel pick otus
    using usearch\_ref]

Below is an example batch job file for running pick\_de\_novo\_otus.py
command:

~~~~ toctree-l1
#!/bin/bash
#SBATCH -t 12:00:00
#SBATCH --mem=32000
#SBATCH -J pick_otus
#SBATCH -o pick_otus_job%j.out
#SBATCH -e pick_otus_job%j.err
#SBATCH -p serial
#SBATCH --nodes=1
#SBATCH -n 1

module load biokit
module load qiime

pick_de_novo_otus.py -i split_library_output/seqs.fna -o otus -a
~~~~

If the above batch job file is named as *pick\_outs.sh* it can be
submitted to the batch job system with command:

    sbatch pick_otus.sh

More information about batch jobs in the [chapter 3 of the Taito user
guide].

### Using parallel computing for denoising

The *denoising* commands are not compatible with the default QIIME
parallelization system in Taito. To enable the usage of parallel
denoising tools you have to use denoiser specific *QIIME configuration
file.* This is defined with command:

    export QIIME_CONFIG_FP=/appl/bio/qiime/1.9.1/qiime_config_denoiser

After this you can use for example *denoise\_wrapper.py* command with
option **-n *number\_of\_cores*** to utilize parallel computing. In the
case of interactive denoising commands in *taito-shell.csc.fi* you
should use in maximum 4 cores.

    denoise_wrapper.py -v -i FE.sff.txt -f FE/seqs.fna -o FE/denoised/ -m F_Map.txt -n 4

In batch jobs you can use up to 24 cores. Below is an example of a
denoiser batch job that uses 16 cores.

    #!/bin/bash
    #SBATCH -t 24:00:00
    #SBATCH --mem=32000
    #SBATCH -J denoiser
    #SBATCH -o denoiser_job%j.out
    #SBATCH -e denoiser_job%j.err
    #SBATCH -p serial
    #SBATCH --nodes=1
    #SBATCH -n 1
    #SBATCH --cpus-per-task=16

    module load biokit
    module load qiime

    #denoiser is not compatible with the default configuration file
    export QIIME_CONFIG_FP=/appl/bio/qiime/1.9.1/qiime_config_denoiser

    denoise_wrapper.py -v -i FE.sff.txt -f FE/seqs.fna -o FE/denoised/ -m F_Map.txt -n 16

If the above batch job file is named as *denoiser\_job.sh* it can be
submitted to the batch job system with command:

    sbatch denoiser_job.sh

More information about batch jobs in the [chapter 3 of the Taito user
guide].

 

 

 

 

 

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

-   Homepage of the [Qiime]

------------------------------------------------------------------------

  [Qiime2 home page]: https://qiime2.org/
  [***alpha\_rarefaction.py*** – A workflow script for performing alpha
  rarefaction]: http://qiime.org/scripts/alpha_rarefaction.html
  {.reference .internal}
  [***beta\_diversity\_through\_plots.py*** – A workflow script for
  computing beta diversity distance matrices and generating PCoA plots]:
    http://qiime.org/scripts/beta_diversity_through_plots.html
  {.reference .internal}
  [***core\_diversity\_analyses.py*** – A workflow for running a core
  set of QIIME diversity analyses.]: http://qiime.org/scripts/core_diversity_analyses.html
  {.reference .internal}
  [***jackknifed\_beta\_diversity.py*** – A workflow script for
  performing jackknifed UPGMA clustering and building jackknifed Emperor
  PCoA plots.]: http://qiime.org/scripts/jackknifed_beta_diversity.html
  {.reference .internal}
  [***pick\_closed\_reference\_otus.py*** – Closed-reference OTU
  picking/Shotgun UniFrac workflow.]: http://qiime.org/scripts/pick_closed_reference_otus.html
  {.reference .internal}
  [***pick\_de\_novo\_otus.py*** – A workflow for de novo OTU picking,
  taxonomy assignment, phylogenetic tree construction, and OTU table
  construction.]: http://qiime.org/scripts/pick_de_novo_otus.html
  {.reference .internal}
  [***pick\_open\_reference\_otus.py*** – Perform open-reference OTU
  picking]: http://qiime.org/scripts/pick_open_reference_otus.html
  {.reference .internal}
  [taito-shell.csc.fi]: https://research.csc.fi/taito-shell-user-guide
  [batch jobs]: http://taito-batch-jobs
  [*parallel\_alpha\_diversity.py* – Parallel alpha diversity]: http://qiime.org/scripts/parallel_alpha_diversity.html
  {.reference .internal}
  [*parallel\_assign\_taxonomy\_blast.py* – Parallel taxonomy assignment
  using BLAST]: http://qiime.org/scripts/parallel_assign_taxonomy_blast.html
  {.reference .internal}
  [*parallel\_assign\_taxonomy\_rdp.py* – Parallel taxonomy assignment
  using RDP]: http://qiime.org/scripts/parallel_assign_taxonomy_rdp.html
  {.reference .internal}
  [*parallel\_assign\_taxonomy\_uclust.py* – Parallel taxonomy
  assignment using the uclust consensus taxonomy assignment]: http://qiime.org/scripts/parallel_assign_taxonomy_uclust.html
  {.reference .internal}
  [*parallel\_beta\_diversity.py* – Parallel beta diversity]: http://qiime.org/scripts/parallel_beta_diversity.html
  {.reference .internal}
  [*parallel\_blast.py* – Parallel BLAST]: http://qiime.org/scripts/parallel_blast.html
  {.reference .internal}
  [*parallel\_identify\_chimeric\_seqs.py* – Parallel chimera
  detection]: http://qiime.org/scripts/parallel_identify_chimeric_seqs.html
  {.reference .internal}
  [*parallel\_map\_reads\_to\_reference.py* –]: http://qiime.org/scripts/parallel_map_reads_to_reference.html
  {.reference .internal}
  [*parallel\_merge\_otu\_tables.py* – Parallel merge BIOM tables]: http://qiime.org/scripts/parallel_merge_otu_tables.html
  {.reference .internal}
  [*parallel\_multiple\_rarefactions.py* – Parallel multiple file
  rarefaction]: http://qiime.org/scripts/parallel_multiple_rarefactions.html
  {.reference .internal}
  [*parallel\_pick\_otus\_blast.py* – Parallel pick otus using BLAST]: http://qiime.org/scripts/parallel_pick_otus_blast.html
  {.reference .internal}
  [*parallel\_pick\_otus\_sortmerna.py* – Parallel pick otus using
  SortMeRNA]: http://qiime.org/scripts/parallel_pick_otus_sortmerna.html
  {.reference .internal}
  [*parallel\_pick\_otus\_trie.py* – Parallel pick otus using a trie]: http://qiime.org/scripts/parallel_pick_otus_trie.html
  {.reference .internal}
  [*parallel\_pick\_otus\_uclust\_ref.py* – Parallel pick otus using
  uclust\_ref]: http://qiime.org/scripts/parallel_pick_otus_uclust_ref.html
  {.reference .internal}
  [*parallel\_pick\_otus\_usearch61\_ref.py* – Parallel pick otus using
  usearch\_ref]: http://qiime.org/scripts/parallel_pick_otus_usearch61_ref.html
  {.reference .internal}
  [chapter 3 of the Taito user guide]: https://research.csc.fi/taito-batch-jobs
  [Qiime]: http://qiime.org
