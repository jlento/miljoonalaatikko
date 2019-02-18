## Preseq

### Description

The  preseq  package  is  aimed   at  predicting  and  estimating  the
complexity of  a genomic sequencing library,  equivalent to predicting
and estimating the  number of redundant reads from  a given sequencing
depth and how  many will be expected from  additional sequencing using
an initial  sequencing experiment. The  estimates can then be  used to
examine  the utility  of further  sequencing, optimize  the sequencing
depth,  or  to  screen  multiple libraries  to  avoid  low  complexity
samples.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.0.0

------------------------------------------------------------------------

### Usage

To load Preseq:

    module load biokit

or:

    module load preseq

Usage:

    preseq <command> [OPTIONS]

Example:

    preseq c_curve -o output.txt input.sort.bed

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

-   Preseq [home page]
-   Preseq [manual]

------------------------------------------------------------------------

  [home page]: http://smithlabresearch.org/software/preseq/
  [manual]: http://smithlabresearch.org/wp-content/uploads/manual.pdf
