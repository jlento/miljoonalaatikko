## MACS

### Description

MACS (Model-based  Analysis of ChIP-Seq)  is an analysis tool  for NGS
ChIP-Seq data.  MACS empirically  models the  length of  the sequenced
ChIP  fragments and  uses  it  to improve  the  spatial resolution  of
predicted binding sites. 

MACS also uses  a dynamic Poisson distribution  to effectively capture
local biases in  the genome sequence, allowing for  more sensitive and
robust  prediction. MACS  compares can  be used  for ChIP-Seq  with or
without control samples.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 1.4.2, 2.1.0  
[Chipster] graphical user interface

------------------------------------------------------------------------

### Usage

To set up MACS commands in Taito, give commands:

    module load biokit
    module load openblas/0.2.6
    module load python

After that you can start MACS with command:

    macs14

or

    macs2

MACS can  be run  interactively in  Taito-shell or as  a batch  job in
Taito.  Check [chapter 3] of the Taito User Guide for more information
on running batch jobs.

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

-   [MACS home page]
-   [MACS 2]

------------------------------------------------------------------------

  [Chipster]: http://chipster.csc.fi/
  [chapter 3]: https://research.csc.fi/taito-batch-jobs/
  [MACS home page]: http://liulab.dfci.harvard.edu/MACS/
  [MACS 2]: https://github.com/taoliu/MACS/
