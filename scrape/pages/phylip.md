## PHYLIP

### Description

PHYLIP is a FREE package of programs by Joseph Felsenstein for inferring phylogenies and carrying out certain related tasks. At present it contains 35 programs.

* * *

### Available

##### Version on CSC's Servers

Taito: 3.69

* * *

### Usage

The software needs to be initialized before use.

On Taito type:

    module load biokit

The programs that form the package can then be invoked by their names. For example:

    dnapars

The programs read the input file from the current directory. The input file has to be named 'input'. The programs write to the file 'outfile' and/or 'treefile'.

If you are a first time user, start out by reading the relevant parts from the main PHYLIP documentation and then proceed to read the program specific texts below.

**Command scripts**

If you are doing an analysis that takes long time, it may be reasonable to build a command script file that can be executed as a batch job in Taito.

Here's an example of a PHYLIP command script file for bootstrapping using distance methods.

    #!/bin/bash
    
    # Removes old analysis files
    rm -rf outfile
    rm -rf outtree
    rm -rf intree
    rm -rf infile1
    rm -rf infile2
    rm -rf infile3
    rm -rf phyout
    rm -rf phytreeout
    
    # Resampling phase
    seqboot <<EOF
    r
    10
    y
    1
    EOF
    
    mv infile infile1
    mv outfile infile
    
    # Distance calculation phase
    dnadist <<EOF
    m
    d
    10
    y
    EOF
    
    mv infile infile2
    mv outfile infile
    
    # Neighbor-joining tree phase
    neighbor <<EOF
    m
    10
    3
    y
    EOF
    
    mv infile infile3
    mv outfile infile
    mv outtree intree
    
    # Majority rule tree phase
    consense <<EOF
    y
    EOF
    
    mv outfile phyout
    mv outtree phytreeout
    
    # The infile will contain the sequence alignment...
    mv -f infile1 infile

You can save this script as e.g. phylip.job.sh and the make it executable:

    chmod u+x phylip.job.sh

You can now construct a Taito batch job file:

    #!/bin/bash -l
    #SBATCH -J phylip
    #SBATCH -o output\_%j.txt
    #SBATCH -e errors\_%j.txt
    #SBATCH -t 10:00:00
    #SBATCH -n 1
    #SBATCH --mem-per-cpu=4000
    #
    
    module load biokit
    ./phylip.job.sh

to submit the job to the queue use:

    sbatch file\_name.sh

See [Taito user guide](http://research.csc.fi/taito-batch-jobs) for details.

### DrawTree and DrawGram

To use DrawTree and DrawGram you need font files. These are provided with the software, but the programs try to look for them in your current directory, not in the installation folder. The easiest way to use them is to copy them into your own folder:

    cp /homeappl/appl\_taito/bio/phylip/phylip-3.695/exe/font\* .

The programs look for a file called "fontfile" by default, so if you have a favorite font, you can copy it by that name, e.g.

    cp font1 fontfile

Alternatively you can just provide a full path name to a font file when prompted.

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

More information can be found on the [PHYLIP home page](http://evolution.genetics.washington.edu/phylip/phylip.html).

* * *