## POY

### Description

POY  is  a  program  for cladistic  and  phylogenetic  analysis  using
sequence  and/or  morphological  data.   Most  of  the  commonly  used
DNA-sequence based phylogenetics analysis  methods are based on static
multiple sequence alignments. Thus, these methods are dependent of the
quality  of  the alignment,  a  feature  that  is often  difficult  to
estimate, as well as of
the heuristics of applying a gap model for insertions and deletions.  
  
The POY  program uses  alternative methods, e.g.,  direct optimization
and  fixed character  states optimization,  to construct  phylogenetic
trees.  These  methods are able to  assess directly the number  of DNA
sequence  transformations, evolutionary  events,  required  by a  tree
topology without the use of multiple sequence alignment.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 4.1.2, 4.1.3b, 5.1.1

------------------------------------------------------------------------

### Usage

The  software needs  to be  initialized before  use. On  Taito correct
compiler environment needs to be loaded first. Packages needed by each
software version can be check with the "module spider" command, e.g

    module spider poy/5.1.1

For example to load poy versio 5.1.1 you would use:

    module purge
    module load gcc/4.8.2
    module load intelmpi/4.1.3
    module load poy/5.1.1

Both  serial and  parallel  version are  provided  on Taito.  Parallel
version is recommended for most uses. The binaries are called:

    poy.serial

    poy.mpi

There are  also version for  longer sequences. These  accept sequences
longer  than 16383  elements, but  require  more memory  and may  take
longer to run:

    poy.long.serial

    poy.long.mpi

POY  can be  run in  interactive  mode, but  interactive sessions  are
limited to a maximum of four hours of computational time. It is mostly
useful for checking  you input files and parameters before  a run. The
interactive version  uses the ncurses  interface unlike the  batch job
versions that use a "flat" interface:

    poy.interactive

For more  information on  how to  run interactive  jobs, see  the user
manual: [Running interactive batch jobs in Taito].

**Parallel Batch jobs**

You  need three  different files.  The first  contains the  sequences,
let's call  it seqs.fas here. The  next one lists all  POY command you
want to perform, one command per line. Here's a working example, let's
call the file tuto1.txt:

    set(log:"poylogfile.txt")
    read("seqs.fas")
    build(100)
    swap()
    select()
    report(asciitrees)
    report(trees:(total, newick))
    exit()

Lastly, you  need to  create a  batch job script.  You can  modify the
following example script to match your analysis.

Note that  the following script loads  the POY commands from  the file
tuto1.txt that was created above.  The analysis results will appear on
the log  file called  poylogfile.txt (this is  set in  the tuto1.txt).
Additionally, they will normally appear in a run specific prog.o.xxxxx
file. File tuto1.out will contain the trees.

    #!/bin/bash -l
    #SBATCH -J poy-job
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 01:00:00
    #SBATCH -n 16
    #SBATCH --mem-per-cpu=1000
    #SBATCH -p parallel

    srun poy.mpi tuto1.txt > tuto1.out

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

Varón,  A.,  L.  S.  Vinh,  W.   C.  Wheeler.  2010.  POY  version  4:
phylogenetic analysis using dynamic homologies. Cladistics, 26:72-85.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

More  information  about POY  can  be  found  from the  [POY][]  [home
page][POY].

------------------------------------------------------------------------

  [Running interactive batch jobs in Taito]: http://research.csc.fi/taito-interactive-batch-jobs
  [POY]: https://www.amnh.org/our-research/computational-sciences/research/projects/systematic-biology/poy
