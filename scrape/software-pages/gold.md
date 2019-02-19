## GOLD

### Description

GOLD is a docking program for predicting how flexible molecules will
bind to proteins. GOLD uses a genetic algorithm methodology for
protein-ligand docking and allows full ligand and partial protein
flexibility.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito-shell: 2018
-   [DiscoveryStudio 2018 server]

------------------------------------------------------------------------

### Usage

### License

GOLD is part of the Cambridge Crystallographic Database System. See our
[CSD page for licensing information].

GOLD can be used either from the command line or via a graphical user
interface (GUI). The best way to run a GUI remotely is to use the
[NoMachine Remote Desktop service] available for CSC users. To set up
the GOLD interactive environment:

`module load ccdc `

This will load the latest version of GOLD. The easiest way to run
interactive jobs is to log in to taito-shell and start gold with the
command `gold`. If you want dedicated interactive resources, you start
interactive session on a compute node, type:

`salloc -p serial -n 1 -t 02:00:00 srun --x11=first xterm `

Launch the gold command in the xterm. Longer jobs are best run as batch
jobs, see below.  
 

**NOTE:** Gold license now covers unlimited simultaneous jobs.

The PVM daemon must be running before parallel GOLD dockings can be
started. After docking, the PVM daemon should be stopped and all its
generated files removed. In principle it is possible to run several
docking jobs simultaneously, but if two PVM jobs run on the same node,
problems might arise

[This example job script] is for a serial job. Submit it on Taito with:

`sbatch job-gold2016-taitoser.job `

[This example job script][1] would start a job on 4 CPU's.

`sbatch job-gold2016-taitopar.job `

### Usage via Discovery Studio or Maestro

GOLD is available in  the Discovery Studio 2018 server and Maestro at
CSC. This GOLD installation can be used with locally installed
[Discovery Studio] molecular modeling program, but to use with locally
installed Maestro, you need to install GOLD locally also.

####  

------------------------------------------------------------------------

### Discipline

Biosciences  
Chemistry  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

-   [The GOLD homepage]
-   [GOLD online documentation]

------------------------------------------------------------------------

  [DiscoveryStudio 2018 server]: http://dstudio18.csc.fi:9944/DS/
  [CSD page for licensing information]: https://research.csc.fi/-/csd
  [NoMachine Remote Desktop service]: http://research.csc.fi/-/nomachine
  [This example job script]: http://extras.csc.fi/chem/progs/gold/job-gold2016-taitoser.job
  [1]: http://extras.csc.fi/chem/progs/gold/job-gold2016-taitopar.job
  [Discovery Studio]: https://research.csc.fi/-/discoverystudio
    "Discovery Studio at CSC"
  [The GOLD homepage]: http://www.ccdc.cam.ac.uk/solutions/csd-discovery/components/gold/
  [GOLD online documentation]: http://www.ccdc.cam.ac.uk/support-and-resources/ccdcresources/gold.pdf
