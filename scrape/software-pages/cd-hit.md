## CD-HIT

### Description

CD-HIT can  be used for  clustering large sequence sets   or  removing
identical or highly  similar sequences from a sequence  set. CD-HIT is
often  used as  a tool  to produce  a non  redundant sequence  set for
further analysis of a large  sequence set. CD-HIT recognizes fasta and
fastq sequence formats.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 4.6.8

------------------------------------------------------------------------

### Usage

The setup command for CD-HIT in Taito cluster is:

    module load biokit

After the  setup command, the  server recognizes CD-HIT  commands. The
CD-HIT package has many programs. The most notable are:

| Program | Description |
|--------------|--------------------------------------------------------------------------------------------------------------------|
| cdhit | Clustering and redundance removal tool for protein sequences |
| cdhit-est | Clustering and redundance removal tool for nucleic acid sequences (only for sequences that do not contain introns) |
| cdhit-2d | Tool to compare two protein sequence sets |
| cdhit-est-2d | Tool to compare two nucleic sequence sets |
| cdhit-454 | A program to identify artificial duplicates from raw 454 sequencing reads |

 

A ful list of programs can be found in the [CD-HIT user guide].

You can  list the  command line  options of  CD-HIT programs  by using
option -help. For example:

    cd-hit -help

A simple analysis  for a protein sequence set can  be done for example
with command:

    cd-hit -i my_proteins.fasta -o reduced_set.fasta -c 0.95

The sample command above produces two result files:

1.  reduced\_set.fasta contains  a pruned sequence set.  In this case,
    if two sequences are more than  95% identical, only the longer one
    is included to the results.
2.  reduced\_set.fasta.clstr contains information about the clustering
    of  the  sequences that  share  higher  similarity than  the  give
    threshold value (in this case 95%).

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

For citations please see [CD-HIT documentation].

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[CD-HIT user guide]

[CD-HIT home page]

------------------------------------------------------------------------

  [CD-HIT user guide]: http://weizhong-lab.ucsd.edu/cd-hit/wiki/doku.php?id=cd-hit_user_guide
  [CD-HIT documentation]: http://weizhong-lab.ucsd.edu/cd-hit/ref.php
  [CD-HIT home page]: http://weizhongli-lab.org/cd-hit/
