## Paraview

### Description

ParaView  is  an  Open   Source,  versatile  software  for  scientific
visualization.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 5.4.1  
Taito-shell: 5.4.1  
Taito-gpu: 5.4.1

------------------------------------------------------------------------

### Usage

ParaView is designed to run parallel  tasks and consists of one client
and one  or several servers  (pvservers). There  are many ways  to run
ParaView, to suit  different needs. The following  examples cover most
cases. (Instructions to use older  version of ParaView are provided at
the end of this page.)

The most straightforward way to use ParaView is to run it in (combined
client-server)  standalone mode  from Taito-shell,  see **Example  1**
below. [NoMachine] is recommended for smooth interaction. In this mode
ParaView  uses one  and the  same CPU  for data  processing and  image
rendering. When  using OSPRay  rendering option,  four CPUs  are being
used for  rendering. This  mode is  sufficient for  most visualization
tasks.  (Standalone  mode can also  be used via SLURM  system, running
ParaView interactively in one of Taito's computing nodes, as explained
in [*Taito User Guide, chapter 3.4*].)

For more  demanding jobs  it might  be beneficial  to use  ParaView in
parallel  mode, as  one  client  and many  pvservers  each running  on
separate CPUs, see **Example 2**. In this mode ParaView client runs on
Taito-shell and pvservers on Taito. The  client connects to one of the
pvservers,    which    communicates    with   the    rest    of    the
pvservers.  (Pvserver  can  alternatively  connect to  a  client,  see
**Example 6**.)  Note that  if most of  the work is  done by  only one
pvserver, using parallel setup can  actually make ParaView run slower,
due to extra time taken to parse data from different cores. By opening
*Memory  Inspector*  window  in ParaView  (file  menu:  *View*/*Memory
Inspector*)  you   can  check   how  much   each  pvserver   is  being
used.  ParaView's *D3*-filter  can  be used  to  distribute work  more
evenly between the cores.

If the  model you are working  with is very large  and has complicated
geometry, lag in screen updates  may become noticeable. ParaView has a
tick  box option  to use  OSPRay renderer  for faster  screen re-draws
(since ParaView 5). OSPRay scales better with increasing geometry than
ParaView's  default  renderer, and  is  capable  of using  threads  to
further   accelerate  screen   updates.  When   running  ParaView   in
client-server mode from Taito-shell,  OSPRay uses four threads running
on four CPUs as default. Even more threads can be reserved from Taito,
see **Example 3**. Note that  switching between rendering modes can be
slow,  and that  the current  OSPRay implementation  renders artifacts
with some filters.

In cases where OSPRay does not work well enough, pvservers can also be
run on Taito-gpu, utilizing one or several GPUs. See **Example 4** and
**Example 5**.

 

**Example 1: ParaView in standalone mode, on Taito-shell**

Login to Taito-shell and type

    module load paraview
    paraview

 

**Example 2: ParaView in multi-core  mode. Client runs on Taito-shell,
pvservers run on Taito**

Login   to  Taito   and   submit  the   example   script  from   below
(*paraview\_multicore\_job.sh*),  to reserve  resources  and to  start
pvservers

    sbatch paraview_multicore_job.sh

When your  batch job has  started, check in  which compute node  it is
running

    squeue -l -u $USER

Now  that  you   have  the  node  address,  say   *c765*,  **login  to
Taito-shell**, start ParaView  as shown in **Example  1**, and connect
it manually to one pvserver,  by inserting the pvserver's node address
and port number details as follows:

choose *File/Connect* from ParaView's file menu  
click *Add Server*  
fill in a *Name* of your liking  
choose *Client/Server* as *Server Type*  
fill in your node address (*c765* in this example) as *Host*  
fill in the port number that you used in your script (*9454* in this
example) as *Port*  
click *Configure*  
click *Save* (*Startup Type: Manual*)  
click *Connect*

If everything  went OK, ParaView's *Pipeline  Browser* window displays
now your server's name, node address and port number (*cs://c765:9454*
in this example). When using the same script repeatedly, you only need
to edit the existing server description (*File/Connect*, *Edit Server*
button), so that it points to  the correct compute node (which changes
from job to job).

(Note  that  when  running  ParaView in  multicore  mode,  the  client
(paraview) and the  server (pvserver) need to be the  same version. If
you want  to run older  versions of ParaView, check  the corresponding
module files with "module avail" command,  and use these in the script
and on the command line. Modifications  for version 5.1.2 can be found
at the end of this page.)

Example script *paraview\_multicore\_job.sh*  below runs six pvservers
for one hour,  reserves 12 GB memory, and uses  port *9454*. Note that
the port must  not be in use already, so  better choose another number
than *9454*, before running the script.

    #!/bin/bash -l
    ### ParaView multicore job ###
    #SBATCH -J paraview_job
    #SBATCH -o paraview_job_out%j
    #SBATCH -e paraview_job_err%j
    # runtime in hours:minutes:seconds, max is 72 hours
    #SBATCH -t 01:00:00
    # how many nodes
    #SBATCH --nodes=1
    # how many pvservers
    #SBATCH -n 6
    # how much memory in MB per node (mem) or per process (mem-per-cpu)
    #SBATCH --mem-per-cpu=2000
    # use parallel partition (or serial, for up to 24 cpus)
    #SBATCH -p parallel

    module load pvserver
    srun pvserver --server-port=9454

 

**Example 3:  ParaView with threads (for  OSPRay rendering), pvservers
run on Taito**

Run  the following  script as  described in  **Example 2**.  Note that
ParaView utilises threads  for OSPRay rendering but not  for its basic
functions,  so  this  approach  is  useful only  if  you  need  faster
graphics.  Enable OSPRay  by ticking the box located on  the bottom of
ParaView's  *Properties*  panel. The  example  script  below runs  two
pvservers, both with  five threads, so altogether ten  cores are being
reserved.

    #!/bin/bash -l
    ### ParaView with threads ###
    #SBATCH -J paraview_job
    #SBATCH -o paraview_job_out%j
    #SBATCH -e paraview_job_err%j
    # runtime in hours:minutes:seconds, max is 72 hours
    #SBATCH -t 01:00:00
    # optional, Sandy Bridge (snb) or Haswell (hsw) CPUs
    # #SBATCH --constraint=hsw
    #SBATCH --nodes=1
    # if you need many nodes, consider using one task per node
    # #SBATCH --ntasks-per-node=1
    # how many tasks (pvservers)
    #SBATCH -n 2
    # how many CPUs (threads) per pvserver
    #SBATCH --cpus-per-task=5
    # how much memory in MB per node (mem) or per process (mem-per-cpu)
    #SBATCH --mem=12000
    # use parallel partition (or serial, for up to 24 cpus)
    #SBATCH -p parallel

    module load pvserver
    srun pvserver --server-port=9454

 

**Example 4: ParaView rendering with graphics card (one GPU), pvserver
runs on Taito-gpu**

Run the  following script as  described in **Example 2**,  except that
**login  to Taito-gpu**  instead  of  Taito (same  *username/password*
works on both)  to submit your script via *sbatch*  command. Note that
graphics  node names  start with  *g* while  compute nodes  start with
*c*. The example  script below runs one pvserver and  uses one GPU for
rendering.  Although not necessarily beneficial, you can use more than
one CPU, and add threads as described in the previous example.

    #!/bin/bash -l
    ### ParaView using one GPU ###
    #SBATCH -J pvserver_job
    #SBATCH -o pvserver_job_out%j
    #SBATCH -e pvserver_job_err%j
    # runtime in hours:minutes:seconds, max is 72 hours
    #SBATCH -t 01:00:00
    # use gpu partition (or gputest, for max 15 minutes)
    #SBATCH -p gpu
    # define the type and number of graphics cards to use (k80 or p100, 1 GPU)
    #SBATCH --gres=gpu:p100:1
    # how much memory per node, max for k80/p100 is 256000/512000 MB
    #SBATCH --mem=12000
    # how many pvservers (CPU cores), k80/p100 node has 24/28 CPU cores
    #SBATCH -n 1

    module load pvserver
    srun pvserver --egl-device-index=$GPU_DEVICE_ORDINAL --server-port=9454

 

**Example 5:  ParaView rendering with  several GPUs, pvservers  run on
Taito-gpu**

Follow the instructions  of the previous **Example 4**.  Note that the
example   script   below   uses    a   separate   configuration   file
*paraview\_8cpu\_4gpu.conf*,  which  is  also shown.  Also  note  that
running ParaView with many CPUs  and GPUs does not necessarily provide
speed enhancements, and may result in long queuing times.

Taito-gpu has two types of graphics  cards in its nodes, K80 and P100.
Both node types  have four GPUs. Currently you need  to reserve either
one or all GPUs in a node.

The  example  script  below  runs eight  pvservers,  each  with  three
threads,  and reserves  four GPUs  for rendering.  All the  K80 node's
GPUs, cores and  memory are being reserved. (If no  threads were used,
the node's 24 cores could have run 24 pvservers, and the configuration
file would have included 24 lines. Extending the configuration file is
straightforward.)

    #!/bin/bash -l
    ### ParaView using several CPUs and GPUs ###
    #SBATCH -J pvserver_job
    #SBATCH -o pvserver_job_out%j
    #SBATCH -e pvserver_job_err%j
    # runtime in hours:minutes:seconds, max is 72 hours
    #SBATCH -t 01:00:00
    # use gpu partition
    #SBATCH -p gpu
    # how many gpu nodes
    #SBATCH --nodes=1
    # define the type and number of graphics cards to use (k80 or p100, 4 GPUs)
    #SBATCH --gres=gpu:k80:4
    # how much memory per node, max for k80/p100 is 256000/512000 MB
    # when reserving the whole node, you may as well reserve all its memory
    #SBATCH --mem=256000
    # how many pvservers (tasks)
    #SBATCH -n 8
    # how many CPUs (threads) per pvserver, k80/p100 node has 24/28 CPUs
    # note that here all CPUs in the k80 node are reserved (8 x 3 = 24)
    #SBATCH --cpus-per-task=3

    module load pvserver
    srun --multi-prog paraview_8cpu_4gpu.conf

Configuration file *paraview\_8cpu\_4gpu.conf* for the above script:

    0 pvserver --egl-device-index=0 --server-port=9454
    1 pvserver --egl-device-index=1 --server-port=9454
    2 pvserver --egl-device-index=2 --server-port=9454
    3 pvserver --egl-device-index=3 --server-port=9454
    4 pvserver --egl-device-index=0 --server-port=9454
    5 pvserver --egl-device-index=1 --server-port=9454
    6 pvserver --egl-device-index=2 --server-port=9454
    7 pvserver --egl-device-index=3 --server-port=9454

 

**Example 6: ParaView in reverse connection multi-core mode, pvservers
run on Taito**

This method  is similar to **Example  2** but does the  connection the
other way round. ParaView client is started first and made to wait for
the pvserver to  connect. When the resources become  available and the
submitted  pvserver job  starts, the  client is  ready for  use. (This
example  complies with  a previous  version of  instructions on  these
pages, on how to use ParaView in multi-core mode.)

**Login to Taito-shell**, type *hostname*  to explicitely see the name
of the  compute node  you are  in (say *c765*),  start ParaView  as in
**Example 1**, and prepare ParaView to wait for connection as follows:

choose *File/Connect* from ParaView's file menu  
click *Add Server*  
fill in a *Name* of your liking  
choose *Client/Server (reverse connection)* as *Server Type*  
fill in the  port number, that you'll be using  in your script (*9454*
in
this example) as *Port*  
click *Configure*  
click *Save* (*Startup Type: Manual*)  
click *Connect*

Message  *Waiting  for Server  Connection*  should  now show  up,  and
Taito-shell  terminal window  should display  the node  name and  port
number *Accepting connection(s): c765:9454*.

Next, login to Taito, and type

    export CLIENT_IP= <the node name you got from the command hostname in Taito-shell>
    sbatch <the name of your job script>

Note that server-port number in the batch job script below must be the
same   number  you   defined   in   your  *Client/Server*   connection
configuration, otherwise  the server  side is not  able to  connect to
your client. Port number must not  be in use already, so better choose
another number  than *9454*  for your script.  Remember that  you must
have the environment variable CLIENT\_IP  - without it the server side
does not know where the client runs.

    #!/bin/bash -l
    ### ParaView multicore reverse connection job ###
    #SBATCH -J paraview_job
    #SBATCH -o paraview_job_out%j
    #SBATCH -e paraview_job_err%j
    # runtime in hours:minutes:seconds, max is 72 hours
    #SBATCH -t 01:00:00
    # how many nodes
    #SBATCH --nodes=1
    # how many pvservers
    #SBATCH -n 6
    # how much memory per node, in MB
    #SBATCH --mem=12000
    # use parallel partition
    #SBATCH -p parallel

    module load pvserver
    srun pvserver --reverse-connection --server-port=9454 --client-host=${CLIENT_IP}

 

 

**Using previous versions of ParaView**

If you  want to use  the older 5.1.2  version of ParaView,  modify the
above scripts  as follows. In  this setup, VirtualGL  middleware takes
care  of  directing the  rendering  commands  to Taito-gpu's  graphics
cards. There are no changes  in the resource reservation part (denoted
by ...).

**Example 1**

    module load paraview/5.1.2-kitware
    paraview

**Example 2** and **Example 3**

    ...
    module load paraview/5.1.2-pvserver
    srun pvserver --server-port=9454

**Example 4**

    ...
    module load paraview/5.1.2-pvserver
    module load vgl
    source /etc/slurm/startx
    sleep 1
    srun vglrun -d :$GPU_DEVICE_ORDINAL pvserver -display :$GPU_DEVICE_ORDINAL --server-port=9454

**Example 5**

    ...
    module load paraview/5.1.2-pvserver
    module load vgl
    source /etc/slurm/startx
    sleep 1
    srun --multi-prog paraview_8cpu_4gpu.conf

*paraview\_8cpu\_4gpu.conf*:

    0 vglrun -d :0.0 pvserver -display :0.0 --server-port=9454 --use-offscreen-rendering
    1 vglrun -d :0.1 pvserver -display :0.1 --server-port=9454 --use-offscreen-rendering
    etc

**Example 6**

    ...
    module load paraview/5.1.2-pvserver
    srun pvserver --reverse-connection --server-port=9454 --client-host=${CLIENT_IP}

 

------------------------------------------------------------------------

### Discipline

Visualization  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [ParaView homepage]
-   [ParaView documentation and guide]
-   [ParaView Wiki]
-   [ParaView Tutorial]
-   [Search the ParaView users mailing list]

------------------------------------------------------------------------

  [NoMachine]: https://research.csc.fi/-/nomachine
  [*Taito User Guide, chapter 3.4*]: https://research.csc.fi/taito-interactive-batch-jobs
  [ParaView homepage]: http://www.paraview.org/
  [ParaView documentation and guide]: http://www.paraview.org/documentation/
  [ParaView Wiki]: http://paraview.org/Wiki/ParaView
  [ParaView Tutorial]: http://www.paraview.org/Wiki/The_ParaView_Tutorial
  [Search the ParaView users mailing list]: http://paraview.markmail.org
