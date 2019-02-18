## GPAW

### Description

GPAW  is  an  efficient   program  package  for  electronic  structure
calculations.  It  is based  on  the  density-functional theory  (DFT)
implemented  within the  projector augmented  wave (PAW)  method using
uniform real-space grids.  GPAW can be used for  systems containing up
to hundres of atoms and thousands of electrons.

Some features of the software:

-   total energy calculations
-   structural optimizations
-   different boundary conditions (finite, wire, slab, bulk)
-   efficient parallelization
-   excited state  properties within time-dependent density-functional
    theory

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Sisu: 0.9.0, 0.10.0, 0.11.0, 1.1.0, 1.2.0, 1.3.0, 1.4.0

Taito: 0.9.0, 0.10.0, 0.11.0, 1.1.0, 1.2.0, 1.3.0, 1.4.0

------------------------------------------------------------------------

### Usage

GPAW  can be  used from  command  line or  with limited  functionality
through    the [SOMA2] modeling   environment    (GUI   through    web
browser).    The   GPAW    environment    can   be    set   up    with
the **module** command.

On **Sisu**, one loads the default version with the command

`module load gpaw`

and a specific version (e.g. 1.4.0) with a command such as

`module load gpaw/1.4.0`

On **Taito**, the commands are the same, but the name of the module is
*gpaw-env*.

`module load gpaw-env`

`module load gpaw-env/1.4.0`

GPAW input files are python scripts and **interactive** and **serial**
calculations are run by python interpreter as

`python input.py`

For **parallel**  calculations a  special *gpaw-python*  executable is
used, whose full pathname in CSC environment is given in $GPAW\_PYTHON
variable.

`gpaw-python input.py`

Below are more specific instructions for different CSC machines.

### Sisu

Sample job script for parallel calculations:

    #!/bin/bash
    #SBATCH -J jobname
    #SBATCH -e job_err
    #SBATCH -o job_out
    #SBATCH -N 8
    #SBATCH -p small
    #SBATCH -t 00:01:10
    #SBATCH --no-requeue

    ((ncores = 24 * SLURM_NNODES))

    module load gpaw/1.4.0

    aprun -n $ncores gpaw-python input.py

### Taito

Sample job script for parallel calculations:

    #!/bin/bash
    #SBATCH -J jobname
    #SBATCH -e job_err
    #SBATCH -o job_out
    #SBATCH -N 2
    #SBATCH -n 48
    #SBATCH -p parallel
    #SBATCH -t 00:01:10
    #SBATCH --mem-per-cpu=1000

    module load gpaw-env/1.4.0

    srun gpaw-python input.py

    # this script will print some usage statistics to the end of job_out file.
    used_slurm_resources.bash 

### FGI grid

You  can find  the  instructions to  run  GPAW in  the  FGI Grid  from
the [GPAW runtime environment page].

### DataWarp on Sisu

Compute nodes  on Sisu  have so called DataWarps available,  i.e. fast
flash-based temporary  storage attached  directly to the  nodes. These
may offer improved  burst-I/O buffering for I/O patterns  that are not
optimal for the Lustre  filesystem. If your calculation involves a lot
of frequent reads/writes,  it is worthwhile to  test if DataWarp gives
you a performance  boost. For more information,  please see [Sisu User
Guide].

------------------------------------------------------------------------

### Discipline

Chemistry  
Physics  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

Manual and further information can be found from [GPAW-wiki.]

------------------------------------------------------------------------

  [SOMA2]: http://www.csc.fi/english/pages/soma/index_html
  [GPAW runtime environment page]: https://confluence.csc.fi/display/fgi/GPAW+runtime+environment
  [Sisu User Guide]: https://research.csc.fi/sisu-using-datawarp
  [GPAW-wiki.]: https://wiki.fysik.dtu.dk/gpaw
