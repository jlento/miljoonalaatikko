# 4.3 Batch jobs {#batch-jobs .western}

CSC uses batch job systems to  execute computing tasks in clusters and
supercomputers. Batch job systems are essential for effective usage of
large computing  servers. First  of all, batch  job system  takes care
that the  server does not get  overloaded: The users can  submit large
amounts  of  jobs to  be  executed  and  the  batch job  system  takes
automatically care that  optimal number of submitted  jobs are running
while  rest of  the jobs  are queuing  until sufficient  resources are
available.  Further, most  of batch  job systems  have a  "fair share"
functionalities that  take care that, on  the long run, all  the users
get equal possibilities to use resources.  For example in a case where
user *A* has submitted 1000 jobs  before user *B* submits his job, the
user *B* don't  have to wait that  all the jobs of user  *A* have been
processed. In stead, the batch job system gives higher priority to the
job of  user *B* compared  to user *A*, as  user *A* is  already using
much more computing resources that user *B*.

When batch  job system is  used, the commands  to be executed  are not
started immediately  like in  normal interactive  usage. In  stead the
user  creates  a   file  that  contains  the  Linux   commands  to  be
executed. This command file is  typically a Linux script (see [chapter
2.7].). In  addition to the  execution commands this *batch  job file*
normally contains information  about the resources that  the job needs
(for example: required computing time, memory and number of cores).

The file is  submitted to the batch job system  with a *job submission
command*.  After  that  the  batch  job  system  checks  the  resource
requirements of the  job, sends to job to a  suitable queue and starts
the job  when sufficient resources  are available. If the  job exceeds
the requested results (e.g. requires more computing time than what was
requested) the batch  job system kills the job.  After job submission,
user can follow the progress of the job or cancel the job if needed.

In this  guide we  provide introduction to  the *SLURM*  (Simple Linux
Utility for Resource Management System)  batch job system that is used
in Sisu  supercomputer and  Taito supercluster.  There are  many other
batch job schedulers too like *Sun Grid Engine* (SGE) or *Load Sharing
Facility* (LSF)  that are not available  in the computers of  CSC. The
*ARC middleware*, that is used in the FGI grid, can be considered as a
kind  of batch  job system  too. The  ARC middleware  is available  on
Taito. ARC instructions can be found form the [FGI User Guide].

It is also possible to  run interactive batch jobs. No computationally
intensive jobs should be run on the login nodes. The Taito Guide has a
[few examples].

## [][1]4.3.1 Constructing SLURM batch job files {#constructing-slurm-batch-job-files .western}

The most  common way  to use the  SLURM batch job  system is  to first
create a  *batch job  file* that  is submitted  to the  scheduler with
command ***sbatch***. You can create  batch job files with normal text
editors or  you can  use the  *Batch Job Script  Wizard* tool,  in the
Scientist's                       User                       Interface
(<https://sui.csc.fi/group/sui/batch-job-script-wizard>,  see **Figure
4.2**). In  the Batch Job Script  Wizard, you first select  the server
you want to use and then fill  in the settings for the batch job.  The
Batch Job  Script Wizard can't directly  submit the job, but  with the
"*Save Script*" you can save the  batch job file directly to your home
directory at CSC. After that you can  use the My Files tool to further
edit and launch the batch job (see paragraph 4.3.3).

![][2]

**Figure  4.2**  Batch  Job  Script Wizard  in  the  scientist's  user
interface (<https://sui.csc.fi/group/sui/batch-job-script-wizard>)

Below is an example of a SLURM batch job file made with a text editor:

    #!/bin/bash -l
    #SBATCH -J hello_SLURM
    #SBATCH -o output.txt
    #SBATCH -e errors.txt
    #SBATCH -t 01:20:00
    #
    echo "Hello SLURM"

The  first  line of  the  batch  job file  (*<span  style="font-style:
normal;">\#!/bin/bash        -l</span>*<span        style="font-style:
normal;">)</span>*<span  style="font-style: normal;">  </span>*defines
that  the bash  shell will  be used.  The following  four lines  <span
style="font-style:  normal;">contain  information  for the  batch  job
scheduler. The syntax of the lines is:</span>

    #SBATCH -sbatch_option argument

  
In  the example  above we  use  four *sbatch*  options: ***-J***  that
defines a name for the batch  job (hello\_SLURM in this case) ***-o***
defines  file  name for  the  standard  output  and ***-e***  for  the
standard error.  ***-t*** defines that the maximum duration of the job
is in this case 1 hour and 20 minutes. After the batch job definitions
comes the commands  that will be executed. In this  case there is just
one command:  *echo "Hello SLURM"*  that prints text "Hello  SLURM" to
standard output.

The  batch job  file  above can  be submitted  to  the scheduler  with
command:

~~~~ western
sbatch file_name.sh 
~~~~

  
The  batch  job  file  above  includes only  the  most  essential  job
definitions. However  it is often  mandatory or useful to  use several
other <span style="font-style: normal;">**sbatch** </span>options too.
The options needed  to run parallel jobs are discussed  more in detail
in the  server specific user  guides. Table  4.2 contains some  of the
mots commonly used *sbatch* options. The full list of *sbatch* options
can be listed with command

    sbatch -h 

**Table 4.2** Most commonly used *sbatch* options

<table> <colgroup> <col style="width:  25%" /> <col style="width: 75%"
/>  </colgroup>  <thead>  <tr  class="header">  <th>Slurm  option</th>
<th><strong>Description</strong></th>   </tr>  </thead>   <tbody>  <tr
class="odd"> <td>--begin=<em>time</em></td> <td>Defer  job until HH:MM
MM/DD/YY.</td>       </tr>       <tr       class="even">       <td>-c,
--cpus-per-task=<em>ncpus</em></td>  <td>Number   of  computing  cores
required    per   task.</td>    </tr>    <tr   class="odd">    <td>-d,
--dependency=<em>type:jobid</em></td> <td>Defer job until condition on
jobid   is    satisfied.</td>   </tr>   <tr    class="even">   <td>-e,
--error=<em>err</em></td>   <td>File  for   batch  script's   standard
error.</td>             </tr>             <tr             class="odd">
<td>--ntasks-per-node=<em>n</em></td>  <td>Number  of   tasks  to  per
node.</td>        </tr>        <tr        class="even">        <td>-J,
--job-name=<em>jobname</em></td> <td>Name  of the job.</td>  </tr> <tr
class="odd">  <td>--mail-type=<em>type</em></td>  <td>Notify on  state
change:  BEGIN,  END,  FAIL   or  ALL.</td>  </tr>  <tr  class="even">
<td>--mail-user=<em>user</em></td> <td>Who to  send email notification
for   job  state   changes.</td>   </tr>   <tr  class="odd">   <td>-n,
--ntasks=<em>ntasks</em></td> <td>Number  of tasks to  run.</td> </tr>
<tr class="even"> <td>-N,  --nodes=<em>N</em></td> <td>Number of nodes
on    which   to    run.</td>   </tr>    <tr   class="odd">    <td>-o,
--output=<em>out</em></td>  <td>File   for  batch   script's  standard
output.</td>        </tr>       <tr        class="even">       <td>-t,
--time=<em>minutes</em></td>     <td>Time      limit     in     format
<em>hh</em>:<em>mm</em>:<em>ss</em>.</td>   </tr>   <tr   class="odd">
<td>--mem-per-cpu=MB</td>  <td>Maximum  amount   of  real  memory  per
allocated  core  required by  the  job  in megabytes.</td>  </tr>  <tr
class="even">  <td>-p</td>  <td>Specify  partitions to  be  used.</td>
</tr> </tbody> </table>

 

In  the  second batch  job  example  below options  *--mail-type*  and
*--mail-user* are  used to  make the  batch system  to send  e-mail to
address <kkayttaj@uni.fi> when to job ends. Further the job is defined
to reserve  12GB of memory. In  the output and error  file definitions
*%j* is used to use the job id-number in the file name, so that if the
sane batch  job file is  used several times  the old output  and error
files will not get overwritten.

    #!/bin/bash -l
    #SBATCH -J hello_SLURM
    #SBATCH -o output_%j.txt
    #SBATCH -e errors_%j.txt
    #SBATCH -t 01:20:00
    #SBATCH -n 1
    #SBATCH --mail-type=END
    #SBATCH --mail-user=kkayttaj@uni.fi
    #SBATCH --mem=12288
    #

    echo "Hello SLURM"
    srun ./my_command

 

Setting optimal  values for the  requested computing time,  memory and
number of cores  to be used is  not always a simple task.  It is often
useful to first  send short test jobs  to get a rough  estimate of the
computing time  and memory  requirements of  the job.  It is  safer to
reserve more computing  time that is needed, but please  note that the
jobs  with large  computing time  or RAM  request often  have to  wait
longer    in     the    queue.    Please    see     page    (    <span
id="OBJ_PREFIX_DWT277_com_zimbra_url"                   class="Object"
role="link"><https://research.csc.fi/-/why-is-my-batch-job-queueing-so-long-></span>
)

All the batch queues have maximum duration and maximum amount of nodes
that  a  job  can  use.  You  can  check  these  limits  with  command
***[][3]sinfo   -l   .***  <span   style="font-style:   normal;"><span
style="font-weight: normal;">For example:</span></span>

    sinfo -l
    Mon Mar 17 16:46:29 2014
    PARTITION AVAIL  TIMELIMIT   JOB_SIZE ROOT SHARE     GROUPS  NODES       STATE NODELIST
    serial*      up  3-00:00:00          1   no YES:4        all    525       mixed c[5-497,500-505,508,510-516,518-528,570-576]
    parallel     up  3-00:00:00       1-28   no    NO        all    525       mixed c[5-497,500-505,508,510-516,518-528,570-576]
    longrun      up 14-00:00:00          1   no YES:4        all    525       mixed c[5-497,500-505,508,510-516,518-528,570-576]
    test         up       30:00        1-2   no YES:4        all      4        idle c[1-4]
    hugemem      up  7-00:00:00          1   no YES:4        all      2       mixed c[577-578]

The *sinfo  -l* output above  tells that  the cluster has  five queues
(parallel, serial,  longrun, test and hugemem).  The maximum execution
time in  *parallel* queue is tree  days (3-00:00:00) and the  jobs can
use use up to  28 nodes (28 \* 24 = 672  cores). Similarly the maximum
duration of jobs submitted to the *test* queue is 30 minutes ( 30:00)

Estimating  the  memory  request  is  even more  difficult  as  it  is
dependent  on  several thinks  like  algorithm  and software  and  the
analysis task.  In most  cases 1-4 GB  is enough but  you may  need to
increase the memory  size in the case of some  application. Note, that
large memory reservations may prolong the queuing time of your job.

Command [][4]**sjstat** can be used  to check the available memory for
nodes  in  different  partitions.   The  *sjstat*  command  lists  the
scheduling pool  data and the  running jobs. The scheduling  pool data
can be used to check the available memory in different partitions. You
can check just  the scheduling pool data by adding  option *-c* to the
command:

    sjstat -c
    Scheduling pool data
    -------------------------------------------------------------
    Pool        Memory  Cpus  Total Usable   Free  Other Traits  
    -------------------------------------------------------------
    serial*    64000Mb    16    556    552    371   
    serial*   256000Mb    16     16     16      0  bigmem
    parallel   64000Mb    16    556    552    371   
    parallel  256000Mb    16     16     16      1  bigmem
    longrun    64000Mb    16    556    552    371   
    longrun   256000Mb    16     16     16      0  bigmem
    test       64000Mb    16      4      4      4
    hugemem   155100Mb    32      2      2      1  bigmem

The  sample  listing  above  tells  that  resource  pool  "*parallel*"
contains  560 computing  nodes, each  having 64  GB of  memory and  16
cores. In addition to the *optimized* pool includes also 16 nodes with
256 GB of memory. Of these 556  64 GB memory nodes and 16 256GB memory
nodes are
free.  
 

**Table 4.3** Available batch job queues in supercluster taito.csc.fi.

|                  | | |
|------------------|-----------------------|----------------------|
| **Queue** | **Number of cores** | **Maximum run time** |
| serial (default) | 24 (one node) | 3 days |
| parallel | 672 (28 nodes) | 3 days |
| longrun | 24 (one node) | 14 days |
| hugemem | 40 (one hugemem node) | 7 days |
| test | 48 (two nodes) | 30 min |

 

## [][5]4.3.2 Using SLURM commands to execute batch jobs {#using-slurm-commands-to-execute-batch-jobs .western}

The  basic   SLURM  commands   for  submitting  batch   jobs  are<span
style="font-style: normal;"> **[][6]sbatch**  </span>that submits jobs
to     batch    job     system     and    <span     style="font-style:
normal;">**[][7]scancel**</span> that  can used  to stop and  remove a
queueing running job. The basic syntax of the batch command is:

    sbatch -options batch_job_file

 

Normally *sbatch* options  are included in the batch job  file but you
can  use the  options listed  in table  4.2 in  command line  too. For
example:

    sbatch -J test2 -t 00:05:00 batch_job_file.sh

If the same option  is used both in command line and  in the batch job
file the value defined in the  command line overrides the value in the
batch  job file.  When the  job is  successfully launched  the command
prints out the  line, telling the ID number of  the submitted job. For
example:

    Submitted batch job 6594 

The job ID  number can be used  to follow the progress of  to job with
command *scancel*. For example:

    scancel 6594

The progress of the submitted batch jobs can be followed with commands
*squeue, sjstat* and *sacct*. These commands can also be used to check
the  status and  parameters of  the SLURM  environment. Below  is some
examples for using these commands.

By  default  [][8]**squeue** command  lists  all  the jobs  which  are
submitted to  the scheduler.  If you  want to see  status of  your own
jobs, you can use command:

    squeue -l -u username

or

    squeue -l -u $USER

You  can also  check the  status  of a  specific job  by defining  the
**jobid** with**-j** switch. Using  option **-p** ***partition*** will
display only jobs on that SLURM partition.

Command  [][9]**scontrol**  allows  to View  SLURM  configuration  and
state.  To check  when the job waiting in the  queue will be executed,
the  command **scontrol  show job**  ***jobid***  can be  used. A  row
*"StartTime=..."* gives an  estimate on the job start-up  time. It may
happen that the  job execution time can not be  approximated, in which
case  *"StartTime=  Unknown"*. The  "StartTime"  may  change, i.e.  be
shortened, as the time goes.

The **[][10]sacct** command  can be used to study the  log file of the
batch job system. Thus it can  show information about both active jobs
and jobs  that have already  finished. By default the  *sacct* command
show information about users  own jobs. The *<span style="font-weight:
normal;">sacct</span>*  command  has  wide selection  of  options  and
parameters that  can be used  so select the  data to be  displayed. By
default *sacct* displays information from  the time period that starts
from the  midnight of current  day. You  can change the  starting date
with  option  **-S**  ***YYYY-MM-DD***.   For  example,  to  list  the
information since first of February 2016 you can use command:

    sacct -S 2016-02-01

Information    about   specific    jobs    can    be   checked    with
option**-J***job-ID*.  For  example  detailed  information  about  job
number 6594 could be shown with command:

    sacct -S 2016-02-01 -j 6594 -l 

**Table 4.4** Most frequently used SLURM commands.

<table> <colgroup> <col style="width:  25%" /> <col style="width: 75%"
/>   </colgroup>   <thead>   <tr   class="header">   <th> Command</th>
<th> Description</th>   </tr>   </thead>  <tbody>   <tr   class="odd">
<td><strong>sacct</strong></td> <td>Displays  accounting data  for all
jobs.</td>  </tr>  <tr class="even">  <td><strong>salloc</strong></td>
<td>Allocate   resources   for   interactive   use.</td>   </tr>   <tr
class="odd"> <td><strong>sbatch</strong></td> <td>Submit  a job script
to       a       queue.</td>       </tr>       <tr       class="even">
<td><strong>scancel</strong></td>  <td>Signal jobs  or job  steps that
are under the control of SLURM  (cancel jobs or job steps).</td> </tr>
<tr  class="odd">  <td><strong>scontrol</strong></td> <td> View  SLURM
configuration    and     state.</td>    </tr>     <tr    class="even">
<td><strong>seff</strong></td>  <td>Check  the  efficiency  (i.e.  the
actual  resources  used) if  a  completed  batch job.</td>  </tr>  <tr
class="odd">  <td><strong>sinfo</strong></td>   <td> View  information
about  SLURM  nodes  and   partitions.</td>  </tr>  <tr  class="even">
<td><strong>sjstat</strong></td> <td> Display statistics of jobs under
control of SLURM (combines data from sinfo, squeue and scontrol).</td>
</tr> <tr class="odd"> <td><strong>sprio</strong></td> <td>Display the
priorities  of  the pending  jobs.  Jobs  with higher  priotities  are
launched        first.</td>       </tr>        <tr       class="even">
<td><strong>smap</strong></td> <td> Graphically view information about
SLURM jobs, partitions, and  set configurations parameters.</td> </tr>
<tr class="odd"> <td><strong>squeue</strong></td> <td>View information
about  jobs located  in  the SLURM  scheduling  queue.</td> </tr>  <tr
class="even">   <td><strong>srun</strong></td>   <td>Run  a   parallel
job</td> </tr> </tbody> </table>

## [][11] {#section .western}

## 4.3.3 Using Scientist's User Interface to execute batch jobs {#using-scientists-user-interface-to-execute-batch-jobs .western}

*My   Files*   tool  in   Scientist's   User   interface  web   portal
(<https://sui.csc.fi/group/sui/my-files>) can be  used to transfer and
access  data   in  CSC's   storage  systems  (see   [chapter  5.1] for
details). In  addition to  data management, My  Files allows  users to
submit batch  jobs for execution.  In My Files, select  computing host
(for example,  Taito) and  then browse in  $WRKDIR in  directory where
your job script is saved.  Then select job script file and right-click
with  mouse. This  will open  a context  menu showing  action "*Submit
Batch  Job*". Selecting  this action  will  send your  job script  for
computation.

![][12]  
   
**Figure  4.3**  Submitting job  with  My  Files in  Scientist's  User
Interface (<https://sui.csc.fi/group/sui/my-files>)

 

 

  [chapter 2.7]: https://research.csc.fi/csc-guide-linux-bash-scripts
  [FGI User Guide]: https://research.csc.fi/fgi-user-guide
  [few examples]: https://research.csc.fi/taito-interactive-batch-jobs
  [1]: https://research.csc.fi/ {#4.3.1}
  [2]: https://research.csc.fi/documents/48467/84606/batch-job-wizard.jpg/9467ad68-2cd4-4e1c-92be-9dea672483a8?t=1395125836000
  [3]: https://research.csc.fi/ {#sinfo}
  [4]: https://research.csc.fi/ {#sjstat}
  [5]: https://research.csc.fi/ {#4.3.2}
  [6]: https://research.csc.fi/ {#sbatch}
  [7]: https://research.csc.fi/ {#scancel}
  [8]: https://research.csc.fi/ {#squeue}
  [9]: https://research.csc.fi/ {#scontrol}
  [10]: https://research.csc.fi/ {#sacct}
  [11]: https://research.csc.fi/ {#4.3.3}
  [chapter 5.1]: https://research.csc.fi/csc-guide-data-transport-with-scientist-s-user-interface
  [12]: https://research.csc.fi/documents/48467/84606/submit-job-my-files.png/9dea4eb9-b42b-4f72-a88e-e0f4fc61a960?t=1395403415245
