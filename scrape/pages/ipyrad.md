## ipyrad

### Description

ipyrad is an interactive toolkit for assembly and analysis of restriction-site associated genomic data sets (e.g., RAD, ddRAD, GBS) for population genetic and phylogenetic studies.

* * *

### Available

##### Version on CSC's Servers

Version 0.7.28 is available in Taito.

* * *

### Usage

In Taito ipyrad is taken in use with command:

    module load ipyrad

Ipyrad requires typically plenty of computing resources. Due to that ipyrad jobs should be executed in [Taito-shell](/taito-shell-user-guide) or as a [batch job](/taito-batch-jobs).

ipyrad processing is typically started with command:

    ipyrad -n _task\_name_

This creates a new parameter file (params-_task\_name_.txt) that should be edited according to your analysis case.

For example in the case of job called run1:

    moule load ipyrad
    ipyrad -n run1
    nano params-run1.txt

Once the parameter file is ready, you can start the actual ipyrad analysis. In Taito-shell you should not use more that four computing cores with ipyrad. Thus you should add definition _\-c 4_ to the ipyrad command:

    ipyrad -p params-run1.txt -s 1234567 -c 4

### Running heavy ipyrad jobs in Taito

If you are analyzing large datasets, it is recommended that you run the jobs is several phases. Some steps of the ipyrad analysis can utilize parallel computing. To speed up the processing you could run these analysis steps as batch jobs.

The first two steps are typically executed rather quickly and you can run them interactively in Taito-shell. For example in the case of job _run1_:

    ipyrad -p params-run1.txt -s 12 -c 4

The third step of the ipryrad analysis runs a clustering for each sample set. Before starting this step, study first the content of the **_job-name_\_edits** directory created by the step 2. To check how many samples will be analyzed you can for example count the rows in the file _s2\_rawedit\_stats.txt_.

For example

    cd run1\_edits
    ls -l
    wc -l s2\_rawedit\_stats.txt

The number of samples is the maximum number of parallel processes you should use in the parallel batch jobs. In practice you should use a value that is about half of the number of samples. For example, if you have 24 samples in the _\_edits_ directory, then you could consider using 12-16 cores.

The parallelization implementation of ipyrad requires that you always have only one ipyrad "task" running in one node. This means that you should always have parameter batch job parameter **--ntasks-per-node** set to one. However you can define that this task uses several cores with **--cpus-per-task**. So for if you would assign the number of batch job tasks to 2 (-n 2) and number of cores used by one task to 8( --cpus-per-task=8) your job would use 2\*8=16 cores. 

This number of cores is then given to the ipyrad command with option **-c**. Further, if you are using more than one node you should define that MPI is in use (**\--MPI**) and that the commands of the pipeline are executed using only one computing core (**\-t**).

In the sample case here we will use 16 cores in one node. If the run time is expected to be more than 3 days the job should be submitted to _longrun_ partition (#SBATCH -p longrun). In this case we reserve 168 hours ( 7 days). Further, in step 3 the clustering commands  are executed using only one thread (**\-t 1** ).

    #!/bin/bash -l
    ###
    ## name of your job
    #SBATCH -J ipyrad
    #SBATCH -e ipyrad\_err\_%j
    #SBATCH -o ipyrad\_output\_%j
    #SBATCH --mem-per-cpu=2000
    #SBATCH -t 168:00:00
    ##the number of processes (number of cores)-t
    #SBATCH -n 1
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=16
    #SBATCH -p longrun
    
    
    module load ipyrad
    ipyrad -p ipyrad-run1.txt -s 3 -c 16 -t 1 

The batch job is launched with command

    sbatch _ipyrad\_batch\_job\_file.sh_

Once the job has finished  you could run the next step by replacing **\-s 3** with **\-s 4** etc.

For the setps 4-7 maximum of 8 cores is recommended. Thread assigning option should not be set so that ipyrad can use the default settings.

    #!/bin/bash -l
    ###
    ## name of your job
    #SBATCH -J ipyrad
    #SBATCH -e ipyrad\_err\_%j
    #SBATCH -o ipyrad\_output\_%j
    #SBATCH --mem-per-cpu=2000
    #SBATCH -t 168:00:00
    ##the number of processes (number of cores)-t
    #SBATCH -n 1
    #SBATCH --ntasks-per-node=1
    #SBATCH --cpus-per-task=8
    #SBATCH -p longrun
    
    
    module load ipyrad
    ipyrad -p ipyrad-run1.txt -s 4567 -c 8 -t 1 

More information about running batch jobs in Taito can be found from the [chapter 3. of the Taito user guide](/taito-batch-jobs).

### Using cPouta for very long ipyrad jobs

The maximum run time in Taito is 14 days. In some cases running the ipyrad analysis step 3 may take even longer time. In those cases you can use the cPouta cloud service to set up your own virtual machine. Check [using-cpouta-for-biosciences](/using-cpouta-for-biosciences) for more details.

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

*   ipyrad home page  [http://ipyrad.readthedocs.io/](http://ipyrad.readthedocs.io/)

* * *