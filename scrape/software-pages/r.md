## R

### Description

R  is  a  free  software environment  for  statistical  computing  and
graphics.  The R language is  widely used among statisticians and data
miners for developing  statistical software and data  analysis. R also
provides  a wide  range  of tools  and methods  for  the analysis  and
comprehension  of next  generation  sequencing  (NGS), microarray  and
proteomics  data in  [Bioconductor]  packages.  For more  information,
see [CRAN's R Manuals] .

In Taito you can find the Rmpi-package, which provides an interface to
MPI APIs,  as well as foreach,  pbdMPI and of course  the base package
parallel.  These packages  allow you  to  run R  programs in  parallel
across multiple processors and to  accomplish a goal more quickly than
running a single program on one machine.

Taito also includes  RStudio which<span class="st"> is  a powerful and
productive graphical user  interface for R. To  use RStudio</span> you
must have a graphical connection to the server. The recommended way is
to use [NoMachine remote desktop]

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito:

-   2.15.3
-   3.0.0
-   3.0.1
-   3.0.2
-   3.1.0
-   3.1.1
-   3.1.2
-   3.2.1
-   3.2.2
-   3.2.3
-   3.2.5
-   3.3.1
-   3.3.2
-   3.4.1
-   3.4.3
-   3.5.0 (default)

------------------------------------------------------------------------

### Usage

In Taito  and Taito-shell, to load  the latest installed version  of R
use the following command:

`module load r-env`

To load the  module with support for spatial libraries  such as rgdal,
RSAGA, rgrass7 etc. use [rspatial-env] instead:

`module load rspatial-env`

Please note that execution of the command unloads all currently loaded
modules. Thus,  if your  R session depends  on some  atypical modules,
these need to be loaded after loading the R module.

To use a specific version use a command like this instead:

`module load r-env/x.y.z`

where x.y.z is replaced by the version number wanted.

### Interactive use {#yui_patched_v3_11_0_1_1435310747621_978 style="text-align: justify;"}

The recommended way to use R interactively (without RStudio) is to run
the session  on Taito-shell. After  logging to Taito-shell load  the R
module as explained above and start the R session simply by typing

`R`

For RStudio  it is recommended  to use [NoMachine remote  desktop]. To
use RStudio this  way first log in to NoMachine  remote desktop, right
click in the NoMachine desktop to bring up the Fluxbox menu and choose
Applications &gt;  Taito-shell &gt;  Mathematics &gt; RStudio,  or GIS
&gt; RStudio for GIS. You will  then be prompted for your CSC password
and after giving  it, RStudio will start. Alternatively  you can start
RStudio manually  by choosing CSC  local servers &gt;  Taito-shell and
after giving your CSC password, typing

    module load r-env
    module load rstudio
    rstudio

This is necessary  if you also need  to use some other  R version than
the default, or some additional modules etc.

You can run R without RStudio  on NoMachine remote desktop as well, by
typing

    module load r-env
    R

instead, after connecting to Taito-shell as above.

An alternative  way is  to request  an interactive  job directly  in a
computing node on Taito. Note  that getting resources may take minutes
or hours  this way,  so using  Taito-shell is  almost always  a better
solution.   Once  the  module  has  been loaded,  you  can  launch  an
interactive   single-processor   R   session   using   the   following
command. Please note that  you must set a limit on  the total run time
of the  job and that  the R session  will be terminated  once hh:mm:ss
time has exceeded.

`srun -n1 -t hh:mm:ss --x11=first --pty R`

An interactive multi-processor R session can in turn be launched using
one of the following two  commands (see below about parallel computing
for more details):

`srun -n5 -t hh:mm:ss --x11=first --pty Rmpi`

`srun -n5 -t hh:mm:ss --x11=first --pty RMPISNOW`

### Serial batch jobs {#serial-batch-jobs style="text-align: justify;"}

If you don't need to run interactively  and you need more than 4 cores
or a lot  of memory (over 120GB)  you can run your  R-scripts in batch
mode.  Below is sample batch job file for running a single-processor R
batch   job  in   Taito.   Example  files   are   also  available   at
<https://github.com/CSCfi/CSC-R-examples>.

    #!/bin/bash -l
    #SBATCH -J r_single_proc
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -p test
    #SBATCH -t 00:05:00
    #SBATCH --ntasks=1
    #SBATCH --nodes=1
    #SBATCH --mem-per-cpu=1000

    module load r-env
    srun Rscript --no-save myrscript.R

In the  batch job example above,  one task (-ntasks=1) is  executed in
the test queue (-p test). R  session will use one processor with total
of 1 GB of memory (--mem-per-cpu=1000).  The total run time of the job
is limited to five minutes (-t 0:05:00).

You  can submit  the  batch job  file  to the  batch  job system  with
command:

    sbatch batch_job_file.sh

For more details about the batch jobs see [Taito user guide].

### Parallel batch jobs {#parallel-batch-jobs style="text-align: justify;"}

There  are several  R  packages you  might want  to  use for  parallel
computing. In the following we explain  the use of Rmpi, parallel (the
parts adapted from  snow), foreach together with doMPI,  and pbdMPI on
Taito, but when using any of  them, please also read the corresponding
manuals and vignettes. With all of these packages the needed batch job
file  is   similar  up  to   the  execution  command,  and   is  shown
below.      Example     files      are      also     available      at
<https://github.com/CSCfi/CSC-R-examples>.

    #!/bin/bash -l
    #SBATCH -J r_multi_proc
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -p test
    #SBATCH -t 00:05:00
    #SBATCH --ntasks=8
    #SBATCH --nodes=1
    #SBATCH --mem-per-cpu=1000

    module load r-env

In this example, 8 processors  are reserved (--ntasks=8) from one node
(--nodes=1).  The  job  will will  use  a  total  of  8 GB  of  memory
(--mem-per-cpu=1000). The total run time of the job is limited to five
minutes (-t 00:05:00).

#### Rmpi {#rmpi style="text-align: justify;"}

Rmpi is  the low  level interface  from R  to the  MPI library  of the
system.  The  execution command that needs  to be added to  the end of
the batch job file given above is like this:

    srun Rmpi --no-save --slave -f myrscript.R

With this approach,  only the master process runs the  given R script,
and  the function  calls from  the  Rmpi package  are available.  The 
--slave  argument  is optional  and  will  prevent all  the  different
processes from printing out the  welcome message etc. Despite the term
it  has nothing  to do  with the  master-slave structure  of the  Rmpi
approach. Here is an example script:

    funtorun<-function(k) {
      system.time(sort(runif(1e7)))
    }

    system.time(a<-mpi.apply(1:7,funtorun))
    a

    mpi.close.Rslaves()

 

#### parallel (snow)

The  parallel package  is included  in  the base  installation and  is
derived from the  packages multicore (now discontinued)  and snow. The
MPI cluster  creation is handled by  snow, but any other  package that
depends  on the  parallel package  for handling  the cluster  (such as
runjags) should accept  those. The execution command that  needs to be
added to the end of the batch job file given above is like this:

    srun RMPISNOW --no-save --slave -f myrscript.R

Like with  Rmpi, only the  master process  continues to run  the given
script. The   --slave argument  is optional and  will prevent  all the
different processes  from printing  out the  welcome message  etc. The
script  should contain  a getMPIcluster  call which  will produce  the
reference to the cluster that can be given to various other functions,
like in this example:

    cl<-getMPIcluster()

    funtorun<-function(k) {
      system.time(sort(runif(1e7)))
    }

    system.time(a<-clusterApply(cl,1:7,funtorun))
    a

    stopCluster(cl)

#### foreach and doMPI

The foreach  package implements  a for-loop  that uses  iterators, and
also  allows for  parallel execution  using its  %dopar% operator.  It
comes with  several "parallel  backends", of  which the  doMPI pacakge
should be used on Taito. The  execution command that needs to be added
to the end of the batch job file given above is like this:

    srun Rscript --no-save --slave myrscript.R

Note that this  starts a number of  R sessions equal to  the number of
reserved cores that all start to execute the given script (unlike with
the Rmpi  and RMPISNOW above, where  only the master does  that). The 
--slave  argument  is optional  and  will  prevent all  the  different
processes from printing out the welcome message etc. The script should
include a call to startMPIcluster very  close to the beginning, as all
the processes will execute everything before that call, while only the
master continues after that call. An example:

    library(doMPI,quietly = TRUE)
    cl<-startMPIcluster()
    registerDoMPI(cl)

    system.time(a<-foreach(i=1:7) %dopar% system.time(sort(runif(1e7))))
    a

    closeCluster(cl)
    mpi.quit()

 

#### pbdMPI

TBA

 

### Installing packages

The simplest way to see if a needed package is installed is to try and
load it  with the  `library()` command.  For missing  package requests
please  contact   CSC's  Service   Desk  at  servicedesk   at  csc.fi.
Alternatively you can also install packages yourself using R command

    install.packages("pkgname")

in  an  interactive session  or  by  using RStudio's  menus.  Packages
installed this way will be stored in your home directory so in case of
large packages  and/or packages  you know  to be  in wider  use please
consider contacting the Service Desk.

### Removing packages

Sometimes version  conflicts crop  up between user  installed packages
and the  ones installed for  all. Usually the simplest way  to resolve
such  conflicts  is to  remove  the  user  installed ones  and  either
re-install them or request a system installation from Service Desk. To
see which paths R searches for packages , use

    .libPaths()

Usually this shows a list of two paths, one to user's on libraries and
the second to the system libraries.  In that case, to see the packages
installed by the user, use

    installed.packages(lib.loc=.libPaths()[1])

and to remove specific packages, use a command like

    remove.packages("name_of_package",lib=.libPaths()[1])

where  you  replace name\_of\_package  with  the  actual name  of  the
package.

#### More information {#yui_patched_v3_11_0_1_1435310747621_1027}

More information about  R and Bionconductor can be found  from the [R]
and [Bionconductor] home page.

------------------------------------------------------------------------

### Discipline

Mathematics and Statistics  

------------------------------------------------------------------------

### References

#### References {#yui_patched_v3_11_0_1_1435310747621_1075}

When you use  R, please cite. Please note  that corresponding citation
is available at R by typing *citation()*.

R  Development Core  Team (2008).  R: A  language and  environment for
statistical computing. R Foundation for Statistical Computing, Vienna,
Austria. ISBN 3-900051-07-0, URL http://www.R-project.org.

R  Core Team  (2013). R:  A language  and environment  for statistical
computing.   R   Foundation   for   Statistical   Computing,   Vienna,
Austria. ISBN 3-900051-07-0, URL http://www.R-project.org/.

If you use Bionconductor, please cite:

Gentleman RC,  Carey VJ, Bates  DM, Bolstad  B, Dettling M,  Dudoit S,
Ellis B,  Gautier L,  Ge Y, Gentry  J, Hornik K,  Hothorn T,  Huber W,
Iacus S, Irizarry R, Leisch F,  Li C, Maechler M, Rossini AJ, Sawitzki
G, Smith C,  Smyth G, Tierney L, Yang JY,  Zhang J. Bioconductor: open
software     development     for     computational     biology     and
bioinformatics. Genome biology 5.10 (2004): R80.

------------------------------------------------------------------------

### Support

helpdesk@csc.fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [Bioconductor]: https://research.csc.fi/-/bioconductor
  [CRAN's R Manuals]: http://cran.r-project.org/manuals.html
  [NoMachine remote desktop]: https://research.csc.fi/-/nomachine
  [rspatial-env]: https://research.csc.fi/-/rspatial-env
  [Taito user guide]: https://research.csc.fi/taito-user-guide
  [R]: http://cran.r-project.org/
  [Bionconductor]: http://www.bioconductor.org/
