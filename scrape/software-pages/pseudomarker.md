## Pseudomarker

### Description

Pseudomarker can be used for joint linkage and LD analysis.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.0

------------------------------------------------------------------------

### Usage

To initialize the program in Taito type:

    module load python-env/2.7.3
    module load pseudomarker

Pseudomarker needs pedigree file in a pre-makeped format. Map-file is in
the format used by Mega2. Data file needs to be linkage formatted.

The basic call is:

    pseudomarker -p pedigree.ped -m pedigree.map

Analysis options are appended after this basic call. For example to run
a dominant analysis use:

    pseudomarker -p pedigree.ped -m pedigree.map --dom

Further information on available analysis options is available on the
developers site.

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

-   Pseudomarker [home page]

------------------------------------------------------------------------

  [home page]: http://www.helsinki.fi/~tsjuntun/pseudomarker/
