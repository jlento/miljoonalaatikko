## freebayes

### Description

FreeBayes  is  a  genetic  variant detector  designed  to  find  small
polymorphisms (SNPs , indels , MNPs and complex events).

*FreeBayes* is  haplotype-based, in the  sense that it  calls variants
based  on the  literal  sequences  of reads  aligned  to a  particular
target, not their  precise alignment. This model  is a straightforward
generalization of previous ones (e.g. PolyBayes, samtools, GATK) which
detect or report variants based  on alignments. This method avoids one
of the  core problems  with alignment-based variant  detection--- that
identical sequences may have multiple possible alignments:

*FreeBayes* uses short-read  alignments (BAM files) for  any number of
individuals from a population and  a reference genome to determine the
most-likely  combination  of  genotypes  for the  population  at  each
position  in  the  reference.  It reports  positions  which  it  finds
putatively polymorphic in variant call  file (VCF) format. It can also
use an input  set of variants (VCF) as a  source of prior information,
and  a copy  number variant  map  (BED) to  define non-uniform  ploidy
variation across the samples under analysis.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Version 1.1.0-60 is available in Taito

------------------------------------------------------------------------

### Usage

FreeBayes installation can be activated in Taito with commands

    module load biokit/4.9.3

After this you can launch the tool. Eg.

    freebayes -f reference.fa input.bam > results.vcf

To speed up FreeBayes  analysis, you can run the analysis  as a set of
parallel   FreeBayes    jobs   by    using   a   regions    file   and
**freebayes-taito** tool.

First define a regions file with command

    fasta_generate_regions.py reference.fa.fai 100000 > regions.txt

For small  datasets you may  decrease the  region size in  the command
above so that  you will get more than 200 regions to the regions file.

Once you  have the regions  file created  you can launch  you analysis
task with command like:

    freebayes-taito -regions regions.txt -f reference.fa input.bam -out results.vcf

or

    freebayes-taito-big -regions regions.txt -f reference.fa input.bam -out results.vcf

The freebayes-taito help tools will execute your freebayes analysis as
an automatically generated  array batch job. The results  will also be
automatically merged and sorted once the batch jobs have finished. The
**freebayes-taito** allows each  subjob to use 16 GB of  memory and to
run  for  two  days.  For  massive freebayes  jobs  this  may  not  be
sufficient. In  that case you  can try to  use **freebayes-taito-big**
that reserves 64 GB of memory and  three days of running time for each
subjob.

 

 

 

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

-   **[Freebayes home page]**
-   **[Refence publication]**

------------------------------------------------------------------------

  [Freebayes home page]: https://github.com/ekg/freebayes/blob/master/README.md
  [Refence publication]: https://arxiv.org/abs/1207.3907
