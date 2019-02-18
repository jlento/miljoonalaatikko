## TmoleX

### Description

TmoleX is a  GraphicalUser Interface for Turbomole that  can be freely
downloaded from 

<http://www.cosmologic.de/support-download/downloads/tmolex-client.html>

TmoleX  is  used   as  a  locally  installed   client  for  preparing,
submitting, monitoring and post  processing remote Turbomole jobs that
are run on Taito.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito, Taito-shell: 4.4

------------------------------------------------------------------------

### Usage

The most  convenient way of using  TmoleX is to install  the client on
your          local         workstation.          For         details,
see,[ http://www.cosmologic.de/turbomole/tmolex.html][][**.**] If  you
prefer to  use the  version installed  on Taito  it is  recommended to
launch it  via the [NoMachine Remote Desktop.] From  the NX-connection
you open a connection Taito-shell which is an interactive session on a
compute  node. There  you  load the  turbomole  environment and  start
tmolex simply by

`module load turbomole/7.3;TmoleX18`

If you  use it from your  local workstation you can  define the actual
run to be done on Taito. After you have selected **Run (network)** the
parameters for a batch job on Taito can be defined like:

![][1]

Where the complete script to be  inserted in  the field "Script before
job execution" looks like (modify according to your actual needs):

    #SBATCH -p test           # queue
    #SBATCH --nodes 2         # for SMP only 1 is possible
    #SBATCH --ntasks-per-node=24 # Tasks per node
    #SBATCH -t 0:20:00        # time as hh:mm:ss
    #SBATCH -J tm73b-parallel
    #SBATCH -e jobfile.err%J
    #SBATCH -o jobfile.out%J
    #SBATCH --mem-per-cpu=2000  # requested memory per process in MB
    #SBATCH --tmp=400000        # requested local scratch disk in MB
                                # max --tmp 400000 (hsw) 1800000 (snb)
    SDIR=`pwd`
    # setup TURBOMOLE 7.3 environment
    export TURBODIR=/appl/chem/TM7.3/TURBOMOLE
    source $TURBODIR/Config_turbo_env

    # remove possible earlier $tmpdir from control file
    kdg tmpdir
    #
    export HOSTS_FILE=$SDIR/turbomole.machines
    rm -f $HOSTS_FILE
    srun hostname > $HOSTS_FILE
    cat $HOSTS_FILE
    #

------------------------------------------------------------------------

### Discipline

Chemistry  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [ http://www.cosmologic.de/turbomole/tmolex.html]: http://www.cosmologic.de/turbomole/tmolex.html
  [**.**]: http://www.cosmologic.de/tmolex
  [NoMachine Remote Desktop.]: https://research.csc.fi/-/nomachine
  [1]: https://research.csc.fi/documents/48467/73370/tmolex_4.4_new.png/0371951c-70cf-42db-bca5-e2ac56e4b112?t=1534947298308
