## Kallisto

### Description

**kallisto** is  a program  for quantifying abundances  of transcripts
from  RNA-Seq  data,  or  more generally  of  target  sequences  using
high-throughput sequencing  reads. It  is based on  the novel  idea of
pseudoalignment  for rapidly  determining the  compatibility of  reads
with targets, without the need for alignment.

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 0.44.0

------------------------------------------------------------------------

### Usage

To load the default version on Taito you can use

    module load kallisto

For usage help use:

    kallisto

For help on writing batch job scripts see the [Taito User Guide].

### Sleuth

**sleuth** is a program for  differential analysis of RNA-Seq data. It
makes  use  of  quantification   uncertainty  estimates  obtained  via
**kallisto** for accurate differential  analysis of isoforms or genes,
allows testing in the context of experiments with complex designs, and
supports interactive exploratory data analysis via sleuth live.

To use sleuth:

    module load r-env/3.5.1

To use sleuth and kallisto together, load the r-env module first:

    module load r-env/3.5.1
    module load kallisto

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Kallisto:

1.  Nicolas  L Bray, Harold  Pimentel, Páll Melsted and  Lior Pachter,
    [Near-optimal   probabilistic   RNA-seq  quantification],   Nature
    Biotechnology **34**, 525–527 (2016), doi:10.1038/nbt.3519

Sleuth:

1.   H Pimentel,  NL  Bray,  S Puente,  P  Melsted  and Lior  Pachter,
    [Differential  analysis  of RNA-seq  incorporating  quantification
    uncertainty],    Nature    Methods   **14**,    687–690    (2017),
    doi:10.1038/nmeth.4324

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [Kallisto: getting started]
-   [Sleuth home page]

 

------------------------------------------------------------------------

  [Taito User Guide]: https://research.csc.fi/taito-batch-jobs
  [Near-optimal probabilistic RNA-seq quantification]: http://www.nature.com/nbt/journal/v34/n5/full/nbt.3519.html
  [Differential analysis of RNA-seq incorporating quantification
  uncertainty]: http://www.nature.com/nmeth/journal/vaop/ncurrent/full/nmeth.4324.html
  [Kallisto: getting started]: https://pachterlab.github.io/kallisto/starting.html
  [Sleuth home page]: https://pachterlab.github.io/sleuth/
