## MSMC

### Description

This software implements MSMC, a method to infer population size and
gene flow from multiple genome sequences.

In short, msmc can infer

-   the scaled population size of a single population as a function of
    time
-   the timing and nature of population separations between two
    populations

from multiple phased haplotypes. When only two haplotypes are given,
MSMC is similar to PSMC, and we call it PSMC' because of subtle
differences in the method and the underlying model, which allows PSMC'
to infer more accurately the recombination rate.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: msmc

------------------------------------------------------------------------

### Usage

To load MSMC:

    module load python-env/3.4.1
    module load msmc

Note that the MSMC module can also be loaded directly. Python is only
needed if you wish to use the msmc-tools scripts (bamCaller.py etc)

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Inferring human population size and separation history from multiple
genome sequences. Stephan Schiffels & Richard Durbin, [Nature Genetics
46, 919–925 (2014)] doi:10.1038/ng.3015

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[Short guide to MSMC]

------------------------------------------------------------------------

  [Nature Genetics 46, 919–925 (2014)]: http://www.nature.com/ng/journal/v46/n8/full/ng.3015.html
  [Short guide to MSMC]: https://github.com/stschiff/msmc/blob/master/guide.md
