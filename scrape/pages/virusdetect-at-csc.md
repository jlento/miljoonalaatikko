## VirusDetect

### Description

VirusDetect is a software for analyzing large-scale sRNA datasets for virus identification. The program performs reference-guided assembly by aligning sRNA reads to the known virus reference database ([GenBank gbvrl](ftp://ftp.ncbi.nih.gov/genbank/)) as well as _de novo_ assembly using [Velvet](https://www.ebi.ac.uk/%7Ezerbino/velvet/) with automated parameter optimization. The assembled contigs are compared to the reference virus sequences for virus identification. The contigs were treated as undetermined contigs if they are not hit to any known viruses. The siRNA profile of these undetermined contigs are provided as guidance to discovery novel viruses which do not show sequence similarity with known viruses.

* * *

### Available

##### Version on CSC's Servers

Version 1.7  is available in Taito and in Chipster

* * *

### Usage

To use VirusDetect in Taito you first need to run set up command for biokit.

    module load biokit

After that you can start Virus Detect with command

    virus\_detect.pl

For example:

    virus\_detect.pl --reference vrl\_plant reads.fastq

The developers of VirusDetect recommend to remove ribosomal RNA (rRNA) sequences from the input sequences before running VirusDetect. This can be done by aligning the sRNA reads against Silva rRNA database using Bowtie. In Taito the Silva database is available in path:

    /proj/csc/biosci/biodb/production/silva/Silva\_rRNA\_database

The actual clening command could look like:

    bowtie -v 1 -k 1 --un cleaned\_reads.fastq  -f -q -p 4 /proj/csc/biosci/biodb/production/silva/Silva\_rRNA\_database reads.fastq  sRNA\_rRNA\_match

If possible, it is recommended that you use _--host\_reference_ option to filter out the sRNA originating from the host organism. This filtering is done by running a BWA mapping against the genome of the host organism. CSC is not maintaining BWA indexes in Taito environment. This means that users have to do the BWA indexing for their host organism genome before running VirusDetect.

For example for _Arabidopsis  thaliana_ the required BWA indexes can be created with commands:

    ensemblfetch arabidopsis\_thaliana
    mv Arabidopsis\_thaliana.TAIR10.dna.toplevel.fa a\_thaliana.fa
    bwa index -p a\_thaliana a\_thaliana.fa

After which you can launch the virus detect job with command:

    virus\_detect.pl --reference vrl\_plant --host\_reference a\_thaliana.fa cleaned\_reads.fastq

Both the Virus Detect and BWA indexing task require often significant computing capacity. Because of that, you should use either batch jobs or taito-shell.csc.fi environment for running Virus Detect jobs. Below is a sample batch job file for running Virus Detect with 4 computing cores and 8 GB of memory. The maximum running time in the job below is set to 10 hours.

    #!/bin/bash -l
    #SBATCH -J Virus\_detect
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 10:00:00
    #SBATCH -n 1
    #SBATCH --nodes=1
    #SBATCH --cpus-per-task=4
    #SBATCH -p serial
    #SBATCH --mem=8000
    #
    
    module load biokit
    
    virus\_detect.pl --thread\_num 4 --reference vrl\_plant --host\_reference a\_thaliana.fa reads.fastq

The batch job file above can be submitted to the batch job system with command:

    sbatch _batch\_job\_file.sh_More information about running batch jobs in Taito can be found from [Chapter 3 of the Taito user guide](/taito-batch-jobs).

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

[http://bioinfo.bti.cornell.edu/cgi-bin/virusdetect](http://bioinfo.bti.cornell.edu/cgi-bin/virusdetect)

* * *