## Python

### Description

Python  is an  interpreted,  interactive, object-oriented  programming
language. It  incorporates modules,  exceptions, dynamic  typing, very
high level dynamic data types, and classes. Python combines remarkable
power with very  clear syntax. It has interfaces to  many system calls
and libraries, as well as to various window systems, and is extensible
in  C  or  C++.  It  is  also usable  as  an  extension  language  for
applications that need a programmable interface.

The standard packages installed to all versions include at least:

-   NumPy, SciPy, Matplotpib and Mpi4py (on Sisu and Taito)
-   Pandas, Ipython (only in Taito)

For full list you can type after starting Python:

~~~~ lang-py
help('modules')
~~~~

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito
-   Sisu

##### Versions

On Taito

    module spider python

On Sisu

    module avail python

##### Versions available on Taito as of 8.08.2017

-   2.7.3
-   2.7.6
-   2.7.9
-   2.7.10
-   2.7.13
-   3.4.0
-   3.4.1
-   3.4.5
-   3.5.3

------------------------------------------------------------------------

### Usage

To start working with python use the module command:

    module load python/version

In Taito use

    module load python-env/version

Omitting version will initialise the default version which will change
when bugs are fixed or new versions are accepted stable.

Separate modules  are available for specific  areas, inc: [biopython],
[geopython], and [mlpython].

 

**Installing and using your own Python module at Taito**

It is possible to install Python packages for private use. The easiest
way for doing that is using pip and installing to your home directory:

`pip install <name of python module> --user`

If needed you can also specify the version number, like this:

`pip install <name of python module>==2.2.1 --user`

Additional information,  inc more advanced options  for installing own
Python  modules is  availabe  from CSC  webinar: <span  id="eow-title"
class="watch-title"  dir="ltr" title="Webinar:  Python environment  in
CSC compute  servers">[Python environment in CSC  compute servers] and
</span>from [here].

 

### Simple batch job example for python

    #!/bin/bash -l
    #SBATCH -J python_test
    #SBATCH -o python_test_out_%j.txt
    #SBATCH -e python_test_err_%j.txt
    ## how much runtime is needed, 30 minutes
    #SBATCH -t 00:30:00
    ## serial code, will run inside one compute node
    #SBATCH -p serial
    ## python has just one process
    #SBATCH -n 1
    ## how many cores are needed, 1
    ## If your script can run in parallel you can add up to 24 here, for example --cpus-per-task=10
    #SBATCH --cpus-per-task=1
    ## how much memory is needed (megabytes), 4GB
    #SBATCH --mem=4000

    ## I need this environment (you can choose different Python version here)
    module load python-env/2.7.13
    ## this will run my python code file (41177-Examples.py)
    python -u 41177-Examples.py

------------------------------------------------------------------------

### Discipline

Other  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [biopython]: https://research.csc.fi/-/biopython
  [geopython]: https://research.csc.fi/-/geopython
  [mlpython]: https://research.csc.fi/-/mlpython
  [Python environment in CSC compute servers]: https://www.youtube.com/watch?v=Ux17q5W5qlE
  [here]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex3
