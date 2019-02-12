## Salmon

### Description

Salmon is a **wicked**\-fast program to produce a highly-accurate, transcript-level quantification estimates from RNA-seq data. Salmon achieves is accuracy and speed via a number of different innovations, including the use of _quasi-mapping_ (accurate but fast-to-compute proxies for traditional read alignments), and massively-parallel stochastic collapsed variational inference. The result is a versatile tool that fits nicely into many differnt pipelines. For example, you can choose to make use of our _quasi-mapping_ algorithm by providing Salmon with raw sequencing reads, or, if it is more convenient, you can provide Salmon with regular alignments (e.g. an **unsorted** BAM file produced with your favorite aligner), and it will use the same **wicked**\-fast, state-of-the-art inference algorithm to estimate transcript-level abundances for your experiment.

**NOTE**: Salmon works by (quasi)-mapping sequencing reads directly to the _transcriptome_. This means the Salmon index should be built on a set of target transcripts, **not** on the _genome_ of the underlying organism. If indexing appears to be taking a very long time, or using a tremendous amount of memory (which it should not), please ensure that you are not attempting to build an index on the genome of your organism!

* * *

### Available

##### Version on CSC's Servers

Taito: 0.9.1, 0.12.0

* * *

### Usage

To load the default version on Taito you can use

    module load salmon

For usage help use:

    salmon --help

For help on writing batch job scripts see the [Taito User Guide](https://research.csc.fi/taito-batch-jobs).

* * *

### Discipline

Biosciences  

* * *

### References

1.  Roberts, Adam, and Lior Pachter. "Streaming fragment assignment for real-time analysis of sequencing experiments." Nature Methods 10.1 (2013): 71-73.
2.  (1, 2) Roberts, Adam, et al. "Improving RNA-Seq expression estimates by correcting for fragment bias." Genome Biology 12.3 (2011): 1.
3.  (1, 2) Patro, Rob, et al. "Salmon provides fast and bias-aware quantification of transcript expression." Nature Methods (2017). Advanced Online Publication. doi: 10.1038/nmeth.4197
4.  Love, Michael I., Hogenesch, John B., Irizarry, Rafael A. "Modeling of RNA-seq fragment sequence bias reduces systematic errors in transcript abundance estimation." Nature Biotechnology 34.12 (2016). doi: 10.1038/nbt.3682

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

*   Salmon [documentation](http://salmon.readthedocs.io/en/latest/)

* * *