## SHRiMP

### Description

SHRiMP is  a software package  for mapping  reads from a  donor genome
against a target (reference) genome. SHRiMP was primarily developed to
work with  short reads  produced by  Next Generation  Sequencing (NGS)
machines.  SHRiMP sopports  both  letter  space (Illumina/Solexa)  and
colour space  (AB SOLiD) reads.  Both single-end and paired  end reads
can be analysed.

SHRiMP is  considered to  be more  sensitive but  significantly slower
than Bowtie or BWA read mapping tools.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 2.2.3  
FGI grid: 2.2.3

------------------------------------------------------------------------

### Usage

To initialize the program in Taito you can use command:

    module load biokit

The biokit module sets up a set of commonly used bioinformatics tools,
including SHRiMP. (Note however that there are bioinformatics tools in
Taito, that have a separate setup commands.)

After  this  you  could  send  a shrimp  alignment  job  with  command
**gmapper-ls** (for letter space reads) or **gmapper-cs** ( for colour
space reads).  For example

    gmapper-ls reads.fasta genome.fasta > result.sam

You can use  option **--help** to see all the  command line options of
the gmapper commands.

    gmapper-ls --help

By default SHRiMP  assumes that both the query reads  to be mapped and
the genome  sequence files are  in fasta format. Fastq  formatted read
files can  be used  with option  **-Q**. Please  note that  your $HOME
directory is  often too  small for working  with complete  genomes. In
stead  you  should  do  the analysis  in  temporary  directories  like
$WRKDIR, $METAWRK or $FCWRKDIR.

**Running SHRiMP alignments utilizing grid computing**

Aligning  millions of  reads  to  a large  reference  genome can  take
several   hours   or  even   days.   Using   grid  computing   through
**grid\_gmapper\_cs** and **grid\_gmapper\_ls** commands, available in
Taito cluster,  you can  speed up  the alignment  process ten  fold or
more. **grid\_gmapper** commands split the alignment task into several
subtasks that it submits to be simultaneously executed in the FGI grid
environment. When  all the subtasks  are ready they are  collected and
combined into a single result alignment.

To be able to use grid\_ gmapper commands you should have:

1.  A valid [grid certificate] installed in the taito.csc.fi server.
2.  Membership of [FGI Virtual Organization]

For detailed instructions, see the [FGI User Guide].

Once you have  the certificate installed and  the Virtual organization
membership is approved, you can submit  a SHRiMP jobs to grid with for
example following commands:

    module load shrimp

    arcproxy -S fgi.csc.fi -c validityPeriod=72h

    grid_gmapper-ls -query seq_set-fasta -ref ref_genome.fasta -out results.sam

For more information about  grid\_gmapper-ls and grid\_gmapper-cs, run
command

    grid_gmapper-ls --help

or

 

    grid_gmapper-cs --help

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Matei David, Misko Dzamba, Dan Lister, Lucian Ilie and Michael Brudno,
"SHRiMP2: Sensitive yet Practical  Short Read Mapping", Bioinformatics
(2011) 27 (7): 1011-1012

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More information about SHRiMP can be found from:

-   [SHRiMP home page]
-   [SHRiMP README file]

------------------------------------------------------------------------

  [grid certificate]: http://www.csc.fi/english/customers/university/grid_certificates/index_html
  [FGI Virtual Organization]: https://voms.fgi.csc.fi:8443/voms/fgi
  [FGI User Guide]: https://research.csc.fi/fgi-user-guide
  [SHRiMP home page]: http://compbio.cs.toronto.edu/shrimp/
  [SHRiMP README file]: http://compbio.cs.toronto.edu/shrimp/README
