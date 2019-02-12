## Amber

### Description

Amber is a molecular dynamics package which has as number of additional tools for more sophisticated analysis and in particular for NMR structure refinement.

* * *

### Available

##### Version on CSC's Servers

Taito: 16, 16-cuda, 18, 18-cuda

* * *

### Usage

### License

Amber can be used on CSC servers by all not-for-profit institute and university researchers irrespective of nationality or location. The full Acedemic license text can be found in [here](http://ambermd.org/LicenseAmber18.pdf).

In Taito give  
  
    module load amber-env

This will set $AMBERHOME and put the binaries in the path. Run Amber production jobs in the batch queues, see below.

**Examples for batch jobs**

You can find example inputs from the amber tests directory:

    ls $AMBERHOME/test

Amber18 runs well on GPGPUs and pmemd simulations are multiple times faster than CPU-only simulations. However, only pmemd is GPGPU-aware, see examples further below. For more details, consult [Amber benchmark scaling info](http://ambermd.org/gpus/benchmarks.htm).

**Amber 18 CUDA job (preferred way to run Amber MD)**

Only PMEMD is CUDA aware.  The following batch script will start a PMEMD job on a single GPGPU card (**must** be submitted from **taito-gpu.csc.fi**). The best results are obtained with one mpitask per GPGPU card:

    #!/bin/bash -l
    #SBATCH -t 01:10:00
    #SBATCH -p gpu
    #SBATCH -J Amber-job
    #SBATCH -o oamber.%j
    #SBATCH -e eamber.%j
    #SBATCH --ntasks=1
    #SBATCH --gres=gpu:p100:1
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi # uncomment to receive email
    
    module load amber-env/18-cuda
    
    srun --gres=gpu:p100:1 pmemd.cuda -O -i mdin -c md12.x -o mdout.gpu.testi

This script will run a PMEMD job using two GPGPUs on one K80 node:

    #!/bin/bash -l
    #SBATCH -t 01:10:00
    #SBATCH -p gpu
    #SBATCH -J Amber-job
    #SBATCH -o oamber.%j
    #SBATCH -e eamber.%j
    #SBATCH -n 2
    #SBATCH -N 1
    #SBATCH --gres=gpu:k80:2
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi # uncomment to receive email
    
    module load amber-env/18-cuda
    
    srun --gres=gpu:k80:2 pmemd.cuda.MPI -O -i mdin -c md12.x -o mdout.2-gpu.testi

This script will run a PMEMD job using four GPGPUs on one K80 node:

    #!/bin/bash -l
    #SBATCH -t 01:10:00
    #SBATCH -p gpu
    #SBATCH -J Amber-job
    #SBATCH -o oamber.%j
    #SBATCH -e eamber.%j
    #SBATCH -n 4
    #SBATCH -N 1
    #SBATCH --gres=gpu:k80:4
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi # uncomment to reveive email
    
    module load amber-env/18-cuda
    
    srun --gres=gpu:k80:4 pmemd.cuda.MPI -O -i mdin -c md12.x -o mdout.4-gpu.testi

Please test for scaling before using more than one GPGPU - using more than one GPGPU might not speed up your simulation. You also may need to request more than the default amount of memory.

If you need to run other than pmemd jobs, you can use the CPU-only nodes. In Taito the following submits a parallel pmemd job requesting two full **Haswell** nodes i.e. 48 cores

    #!/bin/bash -l
    #SBATCH -t 01:10:00
    #SBATCH -J Amber-job
    #SBATCH -o oamber.%j
    #SBATCH -e eamber.%j
    #SBATCH -p parallel
    #SBATCH --constraint=hsw
    #SBATCH --nodes=2
    #SBATCH --ntasks-per-node=24
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi # uncomment to receive email
    
    module load amber-env/18
    
    srun pmemd.MPI -O -i mdin -c md12.x -o mdoutParallel Amber jobs seem to run most efficiently, if one uses a power of two number of cores (2,4,8,16,32,64), but CPU-only performance is low compared to GPGPU. Test for scaling ([Amber Benchmarks](http://ambermd.org/gpus/benchmarks.htm)).  The pmemd module scales up to some tens of cores, but is much slower than e.q. Gromacs. For large scale or very long MD simulations consider using a better scaling MD engine.

To run an Amber job in the FGI (Finnish Grid Infrastructure) have a look at the Grid basics (getting a certificate, and setting up the grid proxy) and the Amber runtime environment. You can run FGI jobs, e.g. from Taito with arcproxy / arcsub / arcstat / arcget.

**Interactive jobs**

Sometimes it is more convenient to run a small job, like system preparations, interactively. To prevent load on the login node, these kinds of jobs should be run on Taito-shell. You can login to taito-shell from the [NoMachine remote desktop](/-/nomachine) at nxkajaani.csc.fi or directly via ssh. [More info on taito-shell in here](/taito-shell-user-guide).

    ssh taito-shell.csc.fi

On taito-shell you can launch jobs directly from the command line without additional SLURM parameters. By default you can run threaded jobs up to 4 cores. E.g. to test the input of a pmemd run:

    ./pmemd.MPI -O -i mdin -o mdout -p prmtop -c inpcrd

* * *

### Discipline

Biosciences  
Chemistry  

* * *

### References

When citing Amber 2018 (comprised of AmberTools18 and Amber18) in the literature, the following citation should be used:

  
D.A. Case, I.Y. Ben-Shalom, S.R. Brozell, D.S. Cerutti, T.E. Cheatham, III, V.W.D. Cruzeiro, T.A. Darden, R.E. Duke, D. Ghoreishi, M.K. Gilson, H. Gohlke, A.W. Goetz, D. Greene, R Harris, N. Homeyer, S. Izadi, A. Kovalenko, T. Kurtzman, T.S. Lee, S. LeGrand, P. Li, C. Lin, J. Liu, T. Luchko, R. Luo, D.J. Mermelstein, K.M. Merz, Y. Miao, G. Monard, C. Nguyen, H. Nguyen, I. Omelyan, A. Onufriev, F. Pan, R. Qi, D.R. Roe, A. Roitberg, C. Sagui, S. Schott-Verdugo, J. Shen, C.L. Simmerling, J. Smith, R. Salomon-Ferrer, J. Swails, R.C. Walker, J. Wang, H. Wei, R.M. Wolf, X. Wu, L. Xiao, D.M. York and P.A. Kollman (2018), AMBER 2018, University of California, San Francisco.

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

Amber home page: [http://ambermd.org/](http://ambermd.org/)

* * *