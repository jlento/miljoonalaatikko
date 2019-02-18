## MrBayes

### Description

MrBayes is a program for the Bayesian inference on phylogenies.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 3.1.2, 3.2.3 (stable),3.2.4 (dev)  
[FGI grid][]: 3.2.1

------------------------------------------------------------------------

### Usage

To  use MrBayes  in **Taito**  cluster you  first have  to set  up the
correct compiler environment:

    module purge
    module load gcc/4.8.2
    module load intelmpi

You can then load the MrBayes module.

To load the default version:

    module load mrbayes

To load a specific version:

    module load mrbayes/3.1.2

After loading  the module, the  serial (i.e. single  processor) versio
program starts with the command

    mb64

32 bit serial  version (only available for version  3.1.2) starts with
command:

    mb32

Parallel version starts with the command:

    mb64par 

When using the  parallel version you should note  that MrBayes assigns
one chain  to one core, so  for optimal performance you  should use as
many cores  as the  total number  of chains  in your  job. If  you for
example have
specified nchains=4, nruns=2 you should use 8 cores (4\*2).  
  
Note that  sometimes on particular  data sets MrBayes v  3.1.2 summary
commands (sump, sumt)  crash the 64-bit program. If  this happens, run
the analysis (or just the summary) on 32 bit version.

MrBayes takes a character matrix,  e.g., DNA sequence alignment, as an
input  only,  if the  file  is  in  Nexus-format. Hint: You  can  save
nexus-formatted  alignments  using,   *e.g.*  ClustalX  (installed  in
Taito).

**Batch jobs**

Running MrBayes  analysis might take  considerable amount of  CPU time
and memory. It is desirable to run  it through the batch job system in
Taito or in FGI.

To run a batch job you need to:

1.  Write a MrBayes command file (here "mb\_com.nex")
2.  Write a batch job script (here "mb\_batch")
3.   Make  sure  all  your   input  files  are  in  **$WRKDIR**  (here
    "primates.nex")
4.  Submit your job into the queue

MrBayes  command file  should include  the command  you would  type in
MrBayes in interactive mode. This example runs the analysis in chapter
2 of the MrBayes 3.2 manual

    begin mrbayes;
        set autoclose=yes nowarn=yes;
        execute primates.nex;
        lset nst=6 rates=invgamma;
        mcmc nchains=4 nruns=2 ngen=20000 samplefreq=100 printfreq=100 diagnfreq=1000;
        sump;
        sumt;
    end;

Example batch  job script  for Taito  using 8 cores.  (We are  using 8
cores since our example uses Nchains=4, Nruns=2, so 4\*2=8)

    #!/bin/bash -l
    #SBATCH -J my_mrbjob
    #SBATCH -e my_mrbjob_err%j
    #SBATCH -o my_mrbjob_out%j
    #SBATCH --mem-per-cpu=4000
    #SBATCH -t 01:00:00
    #SBATCH -n 8

    srun mb64par mb_com.nex >log.txt

To submit the job in Taito:

    sbatch mb_batch 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

For tips on citations, you can run the

    citations

command  in the  program, which  will give  you a  number of  relevant
citations for the program and its models and algorithms.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More information about MrBayes can be found from the [MrBayes][] [home
page][MrBayes].

------------------------------------------------------------------------

  [FGI grid]: https://confluence.csc.fi/display/fgi/MrBayes+runtime+environment
  [MrBayes]: http://mrbayes.sourceforge.net/
