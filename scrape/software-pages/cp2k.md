## CP2K

### Description

Versatile ab initio and classical molecular dynamics.

CP2k is suited for large parallel quantum chemistry calculations, in
particular for AIMD.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.4, 2.5, 4.1

Sisu: 2.6, 3.0, 4.1, 5.1

------------------------------------------------------------------------

### Usage

Check which versions are available:

    module avail cp2k

In your batch script, give:

    module load cp2k/2.5-version

Loading the module points you to the installation directory, which has
example submit commands for different parallelization schemes. Before
each project make sure that your job can utilize all the cores you
request in the batch script!

[Examples for running cp2k in Sisu]

[Examples of running cp2k on Taito]

------------------------------------------------------------------------

### Discipline

Chemistry  
Physics  

------------------------------------------------------------------------

### References

CP2K prints out a list of relevant publications towards the end of the
log file. Choose ans cite the ones relevant to the methods you've used.

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

CP2K online manual: <http://manual.cp2k.org/>

CP2K home page: <http://www.cp2k.org/>

------------------------------------------------------------------------

  [Examples for running cp2k in Sisu]: https://research.csc.fi/-/cp2k-sisu-example
  [Examples of running cp2k on Taito]: https://research.csc.fi/-/cp2k-taito-example
