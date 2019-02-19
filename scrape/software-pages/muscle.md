## MUSCLE

### Description

MUSCLE is a fast and accurate sequence alignment program. It's novelty
lies in the algorithm that initially creates a fast and crude alignment
that is subsequently refined to a more optimal alignment.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 3.8.31

------------------------------------------------------------------------

### Usage

In Taito MUSCLE is taken in use with command:

    module load biokit

A basic alignment from FastA-formatted input sequences (here, in file
inseqs.fasta) is created by the call:

    muscle -in inseqs.fasta -out outseqs.fasta

Note that the output is also in FastA format. If you need to get the
alignment in, say, Phylip format, you first need to save the alignment
in muscle in Clustal-format. Then you need to open and save this
alignment in Clustal in Phylip format. Clustal-formatted alignments can
be produced with the following command:

    muscle -in inseqs.fasta -out outseqs.fasta -clw -clwstrict

Options related to refining and creation of large alignment are
described in detail in the [MUSCLE manual].

Information on setting up a batch job in Taito can be found in the
[Taito manual].

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Edgar, R.C. (2004) MUSCLE: multiple sequence alignment with high
accuracy and high throughput.Nucleic Acids Res. 32(5):1792-1797.  
doi:10.1093/nar/gkh340

  
Edgar, R.C. (2004) MUSCLE: a multiple sequence alignment method with
reduced time and space complexity BMC Bioinformatics, (5) 113.  
doi:10.1186/1471-2105-5-113

 

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[MUSCLE documentation][MUSCLE manual]

------------------------------------------------------------------------

  [MUSCLE manual]: http://www.drive5.com/muscle/manual/
  [Taito manual]: http://research.csc.fi/taito-batch-jobs
