## PedCheck

### Description

PedCheck detects marker typing incompatibilities in pedigree data -- if
they are Mendelian consistent.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 1.2

------------------------------------------------------------------------

### Usage

To initialize the program in Taito:

    module load biokit

To run PedCheck, type:

    pedcheck

Run also

    pedcheck -2

to guarantee that there is no inconsistency in a pedigree (see the
documentation).

**Input files:**

PedCheck will look for 'datafile.dat' and 'pedfile.dat' as default
inputs. These are LINKAGE format files ( which means that makeped has
been run on the pedigree file ). If either of these is not found,
PedCheck will prompt you to input a file name.

Command line options are also available for inputing these files: -p -d
.

PedCheck can handle pre-makeped files, so the pedigree and individual
names can be any string, not just numeric.

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

"PedCheck: A program for identifying genotype incompatibilities in
linkage analysis," O'Connell JR, Weeks DE, Am J Hum Genet 63:259-266

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

On-line documentation is available at the [authors web page].

------------------------------------------------------------------------

  [authors web page]: http://watson.hgen.pitt.edu/register/docs/pedcheck.html
