## NWChem

### Description

NWChem provides many different methods to compute the properties of molecular and periodic systems using standard quantum mechanical descriptions of the electronic wavefunction or density. In addition, NWChem has the capability to perform classical molecular dynamics and free energy simulations. These approaches may be combined to perform mixed quantum-mechanics and molecular-mechanics simulations.

* * *

### Available

##### Version on CSC's Servers

*   Sisu: 6.8
*   Taito: 6.8

* * *

### Usage

First, you need to prepare an input file for your job. Some examples can be found [in the NWChem manual.](http://www.nwchem-sw.org/index.php/Release65:NWChem_Documentation)  
Additional examples can be found on Sisu under the directory

    /appl/chem/nwchem/QA/  
    /appl/chem/nwchem/examples

The input file has to be run via the queue system of the computer as described below.

**Sisu and Taito**

Sample [job-nwchem68-sisu.job](http://extras.csc.fi/chem/progs/nwchem/job-nwchem68-sisu.job) for Sisu.

Sample [job-nwchem68-taito.job](http://extras.csc.fi/chem/progs/nwchem/job-nwchem68-taito.job) for Taito.

  
Submit the job with:

    sbatch  job-nwchem68-sisu.job (sbatch job-nwchem68-taito.job )

* * *

### Discipline

Chemistry  

* * *

### References

Please cite the following reference when publishing results obtained with NWChem:

M. Valiev, E.J. Bylaska, N. Govind, K. Kowalski, T.P. Straatsma, H.J.J. van Dam, D. Wang, J. Nieplocha, E. Apra, T.L. Windus, W.A. de Jong, "NWChem: a comprehensive and scalable open-source solution for large scale molecular simulations" Comput. Phys. Commun. 181, 1477 (2010).

* * *

### Support

* * *

### Manual

**Manual**

[HTML on-line](https://github.com/nwchemgit/nwchem/wiki)

#### More information

*   [The NWChem homepage](http://www.nwchem-sw.org/index.php/Main_Page)
*   [NWChem Community forums](http://www.nwchem-sw.org/index.php/Special:AWCforum)

* * *