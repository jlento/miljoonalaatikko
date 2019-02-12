## Falcon

### Description

Falcon is a set of tools for fast aligning long reads for consensus and assembly

The Falcon tool kit is a set of simple code collection which I use for studying efficient assembly algorithm for haploid and diploid genomes. It has some back-end code implemented in C for speed and some simple front-end written in Python for convenience.

* * *

### Available

##### Version on CSC's Servers

Taito: 0.3.0

* * *

### Usage

To use Falcon:

    module load python-env/2.7.10
    module load falcon
    

Falcon has a main program **fc\_run.py** that splits the job and runs the sub-jobs throug the batch job system. The main program itself does not take much resourses, but it should remain running until all the sub-jobs have finished.

One way to run Falcon is to run **fc\_run.py** as an interactive job in Taito-shell. As the job can take long, it's best to either run it in _screen_ or via NoMachine (see [Taito-shell user guide](https://research.csc.fi/taito-shell-user-guide) for details).

The example .cfg files provided with the software are written to use SGE batch job system. They will need to be edited to use SLURM.

To run an example assemply with _E. coli_ data as described [here](https://github.com/PacificBiosciences/FALCON/wiki/Setup%3A-Complete-example), you can do the following:

To prepare the data:

    cd $WRKDIR
    mkdir -p ecoli\_test
    cd ecoli\_test/
    mkdir -p data
    cd data
    wget https://www.dropbox.com/s/tb78i5i3nrvm6rg/m140913\_050931\_42139\_c100713652400000001823152404301535\_s1\_p0.1.subreads.fasta
    wget https://www.dropbox.com/s/v6wwpn40gedj470/m140913\_050931\_42139\_c100713652400000001823152404301535\_s1\_p0.2.subreads.fasta
    wget https://www.dropbox.com/s/j61j2cvdxn4dx4g/m140913\_050931\_42139\_c100713652400000001823152404301535\_s1\_p0.3.subreads.fasta
    cd ..
    find data -name "\*.fasta" > input.fofn
    

Here is the file **fc\_run\_ecoli.cfg** modified to use SLURM:

    \[General\]
    # list of files of the initial bas.h5 files
    input\_fofn = input.fofn
    #input\_fofn = preads.fofn
    
    input\_type = raw
    #input\_type = preads
    
    # The length cutoff used for seed reads used for initial mapping
    length\_cutoff = 12000
    
    # The length cutoff used for seed reads usef for pre-assembly
    length\_cutoff\_pr = 12000
    
    job\_type = SLURM
    jobqueue = serial
    sge\_option\_da = --ntasks 1 --nodes 1 --cpus-per-task 8 --mem 3000 --time 00:20:00 -p %(jobqueue)s
    sge\_option\_la = --ntasks 1 --nodes 1 --cpus-per-task 2 --mem 500 --time 00:05:00 -p %(jobqueue)s
    sge\_option\_pda = --ntasks 1 --nodes 1 --cpus-per-task 8 --mem 11000 --time 00:20:00 -p %(jobqueue)s
    sge\_option\_pla = --ntasks 1 --nodes 1 --cpus-per-task 2 --mem 500 --time 00:05:00 -p %(jobqueue)s
    sge\_option\_fc = --ntasks 1 --nodes 1 --cpus-per-task 16 --mem 1000 --time 00:20:00 -p %(jobqueue)s
    sge\_option\_cns = --ntasks 1 --nodes 1 --cpus-per-task 8 --mem 9000 --time 00:20:00 -p %(jobqueue)s
    
    pa\_concurrent\_jobs = 32
    ovlp\_concurrent\_jobs = 32
    
    pa\_HPCdaligner\_option =  -v -dal4 -t16 -e.70 -l1000 -s1000
    ovlp\_HPCdaligner\_option = -v -dal4 -t32 -h60 -e.96 -l500 -s1000
    
    pa\_DBsplit\_option = -x500 -s50
    ovlp\_DBsplit\_option = -x500 -s50
    
    falcon\_sense\_option = --output\_multi --min\_idt 0.70 --min\_cov 4 --max\_n\_read 200 --n\_core 6
    
    overlap\_filtering\_setting = --max\_diff 100 --max\_cov 100 --min\_cov 20 --bestn 10 --n\_core 24
    

Main changes are in lines starting with **sge\_options\_\***

The parameters here are sufficient to run the test assembly, but you may need to adjust them to match your own dataset.

To run, log into Taito-shell, and:

    cd $WRKDIR/ecoli\_test
    module load python-env/2.7.10
    module load falcon
    fc\_run.py fc\_run\_ecoli.cfg
    

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

*   Falcon [home](https://github.com/PacificBiosciences/FALCON/wiki)
*   Falcon [manual](https://github.com/PacificBiosciences/FALCON/wiki/Manual)

* * *