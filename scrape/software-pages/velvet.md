## Velvet

### Description

Velvet is a sequence assembler for very short reads.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 1.2.08

------------------------------------------------------------------------

### Usage

In Taito the velvet commands are initialized with command:

    module load biokit

*Velveth* (and  the  corresponding  colorspace  version *velveth\_de*)
helps    you    construct    the    dataset    for    the    following
program,*velvetg.* Velveth  takes  in  a   number  of  sequence  ﬁles,
produces a  hashtable, then outputs  two ﬁles in an  output directory,
Sequences and  Roadmaps, which are necessary  to *velvetg*. The syntax
is as follows:

    velveth output_directory hash_length  [[-file_format][-read_type] filename]

For example

    velveth assembly_dir 21 -shortPaired data/reads.fa

*Velvetg* (and the corresponding  colorspace version *velvetg\_de*) is
the  core  of  Velvet  where  the   de  Bruijn  graph  is  built  then
manipulated.  The syntax of velvetg is

    velvetg output_directory -options parameters

A *velvetg* command could look like:

    velvetg assebly_dir -cov_cutoff 5 -read_trkg yes -amos_file yes

 

When  velvet  is   compiled,  the  maximum  allowed   kmer  length  is
defined. The  longer the maximum kmer  is the more memory  velvet will
need (regardless of the kmer length that is actually used). Because of
that  we provide  several  versions  of velvet,  listed  in the  table
below. In Taito the default the maximum k-mer length, that can be used
in the hash table, is 100 bases. However, it is recommended to use the
version that  has the shortest  possible max kmer length.  For example
for   kmer   length   40   you  should   use   *velveth\_maxk50*   and
*velvetg\_maxk50.*

  
Table 2.  Velvet programs available in **Taito**

|                     | | |
|---------------------|-----------------------|------------|
| **Program** | **max. k-mer length** | ** type** |
| velveth | 100 | normal |
| velvetg | 100 | normal |
| velveth\_maxk75 | 75 | normal |
| velvetg\_maxk75 | 75 | normal |
| velveth\_maxk50 | 50 | normal |
| velvetg\_maxk50 | 50 | normal |
| velveth\_maxk35 | 35 | normal |
| velvetg\_maxk35 | 35 | normal |
| velveth\_de | 100 | colorspace |
| velvetg\_de | 100 | colorspace |
| velveth\_de\_maxk75 | 75 | colorspace |
| velvetg\_de\_maxk75 | 75 | colorspace |
| velveth\_de\_maxk50 | 50 | colorspace |
| velvetg\_de\_maxk50 | 50 | colorspace |
| velveth\_de\_maxk35 | 35 | colorspace |
| velvetg\_de\_maxk35 | 35 | colorspace |

 

In Taito,  the velvet jobs  should be  executed through the  batch job
system. Below is sample batch job file for velvet.

    #!/bin/bash
    #SBATCH -J velvet
    #SBATCH -o output_velvet2.txt
    #SBATCH -e errors_velvet2.txt
    #SBATCH -t 4-00:00:00
    #SBATCH -n 1
    #SBATCH -p longrun
    #SBATCH --nodes=1
    #SBATCH --cpus-per-task=4
    #SBATCH --mem-per-cpu=16000

    #
    module load biokit
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    export OMP_THREAD_LIMIT=$SLURM_CPUS_PER_TASK

    velveth_maxk50 assembly_folder 45 -shortPaired -fastq temp.fastq
    velvetg_maxk50 assembly_folder -ins_length 400

In  the batch  job  file above,  the job  reserves  4 computing  cores
(*--cpus-per-task=4*) and  64 GB of memory  ( 4\*16 GB) for  four days
(*-t  4-00:00:00)*.   Velvet  can   utilize  threads   based  parallel
computing. After a  set up command *module load  biokit* the number of
cores  to be  used  in  the Velvet  run  is  defined with  environment
variables:* OMP\_NUM\_THREADS* and *OMP\_THREAD\_LIMIT*.    In    this
script  these  variables   are  set  by  using   the  the  environment
variable* SLURM\_CPUS\_PER\_TASK*,  that  contains the  value  defined
with the *--cpus-per-task*,( which in this example has value: 4).

The batch job can be launched with command

sbatch *script\_file\_name*

More information  about using  the batch  job system  of Taito  can be
found from the[ Chapter 3. of the Taito user guide].

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Please cite:

D.R. Zerbino and E. Birney. 2008. Velvet: algorithms for de novo short
read assembly using de Bruijn graphs. Genome Research, 18: 821-829

------------------------------------------------------------------------

### Support

helpdesk@csc.fi

------------------------------------------------------------------------

### Manual

[Velvet home page]

------------------------------------------------------------------------

  [ Chapter 3. of the Taito user guide]: https://research.csc.fi/taito-batch-jobs
  [Velvet home page]: http://en.wikipedia.org/wiki/Velvet_assembler
