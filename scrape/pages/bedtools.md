## BEDTools

### Description

The BEDTools utilities allow one to address common genomics tasks such as finding feature overlaps and computing coverage. The utilities are largely based on four widely-used file formats: BED, GFF/GTF, VCF, and SAM/BAM. Using BEDTools, one can develop sophisticated pipelines that answer complicated research questions by "streaming" several BEDTools together. The following are examples of common questions that one can address with BEDTools.

1.      Intersecting two BED files in search of overlapping features.
    
2.      Culling/refining/computing coverage for BAM alignments based on genome features.
    
3.      Merging overlapping features.
    
4.      Screening for paired-end (PE) overlaps between PE sequences and existing genomic features.
    
5.      Calculating the depth and breadth of sequence coverage across defined "windows" in a genome.
    
6.      Screening for overlaps between "split" alignments and genomic features.
    

* * *

### Available

##### Version on CSC's Servers

Taito: 2.26.0

BEDTools can also be used through the [Chipster](http://chipster.csc.fi) graphical user interface

* * *

### Usage

To use in Taito

        module load biokit

BEDtools can be very picky about the formatting of the BED files. If you have problems running the tools, try running these commands on your BED file:

    dos2unix <filename>
    sed -i -e '$a\\' <filename>
    

The first command will convert the line endings in the file to be Unix-compliant and the second command will add a new line character to the end of the file if it is missing.

* * *

### Discipline

Biosciences  

* * *

### References

When you use BEDTools, please cite:

Quinlan AR and Hall IM, 2010. BEDTools: a flexible suite of utilities for comparing genomic features. Bioinformatics. 26, 6, pp. 841–842.

* * *

### Support

helpdesk@csc.fi

* * *

### Manual

See [BEDTools homepage](http://bedtools.readthedocs.org/en/latest/) for details.

* * *