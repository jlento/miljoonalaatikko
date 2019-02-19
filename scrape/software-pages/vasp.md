## VASP

### Description

[VASP] is a popular ab initio program used to calculate electronic
structure of nanostructures up to few hundreds of atoms. CSC provides
user support for the effective usage, compilation and running, of VASP
on CSC's machines. The usage of VASP requires a license, which must be
acquired directly from the developers of the software.

Precompiled VASP version 5.3.5 and 5.4.1 binaries are available
in sisu.csc.fi and taito.csc.fi machines through module environment.
License for VASP version 4.6 does not cover the version 5.

The performance optimization for large experiments should be done per
case basis. For performance optimization, please contact CSC via
servicedesk@csc.fi.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Sisu: 5.3.5, 5.4.1
-   Taito: 5.3.5, 5.4.1

------------------------------------------------------------------------

### Usage

CSC provides executable binaries for VASP. The usage requires a valid
VASP 5 license. Please send your VASP 5 license agreement number to
servicedesk@csc.fi to get permission to access the binaries.

Currently available vasp modules can be listed with

`module avail vasp`

and information about them with

    module show vasp/5.4.1
    module help vasp/5.4.1

for example.

These modules only set VASP\* environment variables pointing to relevant
directories. They do not modify PATH.

#### Building VASP 5.3.5+ on sisu.csc.fi and on taito.csc.fi

The CSC's prebuild binaries can be taken as reference builds, and/or a
basis for further optimizations. In projects using large amount of CPU
resources we recommend compiling optimized executables for the specific
project. In sisu, for example, setting the pagesize larger than default
may be beneficial. Please see the file /appl/nano/vasp/README, or
/appl/nano/vasp/&lt;version&gt;/README on the computing servers for
documentation on how the CSC's reference ("vanilla" 5.4.1) binaries were
build.

#### Optimal runtime parameters

Optimal parameters, the number of processors and the parameters in
the `INCAR` file depend on the  studied system. In general:

-   In large cell calculations setting LREAL = Auto in INCAR reduces
    computation time considerably.
-   The NCORE/NPAR parameter value needs to be tested to find the
    optimal value. In general, setting NCORE=8 is a good starting point.

 Please report back any problems encountered <span
class="st">–</span> or if you find beneficial optimizations beyond -O2.

------------------------------------------------------------------------

### Discipline

Chemistry  
Physics  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [The VASP site] (documentation, forum, FAQs, etc.)
-   [Study of performance optimization for VASP] (see
    the `NPAR` parameter especially)

------------------------------------------------------------------------

  [VASP]: https://www.vasp.at
  [The VASP site]: https://www.vasp.at/
  [Study of performance optimization for VASP]: http://www.hector.ac.uk/cse/distributedcse/reports/vasp01/vasp01_collectives/
