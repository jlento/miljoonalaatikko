# 3.4 Interactive batch jobs

Interactive batch jobs can be used in Taito for running graphical
interfaces or other tasks that require input from the user during the
execution of the computing task. Note, that you may need to queue for
SLURM to allocate these resources, except if you choose *Taito-shell*,
see below.

The most easy way to run interactive batch jobs is to use *Taito-shell*,
described in [chapter 8] of this guide. When a taito-shell session is
opened, the session is actually an interactive batch job, that has
following properties:

-   Unlimited running time
-   Computing capacity up to 4 cores per session
-   Shared memory of up to 128 GB per session

You can open Taito-shell session, either by directly connecting
taito-shell.csc.fi:

    ssh -X taito-shell.csc.fi -l csc_user_id

or if you have already logged in to Taito, you can open a Taito-shell
session with command:

    sinteractive

 

In cases, the you can't use *taito-shell/sinteractive* ( e.g. in the
case of interactive mpi jobs), you can use the *srun* command to launch
interactive batch job sessions. For example command:

     srun -n1 -t02:00:00 --x11=first --pty $SHELL

would launch interactive batch jobs session, running the default command
shell ( $SHELL). In the command above, one core (*-n1* ) is reserved for
two hours (*-t02:00:00*). The definition *--x11=first* sets up the x11
connection so that graphical user interfaces can be used.

Bellow is a sample session where the VMD molecular visualization program
is started on an interactive batch job session. Note that after the
*srun* command, the commands are not executed in the login node any
more. In stead the VMD is now started in one of the computing nodes (
node c120 in this case ) and thus VMD is not causing extra load to the
login node:

    [kkayttaj@taito-login4 kkayttaj]$ srun -n1 -t02:00:00 --x11=first --pty $SHELL
    [kkayttaj@c120 kkayttaj]$ module load vmd
    VMD version 1.9.1 is now in use
    [kkayttaj@c120 kkayttaj]$ vmd

You can also use interactive batch job sessions to test your software.
In these cases you can use *srun* as above or alternatively, first the
resource allocation with command: *salloc* and the submit jobs with
*srun* command.

In the example bellow a request for 48 cores (*-n 48*) with 1 GB/core
(*--mem-per-cpu=1000*) for 30 minutes (*-t00:30:00*)  is submitted with
the *salloc* command. Two full Taito Haswell nodes nodes will be
reserved for the interactive job as 24 cores will be used from one node
( *--ntasks-per-node=24*). Once the resource allocation is done the
Gromacs jobs can be launched using the *srun* command:

    salloc -n 48 --ntasks-per-node=24 --mem-per-cpu=1000 -t00:30:00 -p parallel
    srun mdrun_mpi -s topol1 -dlb yes
    srun mdrun_mpi -s topol2 -dlb yes
    exit

In the example above the *exit* command closes the resource allocation
done by the *salloc* command.

 

 

  [chapter 8]: https://research.csc.fi/taito-shell-user-guide
