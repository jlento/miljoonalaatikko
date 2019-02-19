## Wise2

### Description

Wise2 program contains tools for comparing protein sequences and protein
profile HMMs to nucleotide sequences. Wise2 programs utilize structural
gene models that enable it to cope with introns and frame shift errors.

**Wise2 programs**

<table>
<thead>
<tr class="header">
<th>Program</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Main wise2 programs</td>
<td> </td>
</tr>
<tr class="even">
<td>genewise</td>
<td>Aligns a genomic nucleotide sequence with a protein sequence or a protein profile HMM</td>
</tr>
<tr class="odd">
<td>genewisedb</td>
<td>Compares a genomic nucleotide sequence agaist a set of protein sequences or protein profile HMMs</td>
</tr>
<tr class="even">
<td>estwise</td>
<td>Aligns a cDNA sequence with a protein sequence or profile HMM</td>
</tr>
<tr class="odd">
<td>estwisedb</td>
<td>Compares a cDNA nucleotide sequence agaist a set of protein sequences or protein profile HMMs</td>
</tr>
<tr class="even">
<td>Other wise2 programs</td>
<td> </td>
</tr>
<tr class="odd">
<td>dba</td>
<td>Dna Block Aligner</td>
</tr>
<tr class="even">
<td>psw</td>
<td>Protein Smith-Waterman and other comparisons</td>
</tr>
<tr class="odd">
<td>pswdb</td>
<td>protein smith waterman database searching<br />
 </td>
</tr>
</tbody>
</table>

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.4.1-17

------------------------------------------------------------------------

### Usage

The wise2 setup command is:

    module load biokit

After the setup command, Tito recognizes Wise2 commands. Also an
environment variable HMMERDB is defined to point to the Pfam databases.

You can list the command line options of Wise2 programs by using
option** -help**. For example:

    genewise -help

A simple comparison between a nucleotide and a protein sequece can be
done with following command:

    genewise protein.fasta nucleotide.fasta

**Pfam database**

In Taito, you can use Pfam\_ls and Pfam\_fs databases with Wise2
commands. For example comparing an EST sequence against a Pfam\_fs
HMM-database can be performed with command:

    estwisedb -pfam $HMMERDB/Pfam_fs -dnadb ESTs.fasta > results.txt

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

-   [Wise2 home page at EBI]

------------------------------------------------------------------------

  [Wise2 home page at EBI]: http://www.ebi.ac.uk/Tools/psa/genewise/
