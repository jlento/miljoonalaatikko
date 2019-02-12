## Diamond

### Description

Diamond is a fast sequence similarity search tool for matching nucleotide or protein sequences against protein databases.The key features of Diamond are:

*   Pairwise alignment of proteins and translated DNA at 500x-20,000x speed of BLAST.
*   Frameshift alignments for long read analysis.
*   Low resource requirements and suitable for running on standard desktops or laptops.
*   Various output formats, including BLAST pairwise, tabular and XML, as well as taxonomic classification.

* * *

### Available

### Usage

To use Diamond, run first command:

    module load biokit/4.9.3

Afrer that, you can check the diamond help with command:

    diamond help

CSC provides Diamond indexes for Uniprot databases (swiss, trembl) and NCBI non redundant database (nr). Location of these databases is defined with environment variable $DIAMONDDB.  For example searching hits for a set of nucleotide sequeces  from the SwissProt database could be done with  command:

    diamond blastx --query nuc.fasta -d $DIAMONDDB/swiss --out diamond\_results.txt -p 4 --max-target-seqs 500

You can also do searches against your own protein sequence database.  In this case you must first calculate Diamond indexes for your reference protein set with command diamond makedb. For example:

    diamond makedb --in refrerence\_proteins.fasta -d my\_ref -p 4

The command above creates a Diamond index file ( my\_ref.dmnd) that can be used as the query database:

    diamond blastx --query nuc.fasta -d my\_ref --out diamond\_results2.txt -p 4 --max-target-seqs 500 

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

[Diamond Github page](https://github.com/bbuchfink/diamond)

* * *