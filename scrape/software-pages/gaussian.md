## Gaussian

### Description

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito: g16.RevA.03
-   Taito: g09.RevE.01

------------------------------------------------------------------------

### Usage

**To be able  to use Gaussian at  CSC your user-id has to  be added to
Gaussian  users   group.**  Send  a   request  to  CSC   Service  Desk
, servicedesk@csc.fi .

Prepare the input file **jobname.com**

The [input file] specifies the following:

-   [The job type]
-   [The method]
-   [The basis sets]
-   [Electronic state and structure]

For  optimal performance  of  Gaussian  jobs on  CSC's  servers it  is
beneficial to make some efficiency considerations.

Some hints  on how  to estimate  memory and  disk requirements  can be
found [here.]

Especially the  [%mem][here.] and [MaxDisk] parameters are important.

**Submit the Gaussian job**

On Taito

The  [Gaussian] version is selected by the command:

`module load gaussian/G16RevA.03`

`module load gaussian/G09RevE.01     `

Taito    is   available    for    serial    and   parallel    Gaussian
runs. **IMPORTANT:**  All files needed  by a job  must be copied  to a
folder under  $WRKDIR. Jobs  are conveniently  submitted by  using the
subg16/subg09 script:

`subg16 12:00:00 h2o (do subg16 -h for more info on how to use it)`

`subg09 12:00:00 h2o (do subg09 -h for more info on how to use it)`

It is suggested  to use either one  core or a full node.  Taito has 24
cores per node. If you want to  use more than one core you can request
it by  adding the %Nproc card  into your com-file, like  %Nproc=24. If
you use a complete node please  don't reserve all its memory with %mem
but leave about 4GB of memory for the actual program and the OS.

On Taito-shell

Taito-shell is  available especially  for short  serial Gaussian runs.
Please run long and parallel jobs on Taito.

First setup the gaussian environment:

`module load gaussian/G16RevA.03`

Then launch a job with an input file test.com:

`g16 test &`  
  
**Note:**  The job is terminated when  logged out.  For more info, see
[Taito-shell User Guide.]

------------------------------------------------------------------------

### Discipline

Chemistry  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

<http://gaussian.com/man/>

------------------------------------------------------------------------

  [input file]: http://gaussian.com/input/
  [The job type]: http://gaussian.com/capabilities/?tabid=1
  [The method]: http://gaussian.com/capabilities/?tabid=0
  [The basis sets]: http://gaussian.com/basissets/
  [Electronic state and structure]: http://gaussian.com/molspec/
  [here.]: http://gaussian.com/running/?tabid=3
  [MaxDisk]: http://gaussian.com/maxdisk/
  [Gaussian]: http://gaussian.com/techsupport/
  [Taito-shell User Guide.]: https://research.csc.fi/taito-shell-user-guide
