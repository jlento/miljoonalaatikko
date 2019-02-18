## NAMD

### Description

NAMD   is   a   parallel   molecular  dynamics   code   designed   for
high-performance  simulation   of  large  biomolecular   systems.  The
software  is   developed  and  distributed  by   the  Theoretical  and
Computational  Biophysics  Group  at  the  Beckman  Institute  of  the
University of Illinois.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Sisu: 2.9, 2.10, 2.11 (recommended)

Taito: 2.9, 2.11 (also GPU)

------------------------------------------------------------------------

### Usage

**FGI Grid**

-   NAMD instructions in FGI [NAMD Run Time Environment page]

**Taito**

Below is  a sample  batch job  file, to  run NAMD  using 128  cores on
SandyBridge.

    #!/bin/bash -l
    #SBATCH -t 00:10:00
    #SBATCH -p parallel
    #SBATCH -J NAMD
    #SBATCH -o onamd.%j
    #SBATCH -e enamd.%j
    #SBATCH --mem-per-cpu=512
    #SBATCH --ntasks=128
    #SBATCH --ntasks-per-node=16
    #SBATCH --constraint="snb"
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi # uncomment to receive email

    module load namd-env/2.11

    srun namd2 alanin > alanin.out

You can submit the batch queue file with command

    sbatch namd_job.bash

Note that namd2  is also available in  taito-shell.csc.fi which allows
currently interactive usage upto 8 cores.

**Sisu**

Below is a sample batch job file, to run NAMD using 192 cores.

    #!/bin/bash -l
    #SBATCH -t 00:10:00
    #SBATCH -p test
    #SBATCH -J NAMD
    #SBATCH -o onamd.%j
    #SBATCH -e enamd.%j
    #SBATCH -N 8
    #SBATCH --no-requeue
    #SBATCH --mail-type=END
    ##SBATCH --mail-user=your.name@yourinstitute.fi #uncomment to receive email

    module load namd/2.11

    (( ncores = SLURM_JOB_NUM_NODES * 24 ))
    aprun -n $ncores namd2 alanin > alanin.out

You can submit the batch queue file with command

    sbatch namd_job.bash

------------------------------------------------------------------------

### Discipline

Biosciences  
Chemistry  

------------------------------------------------------------------------

### References

The NAMD  License Agreement  specifies that  any reports  or published
results obtained  with NAMD shall  acknowledge its use and  credit the
developers as:

-    "NAMD   was  developed  by  the   Theoretical  and  Computational
    Biophysics Group in the Beckman Institute for Advanced Science and
    Technology at the University of Illinois at Urbana-Champaign."

James C.  Phillips,  Rosemary Braun,  Wei  Wang,  James Gumbart,  Emad
Tajkhorshid,  Elizabeth  Villa,  Christophe Chipot,  Robert D.  Skeel,
Laxmikant Kale,  and Klaus Schulten. Scalable  molecular dynamics with
NAMD. *Journal of Computational Chemistry*, 26:1781-1802, 2005.
[abstract], [journal]  
  
In addition,  electronic documents should include  the following link:
<http://www.ks.uiuc.edu/Research/namd/>

 

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

[NAMD manual]

[NAMD home page.]

------------------------------------------------------------------------

  [NAMD Run Time Environment page]: https://confluence.csc.fi/display/fgi/NAMD+Runtime+Environment
  [abstract]: http://www.ks.uiuc.edu/Publications/Papers/abstract.cgi?tbcode=PHIL2005
  [journal]: http://www3.interscience.wiley.com/cgi-bin/abstract/112102010/ABSTRACT
  [NAMD manual]: http://www.ks.uiuc.edu/Research/namd/current/ug/
  [NAMD home page.]: http://www.ks.uiuc.edu/Research/namd/
