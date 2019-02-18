## Biopython

### Description

Biopython  is  a collection  of  python  modules that  facilitate  the
development  of python  scripts  for  bioinformatics applications.  As
such, it does not include ready to use programs in the sense that many
commercial packages  and free  web-based interfaces  do. On  the other
hand,  Biopython  provides  reusable python  modules  that  facilitate
writing  scripts for  sequence  manipulation,  accessing of  databases
using a range of data formats and execution and parsing of the results
of various molecular biology programs. Consequently, Biopython enables
developing scripts that can analyze  large quantities of sequence data
in ways that
are typically difficult or impossible with web based systems.  
 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Biopython versions 1.70 and 1.61 are available in Taito

------------------------------------------------------------------------

### Usage

To use Biopython in Taito, give command:

    module load biopython-env/3.4.5

This takes in use python version 3.4.5 and biopython 1.70.

    module load biopython-env/2.7.13

This takes in use python aversion 2.7.13 and biopython 1.70.

Alternatively you can run command:

    module load biopython-env

This module  load command loads  older versions of python  (2.7.3) and
biopython  (1.61).  These  biopython environments  use  user  specific
virtual  python environment  which  allows users  own pythoin  library
installations with *pip*.

After this you can launch a biopython program with command

    python my_biopython_code.py

Alternatively you can  change the python definition in  the first line
of your code to

    #!/bin/env python

and execute the python program

    ./my_biopython_code.pm

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

More information  about biopython  can be found  form the  homepage of
biopython.

    [www.biopython.org]

------------------------------------------------------------------------

  [www.biopython.org]: http://www.biopython.org
