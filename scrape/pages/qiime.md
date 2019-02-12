## QIIME

### Description

QIIME (Quantitative Insights Into Microbial Ecology) is a package for comparison and analysis of microbial communities, primarily based on high-throughput amplicon sequencing data (such as SSU rRNA) generated on a variety of platforms, but also supporting analysis of other types of data (such as shotgun metagenomic data). QIIME takes users from their raw sequencing output through initial analyses such as OTU picking, taxonomic assignment, and construction of phylogenetic trees from representative sequences of OTUs, and through downstream statistical analysis, visualization, and production of publication-quality graphics.

On 2017 a totally rewritten version of Qiime: Qiime2 was released. The development of the original Qiime version has stopped. At the moment both Qiime2 and Qiime 1.9.1 are available in Taito.

* * *

### Available

##### Version on CSC's Servers

Taito: 2-2018.4, 1.9.1 , 1.8.0

* * *

### Usage

## Qiime2 in Taito

To use Qiime2 in Taito you should run following setup commands:

    module load qiime
    source activate qiime2-2018.4
    source tab-qiime

After that you can start Qiime2 with command:

    qiime

Please check [Qiime2 home page](https://qiime2.org/) for more instructions.

## Qiime 1.9.1 in Taito

Note: All the documentation below refer to the old Qiime versions.

To use  QIIME 1.9.1  in Taito you first need to run set-up commands

    module load biokit
    module load qiime/1.9.1

After that you can start executing QIIME commands like:

    check\_id\_map.py -m Fasting\_Map.txt -o mapping\_output

### Using parallel computing

In Taito cluster you can run some QIIME tasks using parallel computing. The parallelization has been implemented by CSC so that it utilizes the batch job system of Taito.

If you are using **QIIME wrapper scripts** that can utilize parallelization (i.e. has option **-a** available) it is enough that you add option _\-a_ to the command (excluding denoising tools. See below). For example:

    pick\_de\_novo\_otus.py -i split\_library\_output/seqs.fna -o otus -a

Adding option _\-a_ to the command makes the QIIME command to create a set of commands that will be automatically executed as an array job in the batch job system of Taito. Thus you can utilize the full capacity of Taito cluster without constructing and managing the batch jobs yourself. QIIME will do that for you.

QIIME wrapper scripts that can utilize parallel computing:

*   [**_alpha\_rarefaction.py_** – A workflow script for performing alpha rarefaction](http://qiime.org/scripts/alpha_rarefaction.html)
*   [**_beta\_diversity\_through\_plots.py_** – A workflow script for computing beta diversity distance matrices and generating PCoA plots](http://qiime.org/scripts/beta_diversity_through_plots.html)
*   [**_core\_diversity\_analyses.py_** – A workflow for running a core set of QIIME diversity analyses.](http://qiime.org/scripts/core_diversity_analyses.html)
*   [**_jackknifed\_beta\_diversity.py_** – A workflow script for performing jackknifed UPGMA clustering and building jackknifed Emperor PCoA plots.](http://qiime.org/scripts/jackknifed_beta_diversity.html)
*   [**_pick\_closed\_reference\_otus.py_** – Closed-reference OTU picking/Shotgun UniFrac workflow.](http://qiime.org/scripts/pick_closed_reference_otus.html)
*   [**_pick\_de\_novo\_otus.py_** – A workflow for de novo OTU picking, taxonomy assignment, phylogenetic tree construction, and OTU table construction.](http://qiime.org/scripts/pick_de_novo_otus.html)
*   [**_pick\_open\_reference\_otus.py_** – Perform open-reference OTU picking](http://qiime.org/scripts/pick_open_reference_otus.html)

It is recommended to run the QIIME commands either as interactive processes in [taito-shell.csc.fi](/taito-shell-user-guide) environment or as [batch jobs](http://taito-batch-jobs). Note that if you launch a parallel QIIME tasks as a batch job, you don't need to reserve more than one core in your batch job script file. This is because the wrapper that executes the parallel QIIME tasks automatically writes a second batch job file that includes the resource reservations for the parallel part of your QIIME workflow.

In the case of **QIIME commands**, following commands are available as parallel versions. In these cases you just need to use the command starting with definition _parallel\__ in stead of the normal QIIME command.

*   [_parallel\_alpha\_diversity.py_ – Parallel alpha diversity](http://qiime.org/scripts/parallel_alpha_diversity.html)
*   [_parallel\_assign\_taxonomy\_blast.py_ – Parallel taxonomy assignment using BLAST](http://qiime.org/scripts/parallel_assign_taxonomy_blast.html)
*   [_parallel\_assign\_taxonomy\_rdp.py_ – Parallel taxonomy assignment using RDP](http://qiime.org/scripts/parallel_assign_taxonomy_rdp.html)
*   [_parallel\_assign\_taxonomy\_uclust.py_ – Parallel taxonomy assignment using the uclust consensus taxonomy assignment](http://qiime.org/scripts/parallel_assign_taxonomy_uclust.html)
*   [_parallel\_beta\_diversity.py_ – Parallel beta diversity](http://qiime.org/scripts/parallel_beta_diversity.html)
*   [_parallel\_blast.py_ – Parallel BLAST](http://qiime.org/scripts/parallel_blast.html)
*   [_parallel\_identify\_chimeric\_seqs.py_ – Parallel chimera detection](http://qiime.org/scripts/parallel_identify_chimeric_seqs.html)
*   [_parallel\_map\_reads\_to\_reference.py_ –](http://qiime.org/scripts/parallel_map_reads_to_reference.html)
*   [_parallel\_merge\_otu\_tables.py_ – Parallel merge BIOM tables](http://qiime.org/scripts/parallel_merge_otu_tables.html)
*   [_parallel\_multiple\_rarefactions.py_ – Parallel multiple file rarefaction](http://qiime.org/scripts/parallel_multiple_rarefactions.html)
*   [_parallel\_pick\_otus\_blast.py_ – Parallel pick otus using BLAST](http://qiime.org/scripts/parallel_pick_otus_blast.html)
*   [_parallel\_pick\_otus\_sortmerna.py_ – Parallel pick otus using SortMeRNA](http://qiime.org/scripts/parallel_pick_otus_sortmerna.html)
*   [_parallel\_pick\_otus\_trie.py_ – Parallel pick otus using a trie](http://qiime.org/scripts/parallel_pick_otus_trie.html)
*   [_parallel\_pick\_otus\_uclust\_ref.py_ – Parallel pick otus using uclust\_ref](http://qiime.org/scripts/parallel_pick_otus_uclust_ref.html)
*   [_parallel\_pick\_otus\_usearch61\_ref.py_ – Parallel pick otus using usearch\_ref](http://qiime.org/scripts/parallel_pick_otus_usearch61_ref.html)

Below is an example batch job file for running pick\_de\_novo\_otus.py command:

    #!/bin/bash
    #SBATCH -t 12:00:00
    #SBATCH --mem=32000
    #SBATCH -J pick\_otus
    #SBATCH -o pick\_otus\_job%j.out
    #SBATCH -e pick\_otus\_job%j.err
    #SBATCH -p serial
    #SBATCH --nodes=1
    #SBATCH -n 1
    
    module load biokit
    module load qiime
    
    pick\_de\_novo\_otus.py -i split\_library\_output/seqs.fna -o otus -a

If the above batch job file is named as _pick\_outs.sh_ it can be submitted to the batch job system with command:

    sbatch pick\_otus.sh

More information about batch jobs in the [chapter 3 of the Taito user guide](https://research.csc.fi/taito-batch-jobs).

### Using parallel computing for denoising

The _denoising_ commands are not compatible with the default QIIME parallelization system in Taito. To enable the usage of parallel denoising tools you have to use denoiser specific _QIIME configuration file._ This is defined with command:

    export QIIME\_CONFIG\_FP=/appl/bio/qiime/1.9.1/qiime\_config\_denoiser

After this you can use for example _denoise\_wrapper.py_ command with option **\-n _number\_of\_cores_** to utilize parallel computing. In the case of interactive denoising commands in _taito-shell.csc.fi_ you should use in maximum 4 cores.

    denoise\_wrapper.py -v -i FE.sff.txt -f FE/seqs.fna -o FE/denoised/ -m F\_Map.txt -n 4

In batch jobs you can use up to 24 cores. Below is an example of a denoiser batch job that uses 16 cores.

    #!/bin/bash
    #SBATCH -t 24:00:00
    #SBATCH --mem=32000
    #SBATCH -J denoiser
    #SBATCH -o denoiser\_job%j.out
    #SBATCH -e denoiser\_job%j.err
    #SBATCH -p serial
    #SBATCH --nodes=1
    #SBATCH -n 1
    #SBATCH --cpus-per-task=16
    
    module load biokit
    module load qiime
    
    #denoiser is not compatible with the default configuration file
    export QIIME\_CONFIG\_FP=/appl/bio/qiime/1.9.1/qiime\_config\_denoiser
    
    denoise\_wrapper.py -v -i FE.sff.txt -f FE/seqs.fna -o FE/denoised/ -m F\_Map.txt -n 16
    

If the above batch job file is named as _denoiser\_job.sh_ it can be submitted to the batch job system with command:

    sbatch denoiser\_job.sh

More information about batch jobs in the [chapter 3 of the Taito user guide](/taito-batch-jobs).

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

*   Homepage of the [Qiime](http://qiime.org)

* * *