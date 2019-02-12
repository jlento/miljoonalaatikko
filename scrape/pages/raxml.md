## RAxML

### Description

RAxML is a fast program for the inference of phylogenies with maximum likelihood method. RAxML offers several different evolutionary models for both DNA and amino acid sequences.

* * *

### Available

##### Version on CSC's Servers

Taito: 7.4.8, 7.7.9, 8.1.3, 8.1.22, 8.2.0, 8.2.9

* * *

### Usage

On Taito we have to first load correct compiler modules. For version 8.1.3 this is:

    module purge
    module load gcc/4.8.2
    module load intelmpi/4.1.3
    module load raxml/8.1.3

You can always check the required modules for each program version with the "module spider" command, e.g.:

    module spider raxml/7.7.9

The basic call (depending on the version) for DNA sequence data (uses GTR + 4 gamma categories):

    raxmlHPC -n run\_name -s alignment -m GTRGAMMA -p 1234

and for amino acid sequences (uses JTT + 4 gamma categories):

    raxmlHPC -n run\_name -s alignment -m ROTGAMMAJTT -p 1234

RAxML offers special evolutionary models, where alignment columns are grouped in a number of similarly behaving (in respect to substitution frequencies) columns. This is very close to usual gamma models, but is much faster to compute. Model applying this method are marked with "CAT". Usual gamma models are marked with "GAMMA", and plain models are called with their simple name, like "HKY85".

**Which Version to use?**

RAxML comes in a serial version and two different parallel version.

The use of the sequential version (**raxmlHPC**) is intended for small to medium datasets and for initial experiments to determine appropriate search parameters.

The PThreads version (**raxmlHPC-PTHREADS**) will work well for very long alignments. Make sure to specify the number of threads with the ­-T option. This shoud match the number of cores you request in the batch job script.

To choose the number of threads to use, please see section "How many Threads shall I use?" in the RAxML manual. Using too many threads can cause the program to run slower.

The MPI version (**raxmlHPC-MPI**) is for executing really large production runs (i.e. 100 or 1,000 bootstraps). You can also perform multiple inferences on larger datasets in parallel to find a best-known ML tree for your dataset. Finally, the rapid BS algorithm and the associated ML search have also been parallelized with MPI.  
   
The current MPI version only works properly if you specify the number of runs in the command line, since it has been designed to do multiple inferences or rapid/standard BS (bootstrap) searches in parallel. Please use the -N option instead of the -# option as the latter can be mistaken for a start of a comment by the batch job system.

For details, please refer to chapter "When to use which Version?" in the RAxML manual.

**Batch jobs in Taito**

To submit a batch job you must first write a batch job script describing your resource need and the various job steps.  
  
An example batch job script to run RAxML in parallel mode using 10 computing cores:

    #!/bin/bash -l
    
    ## Name of job
    #SBATCH -J raxml\_example
    
    ## system error message output file
    #SBATCH -e raxml\_example\_err\_%j
    
    ## system message output file
    #SBATCH -o raxml\_example\_output\_%j
    
    ## a per-process memory limit
    ## limit is specified in MB
    ## example: 1 GB is 1000
    #SBATCH --mem-per-cpu=1000
    
    ## how long a job takes, wallclock time hh:mm:ss
    #SBATCH -t 10:00:00
    
    ##the number of mpi tasks (number of cores)
    #SBATCH -n 10
    
    ##parallel queue
    #SBATCH -p parallel
    
    ## Load necessary modules
    module purge
    module load gcc/4.8.2
    module load intelmpi/4.1.3
    module load raxml/8.1.3
    
    ## run my MPI executable
    ## Modify the command line as necessary
    
    srun raxmlHPC-MPI -N 100 -n test1 -s cox1.phy -m GTRGAMMAI -p 1234

The batch job is submitted with command (where "my\_job\_script" is the name of your batch file):

    sbatch my\_job\_script

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

More information about RAxML can be found from the [RAxML home page](http://www.exelixis-lab.org/).

* * *