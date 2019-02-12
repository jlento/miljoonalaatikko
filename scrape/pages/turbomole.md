## Turbomole

### Description

TURBOMOLE is a program package for electronic structure calculations. Methods include DFT, HF, MP2 and CC2. Properties both for ground and excited states can be obtained. TURBOMOLE has been designed for efficient study of large systems.

* * *

### Available

##### Version on CSC's Servers

*   Taito: 7.21, 7.3

[New features and improvements for 7.3](http://www.turbomole-gmbh.com/release-notes.html)

* * *

### Usage

In order to set the interactive TURBOMOLE environment  issue the  command:

    module load turbomole/7.3

If you want to use the TmoleX GUI on Taito you  can run it on a compute node

    salloc -p serial -n 1 -t 02:00:00 srun --x11=first TmoleX

For other ways of using it, see our [TmoleX pages](https://research.csc.fi/-/tmolex)

**OpenBabel** supports the TURBOMOLE coord format.  The babel environment is set by

    module load openbabel

and  the program is called by 'babel'.  Do ' babel -H' for more information.

**Parallel runs**

Most of the TURBOMOLE modules are parallelized either by MPI or SMP. MPI versions can be run over several nodes whereas the SMP parallized rely on a shared memory environment and hence must be executed within a single node.** At present the modules aoforce, escf and egrad can only be run parallel in SMP mode.** For more information, please read the section ["Parallel Runs"](http://www.turbomole-gmbh.com/manuals/version_7_3/DOK/DOKse9.html#x16-220003.2) in the manual.

Taito

Sample job script [job-tm73-taito.job](https://extras.csc.fi/chem/progs/turbomole/job-tm73-taito.job) for **Taito.**  
  
Submit the job with:

    sbatch job-tm73-taito.job

For disk I/O intensive jobs it's recommended to use the local disks on **Taito** for scratch. 

**Parallel NumForce runs**

To obtain numerical vibrational spectra efficiently with the NumForce program, you can run the program in parallel. There is a slight difference to normal parallel runs, however, as you want to start many parallel _single_\-CPU calculations. The following example scripts  for  **Taito ** starts a parallel jobex calculation followed by a parallel NumForce calculation:

*   jobex + NumForce job file [job-tm73-taitoNF.job](http://extras.csc.fi/chem/progs/turbomole/job-tm73-taitoNF.job)

* * *

### Discipline

Chemistry  

* * *

### References

Please quote the usage of the program package under consideration of the version number:

  

* * *

TURBOMOLE V7.3 2018, a development of University of Karlsruhe and

Forschungszentrum Karlsruhe GmbH, 1989-2007,

TURBOMOLE GmbH, since 2007; available from

http://www.turbomole.com.

* * *

Scientific publications require proper citation of methods and procedures employed. The output headers of TURBOMOLE modules include the relevant papers. [See the on-line documentation for further instructions.](http://www.turbomole-gmbh.com/manuals/version_7_3/DOK/DOK.html)

* * *

### Support

* * *

### Manual

The manual is available in different formats:

*   [PDF format](http://www.cosmologic-services.de/downloads/TM73-documentation/TM73-documentation.pdf)
*   [HTML format](http://www.turbomole-gmbh.com/manuals/version_7_3/DOK/DOK.html)

#### More information

*   Additional information can be found at the [TURBOMOLE homepage](http://www.cosmologic.de/turbomole.html)
*   [Manuals and Tutorials](http://www.cosmologic.de/turbomole/support-download/documentation-how-to.html)

*   **A tutorial** is available:
    *   [Tutorial (PDF)](http://www.turbomole-gmbh.com/manuals/version_6_6/Turbomole_Tutorial_6-6.pdf)
*   **Notes **from the course "[_Molecular electronic excitations with Turbomole_](http://www.csc.fi/english/csc/courses/archive/tm-10)"
    *   [PDF](http://extras.csc.fi/chem/courses/tm-2010/CSC_course_140110.pdf)

*   **Notes** from the course "Introduction to TURBOMOLE" are also available: The notes also give an introduction in how to visualize results using [gOpenMol](http://www.csc.fi/gopenmol).
    *   [PDF](http://extras.csc.fi/chem/progs/turbomole/turbocourse.pdf)
    *   [Postscript](http://extras.csc.fi/chem/progs/turbomole/turbocourse.ps).
*   [TURBOMOLE 5.8 ja uudet ominaisuudet](http://extras.csc.fi/chem/progs/turbomole/atCSC-0106-7-10.pdf) (PDF). From [@CSC, 1/2006](http://www.csc.fi/csc/julkaisut/atcsc/edelliset_numerot/atcsc1_06).
*   **Users forum **is available for discussion:
    *   [TURBOMOLE Forum](http://www.turbo-forum.com/)

#### Licensing restrictions

*   You may use the Software exclusively for non-profit research purposes.
*   Only users from academic (i.e. degree-granting) institutes are allowed to use the Software

* * *