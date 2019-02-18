## minimap2

### Description

Minimap2 is  a fast  general-purpose alignment program  to map  DNA or
long mRNA  sequences against  a large reference  database.  It  can be
used for:

-   mapping of accurate short reads (preferably longer that 100 bases)
-    mapping 1kb  genomic reads  at error   rate 15%  (e.g. PacBio  or
    Oxford Nanopore genomic reads)
-   mapping full-length noisy Direct RNA or cDNA reads
-   mapping  and comparing  assembly contigs  or closely  related full
    chromosomes of hundreds of megabases in length.

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Minimap 2.9-r720 is available in Taito

------------------------------------------------------------------------

### Usage

Minimap2 starts in Taito with command:

    minimap2

Without any options,  minimap2 takes a reference database  and a query
sequence  file  as  input  and produce  approximate  mapping,  without
base-level alignment (i.e. no CIGAR), in the PAF format:

    minimap2 ref.fa query.fq > approx-mapping.paf

If you wish to get the output in sam format you can use option **-a**.

  
For different data types minimap2 needs to be tuned for optimal
performance and accuracy.  
With option **-x** you can take in use case specific parameter sets,
pre-defined and recommended by the minimap2 developers.  
   
**Map long noisy genomic reads (map-pb and map-ont)**

PacBio subreads (map-db):

    minimap2 -ax map-pb  ref.fa pacbio-reads.fq > aln.sam

Oxford Nanopore reads (map-ont):

    minimap2 -ax map-ont ref.fa ont-reads.fq > aln.sam 

**Map long mRNA/cDNA reads (splice)**

PacBio Iso-seq/traditional cDNA

    minimap2 -ax splice -uf ref.fa iso-seq.fq > aln.sam

Nanopore 2D cDNA-seq

    minimap2 -ax splice ref.fa nanopore-cdna.fa > aln.sam

Nanopore Direct RNA-seq

    minimap2 -ax splice -uf -k14 ref.fa direct-rna.fq > aln.sam

 

mapping against SIRV control

    minimap2 -ax splice --splice-flank=no SIRV.fa SIRV-seq.fa

**Find overlaps between long reads (ava-pb and aca-ont)**

PacBio read overlap

    minimap2 -x ava-pb  reads.fq reads.fq > ovlp.paf

Oxford Nanopore read overlap

    minimap2 -x ava-ont reads.fq reads.fq > ovlp.paf   

**Map short accurate genomic reads (sr)**  
Note, minimap2 does work well with short spliced reads.

single-end alignment

    minimap2 -ax sr ref.fa reads-se.fq > aln.sam

paired-end alignment

    minimap2 -ax sr ref.fa read1.fq read2.fq > aln.sam    

paired-end alignment

    minimap2 -ax sr ref.fa reads-interleaved.fq > aln.sam 

**Full genome/assembly alignment asm5**

assembly to assembly

    minimap2 -ax asm5 ref.fa asm.fa > aln.sam  

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

[Minimap21 report]

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

[Minimap2 home page]

------------------------------------------------------------------------

  [Minimap21 report]: https://arxiv.org/pdf/1708.01492.pdf
  [Minimap2 home page]: https://lh3.github.io/minimap2/
