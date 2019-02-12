## BLAST

### Description

BLAST (Basic Local Alignment Search Tool) is the most frequently used sequence homology search tool. Given a probe sequence (nucleotide or protein), BLAST compares it to a sequence database and picks out sequences with significant similarity to the probe sequence. BLAST uses a heuristic search protocol, which makes search very fast compared to non-heuristic methods. The heuristics used may however cause BLAST to fail to find all significant hits.  
  
The command line version of NCBI-BLAST allows a user to modify all parameters of BLAST, to use special methods like PSI-BLAST and PHI-BLAST, and to analyze large data sets.  
  
In Taito you can use **pb** (Parallel Blast) command for large sets of query sequences. The _pb_ program splits a large search jobs into several subjobs, that can be executed simultaneously (more below).  
  
  
The most commonly used BLAST commands are:

*   **blastn** search hits for a nucleotide sequence from nucleotide database
*   **blastp** search hits for a protein sequence from protein database
*   **blastx** search hits for a nucleotide sequence from protein database
*   **psiblast** do iterative search for a protein sequence from protein database
*   **rpsblast** search hits for a protein sequence from protein profile database
*   **rpstblastn** search hits for a nucleotide sequence from protein profile database
*   **tblastn** search hits for a protein sequence from nucleotide database
*   **tblastx** search hits for a nucleotide sequence from nucleotide database by using the protein translations of both query and database sequences.

Oter blast commands

*   **blastdbcmd** retrieve a sequence or a set of sequences form BLAST databases
*   **makeblastdb** create a new BLAST database
*   **blast\_formatter** reformat a BLAST archive formatted BLAST result file.

* * *

### Available

##### Version on CSC's Servers

Taito: NCBI BLAST version 2.7.1  
FGI grid: NCBI BLAST version 2.6.0  
Chipster graphical data analysis interface

* * *

### Usage

At CSC, BLAST searches can be executed in several ways:

*   [using  the Chipster platform](http://chipster.csc.fi)
*   interavtively with normal BLAST commans in Taito-shell
*   as batch jobs with pb command in Taito
*   [in FGCI grid with gb command in Taito](http://research.csc.fi/-/using-fgi-to-run-blast-jobs)
*   [in FGCI-grid uising ARC middelware](https://confluence.csc.fi/display/fgi/BLAST+runtime+environment)

**Searches**

To use the latest BLAST in Taito first give set up command :

    module load biokit

After that you can start using the BLAST commands listed above. For example following command would search for sequence homologs form _UniProt_ database for a protein sequence.

    blastp -query proteinseq.fasta -db uniprot -out result.txt

You can use _-help_ option to see, what command line options are available for a certain BLAST command. For example 

    blastp -help

For example, command:  

    blastp -query proteinseq.fasta -evalue 0.001 -db uniprot -outfmt 7 -out result.table

Would run the same search as described above, except that the  e-value threshold would be set to 0.001(-evalue 0.001) and the out put is printed out a a table (-outfmt 7).

**Usage of pb (Parallel BLAST)  at CSC**

If your query sequence set contains less than 20 sequences then Taito-shell is probable the most effective platforms for the search. However, if your query set contains hundreds or thousands of sequences then utilizing the taito.csc.fi cluster is more  effective. For this kind of massive blast searches you can utilize the **pb** command in Taito. _pb_ (Parallel BLAST) is designed for situations, where the query file includes large amount of sequences. It splits the query task into several subjobs, that can be run simultaneously using the resources of the server very effectively. For large sets of query sequences, _pb_ can speed up the search up to 50 fold. Two sample _pb_ commands for taito.csc.fi:

    module load biokit
    
    pb blastn -db nt -query 100\_ests.fasta -out results.out
    
    pb psiblast -db swiss -query protseqs.fasta -num\_iterations 3 -out results.out

**Using own BLAST databases with pb**

The pb program also allows users to do BLAST searches against their own fasta formatted sequence sets. This is done by replacing the _\-db_ option with option **\-dbnuc** (for nucleotides) or **-dbprot** (for proteins). Example:

    pb blastn -dbnuc my\_seq\_set.fasta -query querys.fasta -out results.out

**Using genome data from ensembl with pb**

**pb** command can also automatically retrieve a species specific dataset from the _Ensembl_ or _Ensembl genomes_ servers and use the dataset as the search database. This is done by replacing the _\-db_ option with option **\-ensembl\_dna** (retrieves the genomic DNA),  **\-ensenmbl\_cdna** (retrieves the cDNA sequences)  or **\-ensembl\_prot** (retrieves the protein sequences). The latin name of a species or taxonomy index number is given as an argument for the ensembl options. You should use underscore (\_) in stead of space in the species name.  
  
For example to compare a set of nucleotide sequences against the human genome, you could use a command like:

    pb blastn -query dna\_fargments.fasta -ensembl\_dna homo\_sapiens -out  human\_hits.txt  
To compare the same dna fragments against the protein sequences, predicted from the chicken genome, you could use command:    pb tblastn -query dna\_fargments.fasta -ensembl\_prot gallus\_gallus -out  chicken\_hits.txt  
You can see the list of species, available at Ensembl and Ensembl genomes databases with command:    ensemblfetch -names

**BLAST databases at CSC**

Below is a list of BLAST databases maintained at the servers of CSC.

**Name**


**Database**


**Source file**


**Nucleotides**

nt

NCBI non-redundant nucleotide database

ftp://ftp.ncbi.nih.gov/blast/db/FASTA/

refseq

NCBI RefSeq RNA database

ftp://ftp.ncbi.nih.gov/refseq/release/complete/

refseq\_con

NCBI RefSeq human contigs

ftp://ftp.ncbi.nih.gov/refseq/H\_sapiens/H\_sapiens/

**Proteins**

nr

NCBI non-redundant protein database

ftp://ftp.ncbi.nih.gov/blast/db/FASTA/

pdb

PDB protein structure database

ftp://ftp.rcsb.org/pub/pdb/derived\_data/

swiss

Uniprot/Swiss database

ftp://ftp.ebi.ac.uk/pub/databases/uniprot/knowledgebase/

trembl

Uniprot/TrEMBL database

ftp://ftp.ebi.ac.uk/pub/databases/uniprot/knowledgebase/

uniref100

Uniref100 database

ftp://ftp.ebi.ac.uk/pub/databases/uniprot/uniref/uniref100/

uniref90

UniRef90 database

ftp://ftp.ebi.ac.uk/pub/databases/uniprot/uniref/uniref90/

uniref50

UniRef50 database

ftp://ftp.ebi.ac.uk/pub/databases/uniprot/uniref/uniref50/

**Ensembl genomes**

elect one of the species  with pb options: -ensembl\_dna, -ensembl\_cdna or -ensembl\_pep

ftp://ftp.ensembl.org/

**Users own BLAST databases**

CSC offers three ways to do BLAST queries against users own sequence sets  
  
1\. BLAST commands in Chipster  
Users can do BLAST searches against their own fasta formatted sequence sets with blast commands in Chipster

*   [Chpster](http://chipster.csc.fi)

  
2\. pb BLAST and gb BLAST  
In pb blast own databases are used by replacing the **-db** option with option **\-dbnuc** (for nucleotides) or **\-dbprot** (for proteins). Example:

    pb blastn -dbnuc my\_seq\_set.fasta -query querys.fasta -oout results.out

  
3\. makeblastdb  
You can use command _makeblastdb_ to create a BLAST search database form you own asn1 or fasta formatted sequence set. If you use fasta formatted sequence files, please note that _makeblastdb_ command assumes that the comment lines in the fasta file contain ncbi style names for the sequences ( e.g. gnl|db\_name|sequece\_id).  
  
You can use EMBOSS command seqret to convert a normal fasta file to a ncbi formatted fasta file. For exmaple:

    module load emboss
    
    seqret my\_seqs.fasta my\_seqs\_ncbi.fasta -osf ncbi  
After this the BLAST database can be created with command:    makeblastdb -in my\_seqs\_ncbi.fasta -out my\_seqs -parse\_seqids  
After this you can launch a search command. For example:    blastp -query proteinseq.fasta -db my\_seqs -out result.txt

Note that if the BLAST database does not locate in the directory where the search command is executed, then the location of the database must be defined with environment variable BLASTDB

    export BLASTDB=/path/to/your/blastdatabse

Note that the _-dbprot_ and _\-dbnuc_ options of the **pb** command (described above) do the database building operations automatically.

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

* * *