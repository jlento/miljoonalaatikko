## chipster\_genomes

### Description

Chipster\_genomes is a help tool to download genome indexes used in Chipster to Taito.

CSC is maintaining several short read aligners (e.g. BWA, Bowtie2, STAR) in Taito, but not pre-calcluated indexes for reference genomes. By default, users need to import and index themselves the reference genomes they are using.

The [Chipster server](http://chipster.csc.fi) however contains indexes for a set of commonly used reference organisms for several aligners.

The _chipster\_genomes_ tool allows Taito users to download the refrence genome index files from the Chipster server to Taito so that they can be used in Taito too.

The genome data and indexes used in Chipster are based on the data available in Ensembl and Ensembl genomes databases. However, in Chipster only those sequences ( chromosomes) that have been assigned to a karyotype, are included. Futher, in  GTF files negative lacation values are removed.

Thus the data downloaded from Chipster server may in some cases differ from the data obtained directly from Ensembl.

* * *

### Available

##### Version on CSC's Servers

Available in Taito

* * *

### Usage

_chipster\_genomes_ tool requires two parameters:

1.  File or index type (bed, gtf, fasta, bowtie, bowtie, bowtie2, BWA, Hisat2, TopHat2)
2.  Species name.

If the command is launhced without any arguments, it first asks for the datatype and then for the species name.

The data type can alternatively be given as the first argument and the species name as the second argument.

For example the BWA indexes of Danio\_rerio.GRCz11 can be retrieced with command:

      chipster\_genomes bwa Danio\_rerio.GRCz11

Or interactively by launchning the command without any arguments.

      chipster\_genomes

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

* * *