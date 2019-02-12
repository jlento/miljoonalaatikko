## HMMER

### Description

Hidden Markov Models (HMM) are mathematical tools that can be used to describe and analyze related or similar sequence areas. Normally HMM-models are derived from multiple sequence alignments so that they contain position specific information about the probabilities of having certain nucleotides or amino acids in each position of an alignment.

The HMMER package contains tools to create and modify HMM-models, use them to do database searches and extend sequence alignments.

The EMBASSY version of HMMER includes all the functions of the original HMMER 2 program in EMBOSS like format. Database searches with HMM profiles can require very long computing times in normal computers.

#### HMMER programs

**HMMER program**


**Description**

hmmalign

Align sequences with an HMM

hmmbuild

Build HMM

hmmconvert

Convert between HMM formats

hmmemit

Extract HMM sequences

hmmfetch

Extract HMM from a database

hmmpress

Index an HMM database

hmmscan

Align single sequence with a HMM database

hmmsearch

Search sequence database with an HMM

hmmsim

Collect profile HMM score distributions on random sequences

hmmstat

Display summary statistics for a profile file

jackhmmer

Iteratively search a protein sequence against a protein database

phmmer

Search a protein sequence against a protein database

* * *

### Available

##### Version on CSC's Servers

Taito: 3.0, 3.1b2

* * *

### Usage

To use HMMER in Taito use:

    module load biokit

After this the command line options of each hmmer command can be checked with option -h. For example:

    hmmsearch -h

**Pfam database**

In Taito you can use Pfam\_A and Pfam\_B databases with HMMER commands. For example comparing protein sequence against a Pfam-A HMM-database can be performed with command:

    hmmscan $HMMERDB/Pfam-A.hmm sekvenssi.fasta

With native HMMER, you can speed up the hmmpfam and hmmserach commands by using several processors. The number of processors to be used is indicated with option --cpu number. We recommend that you do not use more than four processors.

    hmmscan --cpu 4 $HMMERDB/Pfam-A.hmm protein.fasta > result.txt

In Taito HMMER jobs should be run as batch jobs. Here is an example batch job file usinf 4 processor cores:

    #!/bin/bash -l
    #SBATCH -J hmmer\_job
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 02:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1  
    #SBATCH --cpus-per-task=4
    #SBATCH --mem-per-cpu=1000
    #
    
    module load biokit
    hmmscan --cpu 4 $HMMERDB/Pfam-A.hmm protein.fasta > result.txt

The job is submitted with command (where batch\_job\_file is the name of you batch job file):

    sbatch batch\_job\_file

For more information on running batch jobs see the [Taito User Guide](http://research.csc.fi/taito-batch-jobs).

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

[HMMER home page](http://hmmer.janelia.org/)

* * *