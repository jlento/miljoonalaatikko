## Pagan

### Description

Pagan is a tool for generating and extending phylogenetic multiple
sequence alignments.

PAGAN is based on the phylogeny-aware progressive alignment algorithm
and uses graphs to describe the uncertainty in the presence of
characters at certain sequence positions. However, graphs also allow
describing the uncertainty in input sequences and modelling e.g.
homopolymer errors in NGS reads, or representing inferred ancestral
sequences against which other sequences can then be aligned.

The graph representation has features that make PAGAN especially
powerful for phylogenetic placement of sequences into existing
alignments.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 20150401, 20150723

------------------------------------------------------------------------

### Usage

To set up Pagan in taito, give command:

    module load pagan

After that you can start the program with command:

    pagan

for example

    pagan -i input.fasta -o pagan_result

or

    pagan --ref-seqfile reference_alignment.fas --ref-treefile reference_tree.nhx --queryfile illumina_reads.fastq --outfile read_alignment --xml

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

http://bioinformatics.oxfordjournals.org/content/28/13/1684.full

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

http://wasabiapp.org/software/pagan/

------------------------------------------------------------------------
