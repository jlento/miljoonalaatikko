## BEAST

### Description

BEAST is a cross-platform program for Bayesian MCMC analysis of
molecular sequences. It is entirely orientated towards rooted,
time-measured phylogenies inferred using strict or relaxed molecular
clock models. It can be used as a method of reconstructing phylogenies
but is also a framework for testing evolutionary hypotheses without
conditioning on a single tree topology. BEAST uses MCMC to average over
tree space, so that each tree is weighted proportional to its posterior
probability.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 1.7.5, 1.8.0, 2.0.2, 2.1.3, 2.4.3, 2.4.7

------------------------------------------------------------------------

### Usage

To load the default version on Taito you can use

    module load biokit

or:

    module load beast

To load a specific version you can use the version number, e.g.:

    module load beast/2.1.3

To check the available versions use:

    module spider beast

BEAST can be used either interactively with a graphical user interface
or in command line mode. Any batch jobs need to be run in the command
line mode. Interactive use is best done in Taito-shell. Longer runs
should be done as batch jobs in Taito. You can of course use the
graphical tools in Taito-shell to set up the run and the do the run
itself in Taito.

To run with the GUI (you will need X server connection):

    beauti

    beast

To run in command line mode:

    beast <options> example.xml

Sometimes you may need to give some extra options to Java, e.g. to
increase MaxHeapSize. In these cases use:

    java <java options> -jar $CLASSPATH/beast.jar

For example:

    java -Xmx4g -jar $CLASSPATH/beast.jar example.xml

BEAST installation also includes helper programs FigTree and Tracer.
They are set up when the BEAST module is loaded and are started with
commands **figtree** and **tracer** respectively. Due to their
interactive nature they are best used in Taito-shell.

You need a X server connection to use the graphical interfaces. If you
have trouble setting this up, you might also consider running beauti
locally on your own computer and transferring the resulting .xml files
to CSC for analysis in command line mode.

**BEAGLE**

BEAGLE is a high-performance library that can improve the performance of
BEAST. Depending on the dataset and analysis you can typically expect a
2x-3x speedup. To use BEAGLE you need to specify the appropriate options
on the beast command line. You can try beagle\_SSE and beagle\_CPU
options.

    beast -beagle_SSE example.xml

    beast -beagle_CPU example.xml

BEAGLE extensions are available on all servers.

**BEAST 2 Packages**

In BEAST 2.x many models and analysis methods are implemented as BEAST 2
Packages. For version management reasons these are not installed in the
common installation, but they can be easily installed by each user as
necessary.

You can use the either use the **beauti** interface (from the top menu
select "File" -&gt; "Manage packages") or use the command line
**addonmanager** program.

To list available packages:

    addonmanager -list

To install a package:

    addonmanager -add SNAPP

To uninstall a package:

    addonmanager -del SNAPP

 

**Batch jobs in Taito**

To submit a BEAST job in Taito, you must construct a xml file (see BEAST
documentation for details) and a batch job script.

BEAST can use thread based parallelization that can speed up some
analyses. In this example batch job script we run BEAST using 8
computing cores.

    !/bin/bash -l

    ## name of your job
    #SBATCH -J beast_example

    ## system error message output file
    #SBATCH -e beast_example_err_%j

    ## system message output file
    #SBATCH -o beast_example_output_%j

    ## a per-process (soft) memory limit
    ## limit is specified in MB
    ## example: 1 GB is 1000
    #SBATCH --mem-per-cpu=1000

    ## how long a job takes, wallclock time hh:mm:ss
    #SBATCH -t 01:00:00

    ## number of cores to use
    #SBATCH -n 1
    #SBATCH --nodes=1
    #SBATCH --cpus-per-task=8

    ## run my executable
    beast -overwrite -seed 345 -beagle_sse -threads 8 benchmark1.xml > example.out

The batch job is submitted with command (where "my\_job\_script" is the
name of your batch file):

    sbatch my_job_script

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

For more information see the software home page:

-   [BEAST 1.x home page]
-   [BEAST 2.x home page]

------------------------------------------------------------------------

  [BEAST 1.x home page]: http://beast.bio.ed.ac.uk/
  [BEAST 2.x home page]: http://beast2.org/
