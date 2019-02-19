## MERLIN

### Description

MERLIN is a very fast linkage analysis package that uses efficient data
structures (sparse trees) to represent the traversal of genes in
pedigrees.

MERLIN can be used for:

1.  non-parametric multipoint linkage analysis
2.  variance component analysis
3.  IBD (identical by descent) and kinship estimation
4.  haplotype reconstruction
5.  detection of genotyping errors
6.  allele dropping simulations

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 1.1.2

------------------------------------------------------------------------

### Usage

The program neds to be initialized before use.

On Taito use

    module load biokit

MERLIN requires the following input files:

1.  Pedigree file in a standard LINKAGE format
2.  Map file
3.  Locus file (can be replaced by a LINKAGE format locus file)
4.  Allele frequency file (optional)

To run MERLIN, type merlin followed by command line options, for
example:

    merlin -d linkage.loci -p linkage.pre -m linkage.map --npl --trim --bits 30

A full description of MERLIN command line parameters can be viewed at
[MERLIN reference sheet] at the University of Michigan.

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

When you use MERLIN, cite:

Abecasis GR, Cherny SS, Cookson WO and Cardon LR, Merlin - rapid
analysis of dense genetic maps using sparse gene flow trees. Nat Genet
(2002) 30: 97-101.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More information about MERLIN can be found from the [Merlin home page].

------------------------------------------------------------------------

  [MERLIN reference sheet]: http://www.sph.umich.edu/csg/abecasis/Merlin/reference.html
  [Merlin home page]: http://www.sph.umich.edu/csg/abecasis/Merlin/
