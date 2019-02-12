## Velvet

### Description

Velvet is a sequence assembler for very short reads.

* * *

### Available

##### Version on CSC's Servers

Taito: 1.2.08

* * *

### Usage

In Taito the velvet commands are initialized with command:

    module load biokit
    

_Velveth_ (and the corresponding colorspace version _velveth\_de_) helps you construct the dataset for the following program,_velvetg._ Velveth takes in a number of sequence ﬁles, produces a hashtable, then outputs two ﬁles in an output directory, Sequences and Roadmaps, which are necessary to _velvetg_. The syntax is as follows:

    velveth _output\_directory_ _hash\_length_  \[\[_\-file\_format_\]\[_\-read\_type_\] _filename_\]For example    velveth assembly\_dir 21 -shortPaired data/reads.fa_Velvetg_ (and the corresponding colorspace version _velvetg\_de_) is the core of Velvet where the de Bruijn graph is built then manipulated. The syntax of velvetg is    velvetg _output\_directory_ -_options_ _parameters_A _velvetg_ command could look like:    velvetg assebly\_dir -cov\_cutoff 5 -read\_trkg yes -amos\_file yes 

When velvet is compiled, the maximum allowed kmer length is defined. The longer the maximum kmer is the more memory velvet will need (regardless of the kmer length that is actually used). Because of that we provide several versions of velvet, listed in the table below. In Taito the default the maximum k-mer length, that can be used in the hash table, is 100 bases. However, it is recommended to use the version that has the shortest possible max kmer length. For example for kmer length 40 you should use _velveth\_maxk50_ and _velvetg\_maxk50._

  
Table 2.  Velvet programs available in **Taito**

**Program**


**max. k-mer length**


** type**

velveth

100

normal

velvetg

100

normal

velveth\_maxk75

75

normal

velvetg\_maxk75

75

normal

velveth\_maxk50

50

normal

velvetg\_maxk50

50

normal

velveth\_maxk35

35

normal

velvetg\_maxk35

35

normal

velveth\_de

100

colorspace

velvetg\_de

100

colorspace

velveth\_de\_maxk75

75

colorspace

velvetg\_de\_maxk75

75

colorspace

velveth\_de\_maxk50

50

colorspace

velvetg\_de\_maxk50

50

colorspace

velveth\_de\_maxk35

35

colorspace

velvetg\_de\_maxk35

35

colorspace

In Taito, the velvet jobs should be executed through the batch job system. Below is sample batch job file for velvet.

    #!/bin/bash
    #SBATCH -J velvet
    #SBATCH -o output\_velvet2.txt
    #SBATCH -e errors\_velvet2.txt
    #SBATCH -t 4-00:00:00
    #SBATCH -n 1
    #SBATCH -p longrun
    #SBATCH --nodes=1
    #SBATCH --cpus-per-task=4
    #SBATCH --mem-per-cpu=16000
    
    #
    module load biokit
    export OMP\_NUM\_THREADS=$SLURM\_CPUS\_PER\_TASK
    export OMP\_THREAD\_LIMIT=$SLURM\_CPUS\_PER\_TASK
    
    velveth\_maxk50 assembly\_folder 45 -shortPaired -fastq temp.fastq
    velvetg\_maxk50 assembly\_folder -ins\_length 400

In the batch job file above, the job reserves 4 computing cores (_\--cpus-per-task=4_) and 64 GB of memory ( 4\*16 GB) for four days (_\-t 4-00:00:00)_. Velvet can utilize threads based parallel computing. After a set up command _module load biokit_ the number of cores to be used in the Velvet run is defined with environment variables:_ OMP\_NUM\_THREADS_ and _OMP\_THREAD\_LIMIT_. In this script these variables are set by using the the environment variable_ SLURM\_CPUS\_PER\_TASK_, that contains the value defined with the _\--cpus-per-task_,( which in this example has value: 4).

The batch job can be launched with command

sbatch _script\_file\_name_

More information about using the batch job system of Taito can be found from the[ Chapter 3. of the Taito user guide](/taito-batch-jobs).

* * *

### Discipline

Biosciences  

* * *

### References

Please cite:

D.R. Zerbino and E. Birney. 2008. Velvet: algorithms for de novo short read assembly using de Bruijn graphs. Genome Research, 18: 821-829

* * *

### Support

helpdesk@csc.fi

* * *

### Manual

[Velvet home page](http://en.wikipedia.org/wiki/Velvet_assembler)

* * *