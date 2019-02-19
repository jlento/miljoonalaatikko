## Sen2cor

### Description

Sen2Cor is a processor for Sentinel-2 Level 2A product generation and
formatting.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.5.5

------------------------------------------------------------------------

### Usage

First load appropriate module.

`module load sen2cor`

module contains L2A\_Process binary which is used to run Sen2cor.

**Sen2cor Configuration in taito**

Sen2cor configuration directory is created when you first run the
L2A\_Process script at $HOME/.sen2cor/cfg. In this folder you will find
the L2A\_GIPP.xml file which is used to configure sen2cor. There are
also a few other configuration files such as L2A\_CAL\_AC\_GIPP.xml for
atmospheric correction in
/appl/earth/sen2cor/2.5.5/lib/python2.7/site-packages/sen2cor/cfg/. If
you wish to modify these settings create a copy of these files in your
$HOME/.sen2cor/cfg folder. It is also possible to speficy location of
these files at runtime. See L2A\_Process -h for details.

**Parallel processing**

Sen2cor supports parallel processing for products with more than one
tile. The number of processes is controlled by
&lt;Nr\_Processes&gt;AUTO&lt;/Nr\_Processes&gt; line in L2A\_GIPP.xml
file. By default this is set to AUTO, in which case what ever number of
cpus are available are used (4 in taito-shell and however many cores you
reserve in a batch job). If you wish to specify a spesific amount you
can do so by replacing AUTO with a number.

As sen2cor supports parallel processing only in shared memory
enviroinment you can reserve multiple cores in a batch job like this:

`#SBATCH --cpus-per-task <number_of_cores> #SBATCH --mem <total amount of shared memory> #SBATCH --nodes 1 #SBATCH -p serial`

Note that while there is up to 16/24 cores available in Taito nodes
depending on node type, you should make sure that reserving additional
cores actually speeds up the processing. Notably if your product only
has one tile reserving additional cores won't speed up processing.

 

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

[User manual]

------------------------------------------------------------------------

  [User manual]: http://step.esa.int/thirdparties/sen2cor/2.5.5/docs/S2-PDGS-MPC-L2A-SUM-V2.5.5_V2.pdf
