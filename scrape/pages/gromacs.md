## Gromacs

### Description

Gromacs is a very efficient engine to perform molecular dynamics simulations and energy minimization particularly for proteins. However, it can also be used to model polymers, membranes and e.g. coarse grained systems. It also comes with plenty of analysis scripts.

* * *

### Available

##### Version on CSC's Servers

Sisu,Taito: 4.6.7, 5.1.5, 2016.x, 2018.5

Taito-GPU: 5.1.5, 2016.5, 2018.3 (NOTE: Don't use GPU versions 2018.1 or 2018.2, see [link](http://manual.gromacs.org/documentation/2018.3/release-notes/2018/2018.3.html))

Check available versions with     module avail gromacs

The 5.1.5 (Taito) and 2016.3/4, 2018.5 (non-GPU) versions also include plumed

Note, Gromacs versions with the hsw (Haswell) tag won't run on the login node, but give better performance on Haswell compute nodes. For preparing jobs (gmx grompp, etc.) use the snb modules on the login node, but the appropriate version in your batch script. The same applies also for GPU enabled versions. Some modules have only mdrun\_mpi for parallel runs. See output of module command whether to use     gmx_mpi mdrun or     mdrun_mpi.

* * *

### Usage

To start working with Gromacs in Sisu use the module command:

    module load gromacs/**version**

In Taito use

    module load gromacs-env/**version**

Omitting version will initialise the default version which will change when bugs are fixed or new versions are accepted stable. Version 2016.5 is currently the default.  
  
Gromacs is also available on the Finnish Grid Infrastructure (FGI).  Please see below for the example on how to run Gromacs on the [FGI](https://confluence.csc.fi/display/fgi/FGI+User+Pages).

### Examples

The batch submission is different on all machines. Please consult the server manuals or the examples at the bottom of the page.  
Examples of Gromacs 4 jobs on the [FGI](https://confluence.csc.fi/display/fgi/GROMACS+4.5.5+runtime+environment).

### Other versions

You can check for other versions with the command **module avail** or **module spider** on Taito  
  
After initialisation you can check, e.g. with

    which gmx

which shows where the code lives and hints how to modify the batch script initialisation.

### Which version to use?

We recommend using the latest versions as they have most bugs fixed and tend to be faster. If you switch the major version, check that the results are comparable. See below for a brief performance test using the d.dppc system (~100k atoms, PME). Note, that the 2018.1 version is more than 50% faster than 4.6.7 and likely scales better to large number of cores. However, remember always to test scaling for your own systems to select the right number of cores to use.

 

(Node archictecture / Code optimization to)

cores

gmx 4.5.6

gmx 4.6.7

gmx 5.1.5

gmx 2016.5

gmx 2018.1

Taito

Hsw/Hsw

48

\-

\-

45.505

48.407

49.369

Taito

Hsw/Snb

48

21.523

21.9

38.953

40.987

41.318

Taito

Snb/Snb

48

20.694

20.513

28.559

34.958

39.906

Sisu

Hsw/Hsw

48

\-

30.104

39.935

48.979

49.624

Sisu

Hsw/Hsw

96

\-

62.499

80.769

86.638

96.194

Taito-gpu

k80:1/Hsw

6

\-

\-

\-

23.964

27.18

Taito-gpu

p100:1/Hsw

7

\-

\-

\-

31.703

55.041

Taito-gpu

p100:4/Hsw

28

\-

\-

\-

\-

62.868

The second column indicates which Node architecture was used (first part) and which code optimizations were used (second). For example, the last line means that four P100 GPGPU cards were used (and on the next column that for each 7 CPU cores were allocated). The performance numbers are in ns/day i.e. more is better.

From the table you can see, that or this system 1) the Haswell optimized Gromacs on Haswell Nodes is 15-20% faster than Sandby Bridge optimized Gromacs on  Haswell node, 2) on Taito Sandy bridge nodes version 2018.1 is twice as fast as 4.6.7, 3) it does not make sense to use 4 GPGPU-cards as the speedup compared to using one is only 1.14 fold (while it should be close to 4).

### Visualising trajectories

In addition to ngmx program in Gromacs, trajectory files can be visualized with the following programs:

*   [PyMOL](http://www.pymol.org/) molecular modeling system.
*   [VMD](http://www.ks.uiuc.edu/Research/vmd/) visualizing program for large biomolecular systems.

### Visualising XY-plots

Gromacs tools produce output files made for the Grace program. These data can be visualized with program Grace. To start working with Grace, issue the command:

    module load grace

To plot all energy components in the energy.xvg file give:

    xmgrace -nxy energy.xvg

### Examples and links

*   A very useful [performance checklist](http://www.gromacs.org/Documentation/Performance_checklist) for finding the right run parameters
*   My first Gromacs simulation - [simple input example](/documents/48467/73376/Sample+Gromacs+input+for+Taito/79a22332-1cc5-4964-9515-ec1faccbfb8c "Sample gromacs input files")
*   A list of Gromacs [tutorials on the Gromacs website](http://www.gromacs.org/Documentation/Tutorials)
*   [The Dundee PRODRG Server](http://davapc1.bioch.dundee.ac.uk/prodrg/) for converting coordinates for small molecules to the Gromacs coordinate (only .gro format available) and topology formats.
*   [HOW-TO](http://www.gromacs.org/Documentation/How-tos)s at the Gromacs web site

* * *

### Discipline

Biosciences  
Chemistry  

* * *

### References

Please cite the following papers:

*   GROMACS 4: Algorithms for Highly Efficient, Load-Balanced, and Scalable Molecular Simulation. Hess, B., Kutzner, C., van der Spoel, D. and Lindahl, E. J. Chem. Theory Comput., 4, 435-447 (2008).
*   GROMACS: Fast, Flexible and Free. D. van der Spoel, E. Lindahl, B. Hess, G. Groenhof, A. E. Mark and H. J. C.Berendsen, J. Comp. Chem. 26 (2005) pp. 1701-1719
    

* * *

### Support

* * *

### Manual

*   [Lots of material and e.g. webinars from the BioExcel EU project](http://bioexcel.eu/software/gromacs/)
*   [Slides and exercise material for Gromacs 5 workshop at CSC, 11/2015](https://www.csc.fi/web/training/-/gromacs-5)
*   [http://www.gromacs.org/Documentation/Performance\_checklist](http://www.gromacs.org/Documentation/Performance_checklist)
*   Tutorials [updated for version 5.0](http://www.bevanlab.biochem.vt.edu/Pages/Personal/justin/gmx-tutorials/)
*   Gromacs developers [www-pages](http://www.gromacs.org/)
*   A very useful Gromacs Users [Mailing list](http://www.gromacs.org/Support/Mailing_Lists/Search)
*   If you want to compile your own version, have a look at the options used in the CSC installations. The cmake -files can be found in the installation directories (which gmx ...)

* * *