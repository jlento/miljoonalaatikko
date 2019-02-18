## InterProScan

### Description

InterProScan is  a tool that  compairs protein or  nucleotide sequence
against a  set of  protein signature  databases. The  results obtained
from   different  databases   are   given  in   uniform  format.   The
InterProScan5  installation  at CSC  can  be  used to  search  protein
signatures from following databases:

-   TIGRFAM
-   PIRSF
-   ProDom
-   SMART
-   PrositeProfiles
-   PrositePatterns
-   HAMAP
-   PfamA
-   PRINTS
-   SuperFamily
-   Coils
-   Gene3d

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: interproscan5 (5.26-65.0)  
FGI grid: interproscan5

------------------------------------------------------------------------

### Usage

**Running InterProScan in Taito**

In Taito, first set up the bioinformatics toolkit with command:

    module load biokit

The  *biokit* module  sets up  a set  of commonly  used bioinformatics
tools.   Note however  that  there are  also  bioinformatics tools  in
Taito, that
have a separate setup commands.  
  
After   that  you   can  submit    InterProScan  jobs   using  command
**cluster\_interproscan**. *Cluster\_interproscan* is a help tool that
automatically runs your  InterProScan task using the  batch job system
of  Taito.  If   your  query  file  contains   several  sequences  the
cluster\_interproscan tool also  automatically splits the InterProScan
tasks to  several subtasks  that are run  simultaneously in  the Taito
cluster. *cluster\_interproscan*  accepts all the  normal InterProScan
options. To check the available options, give command:

    cluster_interproscan -h

Below is  two sample InterProScan commands  
  
1. Running InterProScan search for  a nucleotide sequence set  against
all InterProScan databases. Results are reported in XML format.

    cluster_interproscan -i nucleotides.fasta -o results.xml -f XML -t
    n

2. Running InterProScan search for  protein sequence set against PfamA
databases. Results are reported in GFF3 format.

    cluster_interproscan  -i proteins.fasta  -o  results.gff3 -f  GFF3
    -appl PfamA

**Running InterProScan in FGI grid environment.**

In Taito, you can send InterProScan  jobs to FGI grid environment with
command

    grid_interproscan

This  command  works  much like  the  *cluster\_interproscan*  command
described  above.   Grid  approach  is  recommended   for  very  large
interproscan runs.

-   [Instructions to use grid\_interproscan in Taito]

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

-   [InterProScan5 home page]

------------------------------------------------------------------------

  [Instructions to use grid\_interproscan in Taito]: http://research.csc.fi/-/using-fgi-to-run-interproscan-jobs
  [InterProScan5 home page]: http://code.google.com/p/interproscan/
