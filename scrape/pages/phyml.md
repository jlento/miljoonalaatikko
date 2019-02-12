## phyml

### Description

PhyML is a software that estimates maximum likelihood phylogenies from alignments of nucleotide or amino acid sequences. The main strength of PhyML lies in the large number of substitution models coupled to various options to search the space of phylogenetic tree topologies, going from very fast and efficient methods to slower but generally more accurate approaches. PhyML was designed to process moderate to large data sets. In theory, alignments with up to 4,000 sequences 2,000,000 character-long can be processed.

* * *

### Available

##### Version on CSC's Servers

Taito: 20120412 (stable version)

Taito: 20140723 (development version) 

* * *

### Usage

To use PhyML on Taito we first need to set up the correct compiler environment:

    module purge
    module load gcc/4.8.2
    module load intelmpi/4.1.3

Then load the PhyML module:

    module load phyml/20120412

There are two version of PhyML, a serial version:

    phyml

And a MPI parallel version:

    phyml-mpi

Serial version can be run interactively in Taito-shell. It can useful especially for short test runs, checking your parameters etc. Parallel jobs need to be run through the batch job system. You will need to construct a batch job script and submit it to the batch job system. More information on this can be fount in Chapter 3 of the [Taito User's Guide](https://research.csc.fi/taito-batch-jobs).

An example batch job script for Taito. Note that the number of bootstrap replicates must be a multiple of the number of MPI tasks.

    #!/bin/bash -l
    #SBATCH -J phyml-par
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 10:00:00
    #SBATCH -n 10
    #SBATCH --mem-per-cpu=4000
    #SBATCH -p parallel
    #
    
    module purge
    module load gcc/4.8.2
    module load intelmpi/4.1.3
    module load phyml/20120412
    
    srun phyml-mpi -i seqfile -b 100

The batch job is submitted with command (where "my\_job\_script" is the name of your batch file):

    sbatch my\_job\_script
    

* * *

### Discipline

Biosciences  

* * *

### References

"New Algorithms and Methods to Estimate Maximum-Likelihood Phylogenies: Assessing the Performance of PhyML 3.0." Guindon S., Dufayard J.F., Lefort V., Anisimova M., Hordijk W., Gascuel O. Systematic Biology, 59(3):307-21, 2010.

* * *

### Support

helpdesk@csc.fi

* * *

### Manual

[PhyML homepage](https://code.google.com/p/phyml/)

* * *