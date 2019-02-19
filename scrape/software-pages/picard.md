## Picard Tools

### Description

Picard is a set of command line tools for manipulating high-throughput
sequencing (HTS) data and formats such as SAM/BAM/CRAM and VCF.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.18.10

------------------------------------------------------------------------

### Usage

To load Picard:

    module load biokit

To get a summary of available tools:

    picard

Please note that in the Picard manual commands start with "java -jar
picard.jar". In Taito Picard needs to be run through a wrapper script,
so substitute that with just **picard**.

Example:

    picard SamToFASTQ I=input.bam FASTQ=output.fastq

By default picard can use up to 8 GB  of memory. If your analysis task
requires more memory, you can launch picard with commands **picard32**
and **picard64** that reserve 32 or 64 GB of memory.

Example:

    picard32 SamToFASTQ I=input.bam FASTQ=output.fastq

 

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [Picard home page]
-   [Detailed tool documentation]

------------------------------------------------------------------------

  [Picard home page]: http://broadinstitute.github.io/picard/
  [Detailed tool documentation]: http://broadinstitute.github.io/picard/command-line-overview.html
