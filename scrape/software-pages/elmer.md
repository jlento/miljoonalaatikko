## Elmer

### Description

[Elmer]  is an  open source  multiphysical simulation  software mainly
developed by  [CSC-IT Center for  Science Ltd.] (CSC).  Elmer includes
physical   models    of   fluid   dynamics,    structural   mechanics,
electromagnetics,  heat  transfer  and   acoustics,  for  example.  An
additional  add-on  module  to Elmer  for  glaciological  (ice-sheets,
glaciers)  flow  simulations,  [Elmer/Ice]  is  installed  within  the
package.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 8.0

Sisu: 8.0

------------------------------------------------------------------------

##### Versions for Workstations

8.0 release

and devel version

------------------------------------------------------------------------

### Usage

#### Setup in taito.csc.fi: {#setup-in-taito.csc.fi style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

Easiest way is to  set up the latest Elmer version  in one swipe using
the  command `module load elmer-env/latest`

This loads the latest delopment version installed. We also provide the
latest   release  version   (from   the  frozen   release  branch   of
github). This can be loaded using `module load elmer-env/release`

Mind,  that  this  changes  a   lot  of  settings  for  other  modules
automatically, which is reported on the screen:

`----------------------------------------------------------------------------
  Setting  up new environment,  removing all currently  loaded modules
----------------------------------------------------------------------------
   Loading  new   modules:       intel/13.1.0       trilinos/11.0.3   
hdf5-par/1.8.10     intelmpi/4.1.0    hypre/2.9.0b       netcdf4/4.3.0
          mkl/11.0.2             mumps/4.10.0             elmer/latest
#################################### Elmer  1d71632 environment loaded
date: Apr 30  09:47 EEST 2015 this version includes  Elmer/Ice In case
of problems: zwinger@csc.fi ####################################`

If one wants to manually load the prerequisite modules first, then the
command that  loads to latest  version of Elmer would  be `module load
elmer/latest`

#### Setup in sisu.csc.fi: {#setup-in-sisu.csc.fi style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

In contrary to taito, in sisu one has to take care to load the correct
environment. The  standard version of  Elmer on sisu is  compiled with
the  GNU compiler  suite.  The latest  updated  version hence  demands
swapping to this environment

`module swap PrgEnv-cray/5.2.56 PrgEnv-gnu/5.2.56`

Thereafter, the user can load the missing modules giving the command

`module load elmer/latest`

Mind that the following modules are loaded automatically:

`cray-tpsl/1.5.0 cray-libsci/13.0.4`

The output

~~~~
 Elmer revision da95850 (devel including elmerice) loaded.
 Compiled with PrgEnv-gnu/5.2.56
     at Fri Jun 12 12:23 EEST 2015
~~~~

again shows the  date of compilation in order to  compare, whether the
self-compiled functions need an update or not.

#### Submitting a serial Elmer job on taito: {#submitting-a-serial-elmer-job-on-taito style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

The   following  contents   written   into  a   file,  for   instance,
elmer\_serial.sh

~~~~
#!/bin/bash -f
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J NameOfRun
#SBATCH -o Outputfile.%j
#SBATCH -e Errorfile.%j
#SBATCH --mem-per-cpu=200
#SBATCH -p serial
#SBATCH --ntasks-per-node=1
srun ElmerSolver NameOfInputfile.sif 
~~~~

is submitted  from within the  directory where all input  files reside
(else the user should ad a cd-command within the job-srcipt) by

`sbatch elmer_serial.sh`

It reserves  one core  and 200  MB RAM  for a  duration of  maximum 30
minutes. The output  and error files are appended  with the job-number
(%j in the script).

#### Submitting a parallel Elmer job on taito: {#submitting-a-parallel-elmer-job-on-taito style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

The following script launches a 48 core run using 2 GB RAM/core.

~~~~
#!/bin/bash -f
#SBATCH -n 48
#SBATCH -t 01:00:00
#SBATCH -J NameOfRun
#SBATCH -o OutputFile.%j
#SBATCH -e ErrorFile.%j
#SBATCH --mem-per-cpu=2000
#SBATCH -p parallel
cd /wrk/userid/yourdirectory
echo  NameOfInputFile.sif > ELMERSOLVER_STARTINFO
srun ElmerSolver_mpi
~~~~

In contrary to a serial run,  one cannot provide the solver input file
name as an  argument, but rather has  to provide it via  a file called
ELMERSOLVER\_STARTINFO.

#### Submitting a parallel Elmer job on sisu: {#submitting-a-parallel-elmer-job-on-sisu style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

<span style="color:  rgb(85, 85, 85); font-family:  Arial, sans-serif;
font-size:  14px; line-height:  20px;">On sisu.csc.fi,  complete nodes
are  reserved. Each  run  utilizes  N nodes  with  P processors,  each
containing C cores. Hence the per node  available core number is P x C
and, consequently the complete number of available cores N x P x C. In
sisu, currently  we have  2 processors  (P=2) with  12 cores/processor
(C=12)  on each  node.  For  instance, a  run  with  96 partitions  is
allocated using N=4 nodes (4 x 2 x 12=96). As Elmer currently does not
support multi-threading,  we ensure that  only one thread per  core is
launched by adding the option -j 1 to the aprun command.</span>

~~~~
#!/bin/bash -f
#SBATCH -N 4
#SBATCH -t 01:00:00
#SBATCH -J NameOfRun
#SBATCH -o OutputFile.%j
#SBATCH -e ErrorFile.%j
#SBATCH -p small
(( ncores = SLURM_NNODES * 24 ))
cd /wrk/userid/yourdirectory
echo  NameOfInputFile.sif > ELMERSOLVER_STARTINFO
aprun -j1 -n $ncores ElmerSolver_mpi 
~~~~

Check with sinfo command on  the configuration of the queues (declared
at the -p option  in the script). The minimum amount  of used nodes on
sisu-queues (except test  queue) is N=3, which means  that no parallel
production  runs with  Elmer below  72 partitions  (=3 x  2 x  12) are
possible.

#### More information {#more-information style="margin: 10px 0px; padding: 0px; line-height: 20px; font-size: 17.5px; font-family: Arial, sans-serif; color: rgb(85, 85, 85); text-rendering: optimizeLegibility;"}

-   [Elmer homepage] at CSC
-   [elmerfem.org (Elmer-web)]
-    <span  id="yui_patched_v3_11_0_1_1448012335596_2374">[Elmer  Wiki
    (on elmerfem.org)]</span>
-   [Elmer Funet.nic download]
-   [elmerice.elmerfem.org (Elmer/Ice homepage)]

------------------------------------------------------------------------

### Discipline

Computational Engineering  
Geosciences  
Mathematics and Statistics  
Physics  

------------------------------------------------------------------------

### References

For the Elmer/Ice module, the corresponding reference would be:

Gagliardini, O., T. Zwinger, F.  Gillet-Chaulet, G. Durand, L. Favier,
B.   de  Fleurian,  R.  Greve,  M.  Malinen,  C.  Martín,  P.  Råback,
J.   Ruokolainen,  M.   Sacchettini,  M.   Schäfer,  H.   Seddik,  and
J.  Thies,  2013.  *Capabilities   and  performance  of  Elmer/Ice,  a
new-generation  ice   sheet  model*,   Geosci.   Model   Dev.,  **6**,
1299-1318, doi:10.5194/gmd-6-1299-2013. [\[link to paper\]]

------------------------------------------------------------------------

### Support

Best  place  to   get  (or  even  search  for   existing)  answers  to
Elmer-related problems is the Elmer  Forum on elmerfem.org. In case of
problems with  Elmer installations  on sisu and  taito, please  send a
mail to  servicedesk\[at\]csc\[dot\]fi Personal inquiries may  be sent
to elmeradm\[at\]csc\[dot\]fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [Elmer]: http://research.csc.fi/web/elmer
  [CSC-IT Center for Science Ltd.]: http://www.csc.fi
  [Elmer/Ice]: http://elmerice.elmerfem.org [Elmer homepage]: http://research.csc.fi/web/elmer "Elmer" [elmerfem.org (Elmer-web)]: http://elmerfem.org/ [Elmer Wiki (on elmerfem.org)]: http://www.elmerfem.org/elmerwiki/index.php?title=Main_Page [Elmer Funet.nic download]: http://www.nic.funet.fi/pub/sci/physics/elmer/ [elmerice.elmerfem.org (Elmer/Ice homepage)]: http://elmerice.elmerfem.org/ [\[link to paper\]]: http://www.geosci-model-dev.net/6/1299/2013/gmd-6-1299-2013.html
