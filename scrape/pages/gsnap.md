## GMAP/GSNAP

### Description

GSNAP is an efficient program that aligns relatively short nucleotide sequences against a long reference sequence such as the human genome.

GSNAP can be used to align both single-end and paired end reads to a reference genome or sequence set.

At the moment GSNAP is not able to map color-space data.

* * *

### Available

##### Version on CSC's Servers

Taito: 2018-07-04 (in biokit/4.9.3) and 2017-11-15 (in biokit)  
FGI grid

* * *

### Usage

To initialize the program in Taito:

    module load biokit

The basic syntax of GSNAP commands is:

    gsnap -d genome query.fastq \[options\]

The command line help of GSNAP can be checked with command:

    gsnap --help

**Reference genome indexing**

CSC does not maintain pre-compiled GSNAP indexes for reference genomes. Thus normally the fist step in creating alignment with GSNAP is downloading the reference genome and indexing it.

Please note that your $HOME directory is often too small for working with complete genomes. In stead you should do the analysis in temporary directories like $WRKDIR, $METAWRK or $FCWRKDIR.

You can use for example command **ensemblfetch** or [**wget**](http://research.csc.fi/csc-guide-using-wget-to-download-data-from-web-sites-to-csc) to download a reference genome to CSC. For example

    ensemblfetch homo\_sapiens

The command above retrieves the human genome sequence to a file called. Homo\_sapiens.GRCh37.63.dna.toplevel.fa. You can calculate the GSNAP indexes for this file with command:

    gmap\_build -d human -D $WRKDIR/gsnap\_indexes Homo\_sapiens.GRCh37.63.dna.toplevel.fa

The option -d defines the name of the GSNAP indexes and the option -D defines the location, where the indexes will be stored.

**Single-end and pair-end alignment**

Once the indexing is ready you can carry out the alignment for singe-end reads with command like:

    gsnap -t 4 -d human -D $WRKDIR/gsnap\_indexes query.fastq 

In the case of paired-end reads you should have read pairs in two matching fastq files:

    gsnap -t 4 -d human -D $WRKDIR/gsnap\_indexes query1.fastq query2.fastq 

By default GSNAP uses its' own output format. To produce the alignment in SAM format please use option **-A sam**

    gsnap -t 4 -d human -D $WRKDIR/gsnap\_indexes query1.fastq query2.fastq -A sam

* * *

### Discipline

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

*   [Gmap/GSNAP home page](http://research-pub.gene.com/gmap/)
*   [GSNAP manual](http://research-pub.gene.com/gmap/src/README)

* * *