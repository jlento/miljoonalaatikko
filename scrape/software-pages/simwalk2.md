## SimWalk2

### Description

SimWalk2 is a computer application for haplotype, location score,
identity by descent, and non-parametric statistical analyses on any size
of pedigree. SimWalk2 performs these analyses using Markov chain Monte
Carlo and simulated annealing algorithms.

SimWalk2 uses as input: the pedigree and locus data, a marker map, and,
optionally, reduced penetrance values for a trait locus and other
run-specifying parameters. SimWalk2 has been used successfully on data
with over 1000 individuals per pedigree and over 30 markers per
chromosome. The run time for SimWalk2 is linear in the number of
individuals and the number of markers.

SimWalk2 is capable of many types of analyses.

-   Haplotype analysis estimates the most likely set of fully typed
    maternal and paternal marker haplotypes at each individual in the
    pedigree.
-   Location scores indicate the relative likelihood of several
    positions, among the marker loci, for the trait locus given the
    pedigree data and the marker map.
-   Non-parametric analysis, also known as marker-allele sharing
    statistics or cluster analysis, is model-free and based on
    identity-by-descent (IBD).
-   IBD analysis estimates the probabilities that pairs of individuals
    share marker alleles identical by descent, i.e., inherited from a
    common ancestor within the pedigree.
-   The sampling option provides, for each input pedigree, a
    user-specified number of simulated pedigrees, each fully typed at
    all requested marker loci. The simulations do not alter the trait
    phenotypes, only the marker phenotypes.
-   The setup option performs no likelihood-based analysis on the data.
    This option merely checks that the data files are consistent and
    that the pedigrees have no incompatibilities.

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.91

------------------------------------------------------------------------

### Usage

To initialize the software in Taito:

    module load biokit

To run SimWalk2, type:

    simwalk2

In version 2.91, you need five input files:

-   BATCH2.DAT a batch file (you must use the name BATCH2.DAT for this
    file typed with capital letters)
-   a locus file
-   a pedigree file
-   a penetrance file
-   a map file

See software documentation on details on input file formats.

You can convert LINKAGE file formats to MENDEL file formats using Mega2
program.

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Published research assisted by this software should always cite:  
  
Sobel E and Lange K (1996) Descent graphs in pedigree analysis:
applications to haplotyping, location scores, and marker sharing
statistics Am J Hum Genet 58:1323-1337.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[SimWalk2 home page] gives more information about usage and file
formats.

------------------------------------------------------------------------

  [SimWalk2 home page]: http://watson.hgen.pitt.edu/docs/simwalk2.html
