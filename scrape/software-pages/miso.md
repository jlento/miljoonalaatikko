## MISO

### Description

MISO (Mixture of Isoforms) is a probabilistic framework that quantitates
the expression level of alternatively spliced genes from RNA-Seq data,
and identifies differentially regulated isoforms or exons across
samples. By modeling the generative process by which reads are produced
from isoforms in RNA-Seq, the MISO model uses Bayesian inference to
compute the probability that a read originated from a particular
isoform.

MISO uses the inferred assignment of reads to isoforms to quantitate the
abundances of the underlying set of alternative mRNA isoforms.
Confidence intervals over estimates can be obtained, which quantify the
reliability of the estimates.

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 0.4.8, 0.5.2  
[FGI grid][]: 0.4.7

------------------------------------------------------------------------

### Usage

**Running MISO batch jobs in Taito**

In Taito, MISO is initialized with command:

    module load miso

In Taito, MISO jobs should be run as batch jobs. Below is a sample batch
job file, for running a MISO job in Taito:

    #!/bin/bash -l
    #SBATCH -J miso
    #SBATCH -o miso%j.txt
    #SBATCH -e miso%j.txt
    #SBATCH -t 24:00:00
    #SBATCH --mem-per-cpu=12288


    module load python-env/2.7.3
    module load miso

    ## Compute Psi values for sample 1
    miso.py --run=events/ inputBAM/test.sorted.bam \
    --output-dir miso_output --read-len 76 --use-cluster


    ## Summarize the output
    run_miso.py --summarize-samples miso-output/ summaries/ 

In the batch job example above, the *run\_events\_analysis.py* command
is launched with command line option *--use-cluster*. This option
automatically split the *run\_events\_analysis.py* task into number of
sub-tasks that can be run in parallel fashion in the Taito cluster. This
speeds up the analysis significantly.

You can submit the batch job file to the batch job system with command:

    sbatch batch_job_file.bash

See the [chapter 3 of the Taito user guide] for more information about
running batch jobs.

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

-   [Miso home page]

------------------------------------------------------------------------

  [FGI grid]: http://confluence.csc.fi/display/fgi/MISO+runtime+environmnet
  [chapter 3 of the Taito user guide]: https://research.csc.fi/taito-batch-jobs
  [Miso home page]: http://genes.mit.edu/burgelab/miso/
