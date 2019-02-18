## ABySS

### Description

ABySS is a *de novo*,  parallel, paired-end sequence assembler that is
designed for  short reads. The  parallel version, installed at  CSC is
implemented using MPI and is capable of assembling large genomes.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.1.4, 2.1.0, 2.0.2, 1.3.6

------------------------------------------------------------------------

### Usage

**Running ABySS jobs in Taito-shell**

ABySS environment is set up in **Taito-shell** with command

    module purge
    module load gcc/4.9.3
    module load openmpi/2.0.1
    module load abyss/2.1.4

After  that you  can  launch  ABySS jobs  with  the  ABySS command  or
abyss-pe script. For example

    abyss-pe k=64 n=5 name=testrun in='reads_1.fq reads_2.fq'

By default, the  maximum k-mer size that  ABySS can use on  96. If you
wish to use longer k-mers you can load ABySS versions for longer k-mer
lengths (max. 128 or 256) with commands:

    module load abyss/2.1.4_k128
    module load abyss/2.1.4_k256

 

 

**Running ABySS batch jobs in Taito**

Large ABySS  jobs should be executed  as batch jobs in  Taito cluster.
Below is a sample batch job file for ABySS:

    #!/bin/bash -l
    #SBATCH -J abyss_job
    #SBATCH -o abyss_job.out
    #SBATCH -e abyss_job.err
    #SBATCH -n 8
    #SBATCH -p longrun
    #SBATCH -t 120:00:00
    #SBATCH --mem-per-cpu=8000
    #SBATCH --nodes=1

    module purge
    module load gcc/4.9.3
    module load openmpi/2.0.1
    module load abyss/2.1.4

    abyss-pe np=8 k=25 name=test in='y_1.fq y_2.fq' 

In the  sample script above  the lines starting with  \#SBATCH defines
the resource  reservations for the batch  job. The job will  use 8 MPI
processes (-n 8).  The job is run in the  *longrun* queue (-p longrun)
and the maximum duration is set to 120 hours (five days).

In Taito,  setting up  the ABySS  environment requires  *three module*
load  commands  that  set  up  the correct  compiler,  MPI  and  ABySS
versions. The *module purge* command  is used to initialize the module
environment before loading the modules needed.

In  Taito,  parallel  ABySS  jobs  should  be  launched  with  command
**abyss-pe**.

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

**Webpage**  
<http://www.bcgsc.ca/platform/bioinfo/software/abyss>

<https://github.com/bcgsc/abyss>

 

**Publications**

-   ABySS: A parallel assembler  for short read sequence data. Simpson
    JT,  Wong K,  Jackman SD,  Schein JE,  Jones SJ,  Birol I.  Genome
    Research, <span    class="ti"    style="margin:   0px;    padding:
    0px;">2009-June</span>. ([Genome Research], [PubMed])

-   De  novo Transcriptome Assembly  with ABySS. İnanç Birol,  Shaun D
    Jackman,   Cydney  Nielsen,   Jenny   Q   Qian,  Richard   Varhol,
    Greg Stazyk, Ryan D Morin,  Yongjun Zhao, Martin Hirst, Jacqueline
    E  Schein, Doug  E Horsman,  Joseph M  Connors, Randy  D Gascoyne,
    Marco         A         Marra        and         Steven         JM
    Jones.   Bioinformatics.   2009-June.   ([Bioinformatics   Advance
    Access])

-   De novo  assembly and analysis of RNA-seq  data. Gordon Robertson,
    Jacqueline Schein,  Readman Chiu, Richard Corbett,  Matthew Field,
    Shaun  D Jackman,  Karen Mungall,  Sam Lee,  Hisanaga Mark  Okada,
    Jenny Q  Qian, Malachi  Griffith, Anthony Raymond,  Nina Thiessen,
    Timothee  Cezard, Yaron  S Butterfield,  Richard Newsome,  Simon K
    Chan, Rong  She, Richard Varhol, Baljit  Kamoh, Anna-Liisa Prabhu,
    Angela Tam, YongJun  Zhao, Richard A Moore, Martin  Hirst, Marco A
    Marra, Steven J M Jones, Pamela A Hoodless Marco A Marra, Steven J
    M   Jones,   Pamela   A   Hoodless   and   İnanç   Birol.   Nature
    Methods. 2010-Oct. ([Nature])

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

The manual can be found here: <https://github.com/bcgsc/abyss#abyss>

------------------------------------------------------------------------

  [Genome Research]: http://genome.cshlp.org/content/19/6/1117 {.external-link}
  [PubMed]: http://www.ncbi.nlm.nih.gov/pubmed/19251739 {.external-link}
  [Bioinformatics Advance Access]: http://bioinformatics.oxfordjournals.org/cgi/content/abstract/btp367
  {.external-link}
  [Nature]: http://www.nature.com/nmeth/journal/v7/n11/abs/nmeth.1517.html
  {.external-link}
