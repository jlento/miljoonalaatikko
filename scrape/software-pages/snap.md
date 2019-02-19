## SNAP

### Description

Sentinel Application Platform (SNAP) is a common architecture for all
Sentinel Toolboxes.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 7.0-snapshot

------------------------------------------------------------------------

### Usage

First load appropriate module.

`module load snap`

Module contains binaries snap, gpt and gpt\_array. The snap command
launches the GUI for SNAP software and can be used in Taito-shell via
NoMachine, although the GUI is not the fastest if multiple files are
loaded. Graph Processing Tool gpt is a command line tool used for bulk
processing. The gpt\_array command is a Taito specific tool that allows
using gpt with array jobs using same input file for each job (see below
for details).

**SNAP Configuration in taito**

Snap installation is found in /appl/earth/snap/VERSION and this is where
snap.home variable is set to. Default snap.userdir is located at
$WRKDIR/DONOTREMOVE/snap-userdir. The reason for having the
userdirectory in $WRKDIR instead of the usual $HOME location is that
SNAP creates a potentially large cache folder in snap.userdir/var/cache
and the home folder is limited to 50GB. While there are more space in
work directory than in home location user should ensure that they don't
needlessly waste disk space on cache that is not being used.

**Running Array jobs**

Running SNAP using array jobs is done the same way as for any other
software (see [here]), but when working with same input files for
multiple jobs some care needs to be taken because of the SNAP's cache
folder. If multiple jobs try to create the cache for same file at the
same time this will lead to problems. To ensure that cache is not
created by two processes at the same time there are two options:

1) First create the cache and only start the array job as usual after
cache has been built. This way the cache doesn't get modified by jobs
created in the array job.

2) There exists Taito specific gpt\_array command that allows to specify
a user directory for an instance of GPT. This can be used to ensure that
each job has it's own cache. Usage for gpt\_array command:
`gpt_array userdir normal_gpt_arguments` For example to create a
separate user directory for each job in an array job script:
`gpt_array $WRKDIR/tmp_snap_userdir_"$SLURM_ARRAY_TASK_ID" <normal gpt arguments>`
Note that using -Dsnap.userdir=&lt;dir&gt; with regular gpt command does
not work for some reason.

**Parallel processing**

SNAP supports parallel processing in shared memory environment. This
means that you can parallellize SNAP usage within one node in Taito. By
default SNAP tries to use however many cores you reserve for it but this
can be controlled by user in two ways:

1) Using gpt -q &lt;number\_of\_cores&gt; allows you to set number of
cores you want to use for one instance of GPT.

2) You can also specify the default number of cores to be used in
snap.userdir/etc/snap.properties file with line snap.parallelism =
&lt;number\_of\_cores&gt;.

When writing batch job script for GPT you can reserve multiple cores
like this:

`#SBATCH --cpus-per-task <number_of_cores> #SBATCH --mem <total amount of shared memory> #SBATCH --nodes 1 #SBATCH -p serial`

Note that while there is up to 16/24 cores available in Taito nodes
depending on node type, you should make sure that reserving additional
cores actually speeds up the processing.

**Plugins**

By default following plugins are installed in taito: Sentinel 1,2 and 3
toolboxes and SMOS toolbox. If further plugins are needed contact CSC at
<servicedesk@csc.fi>

**SNAPPY Python interface**

The snappy Python interface has been installed into a conda environment.
It can be loaded with following commands:

`module purgemodule load geoconda snapsource activate snappy6.0`

 

 

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

[SNAP usage][]  
[GPT usage][]  
[SNAP configuration]

------------------------------------------------------------------------

  [here]: https://research.csc.fi/taito-array-jobs
  [SNAP usage]: http://http://step.esa.int/main/doc/tutorials/
  [GPT usage]: https://senbox.atlassian.net/wiki/spaces/SNAP/pages/70503475/Bulk+Processing+with+GPT
  [SNAP configuration]: https://senbox.atlassian.net/wiki/spaces/SNAP/pages/15269950/SNAP+Configuration
