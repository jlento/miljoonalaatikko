## MAFFT

### Description

MAFFT is a fast and accurate multiple sequence alignment program for
protein and nucleotide sequences. MAFFT offers several different
alignment strategies from which user should select the most suitable for
his case.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 7.407  
[Chipster] graphical user interface

------------------------------------------------------------------------

### Usage

To set up the MAFFT commands in Taito give command :

    module load biokit/4.9.3

After this you can use MAFFT with command syntax:

    mafft --parametes input_file.fasta > aligned_output.fasta

The most commonly used alignment strategies have their own command
aliases. Part of them are listed below:

L-INS-i (probably most accurate; recommended for &lt;200 sequences;
iterative refinement method incorporating local pairwise alignment
information)

    mafft --localpair --maxiterate 1000 input > output

    linsi input > output (Alias; works the same as the above) 

G-INS-i (suitable for sequences of similar lengths; recommended for
&lt;200 sequences; iterative refinement method incorporating global
pairwise alignment information):

    mafft --globalpair --maxiterate 1000 input > output

    ginsi input > output (Alias)

E-INS-i (suitable for sequences containing large unalignable regions;
recommended for &lt;200 sequences):

    mafft --ep 0 --genafpair --maxiterate 1000 input > output

    einsi input > output (Alias)

Alignment of two alignments

    mafft-profile group1 group2 > output

 

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

-   [MAFFT home page]
-   [MAFFT algorithms]
-   [MAFFT tips]

------------------------------------------------------------------------

  [Chipster]: http://chipster.csc.fi/
  [MAFFT home page]: http://mafft.cbrc.jp/alignment/software/index.html
  [MAFFT algorithms]: http://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html
  [MAFFT tips]: http://mafft.cbrc.jp/alignment/software/tips.html
