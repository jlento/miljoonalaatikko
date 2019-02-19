## ALLPATHS-LG

### Description

ALLPATHS‐LG is a whole‐genome shotgun assembler that can generate
high‐quality genome assemblies  using short reads. It has been designed
to use reads produced by new sequencing  technology machines such as the
Illumina Genome Analyzer. The current version has been  optimized for,
but not necessarily limited to, reads of length 100 bases.  ALLPATHS is
not designed to assemble Sanger or 454 FLX reads, or a mix of these with
short reads.

ALLPATHS‐LG requires high sequence coverage of the genome in order to
compensate for the shortness  of the reads. The precise coverage
required depends on the length and quality of the paired reads, but 
typically is of the order 100x or above. This is raw read coverage,
before any error correction or filtering.

ALLPATHS‐LG requires a minimum of 2 paired‐end libraries – one short and
one long. The short library  average separation size must be slightly
less than twice the read size, such that the reads from a pair will 
likely overlap – for example, for 100 base reads the insert size should
be 180 bases. The distribution of  sizes should be as small as possible,
with a standard deviation of less than 20%. The long library insert 
size should be approximately 3000 bases long and can have a larger size
distribution. Additional optional longer insert libraries can be used to
help disambiguate larger repeat structures and may be generated at lower
coverage.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 51503 (default), 52488

------------------------------------------------------------------------

### Usage

To initialize the program you need to give command:

    module load biokit

After this you can start using ALLPATHS-LG commands.

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

More information about ALLPATHS-LG can be found from:  
 

-   [ALLPATHS-LG home page].

------------------------------------------------------------------------

  [ALLPATHS-LG home page]: http://www.broadinstitute.org/software/allpaths-lg/blog/
