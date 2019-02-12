## Molpro

### Description

* * *

### Available

##### Version on CSC's Servers

*   Taito: 2015.1, 2012.1
*   (Taito-shell)

* * *

### Usage

The environment is set by the command:

    module load molpro-env/2015.1 ("module avail molpro-env" for a list of available versions)

In order to run MOLPRO you need to create an input file. See the [manual](http://www.molpro.net/info/current/doc/manual/?portal=user&choice=User%27s+manual) for detailed instruction on how to prepare one. Examples can be found in the **examples** and **testjobs** directories:

*   /appl/chem/molpro/examples
*   /appl/chem/molpro/testjobs

**Parallel runs**

Many parts of MOLPRO have been parallelized. To run the program in parallel, you need to prepare a batch job file for parallel jobs and submit it. The file and procedure differs depending on architecture.  
 

Sample job file [job-molprop2015-taito.job](https://extras.csc.fi/chem/progs/molpro/job-molprop2015-taito.job) for Taito

Submit the job with:

    sbatch  job-molprop2015-taito.job

Small interactive serial jobs can be done in Taito-shell by first loading the molpro environment with:

    module load molpro-env/2015.1

The interactive job can then be launched with:

    molpro_no_srun.sh test.inp &

The script     molpro_no_srun.sh can be used together with other command line options, see

[https://www.molpro.net/info/2015.1/doc/manual/node7.html](https://www.molpro.net/info/2015.1/doc/manual/node7.html)

* * *

### Discipline

Chemistry  

* * *

### References

*   Scientific publications require proper citation of methods and procedures employed. All publications resulting from use of MOLPRO must acknowledge at least the following:

All publications resulting from use of this program must acknowledge the following two references.

H.-J. Werner, P. J. Knowles, G. Knizia, F. R. Manby and M. Schütz, WIREs Comput Mol Sci **2**, 242-253 (2012), doi: [10.1002/wcms.82](http://dx.doi.org/10.1002/wcms.82)

[MOLPRO, version 2015.1, a package of _ab initio_ programs, H.-J. Werner, P. J. Knowles, G. Knizia, F. R. Manby, M. Schütz, P. Celani, W. Györffy, D. Kats, T. Korona, R. Lindh, A. Mitrushenkov, G. Rauhut, K. R. Shamasundar, T. B. Adler, R. D. Amos, A. Bernhardsson, A. Berning, D. L. Cooper, M. J. O. Deegan, A. J. Dobbyn, F. Eckert, E. Goll, C. Hampel, A. Hesselmann, G. Hetzer, T. Hrenar, G. Jansen, C. Köppl, Y. Liu, A. W. Lloyd, R. A. Mata, A. J. May, S. J. McNicholas, W. Meyer, M. E. Mura, A. Nicklass, D. P. O'Neill, P. Palmieri, D. Peng, K. Pflüger, R. Pitzer, M. Reiher, T. Shiozaki, H. Stoll, A. J. Stone, R. Tarroni, T. Thorsteinsson, and M. Wang,](https://www.molpro.net/info/2015.1/doc/molpro.bib) , see [http://www.molpro.net](http://www.molpro.net).

Some journals insist on a shorter list of authors; in such a case, the following should be used instead.

[MOLPRO, version 2015.1, a package of _ab initio_ programs, H.-J. Werner, P. J. Knowles, G. Knizia, F. R. Manby, M. Schütz, and others](https://www.molpro.net/info/2015.1/doc/molpro.bib) , see [http://www.molpro.net](http://www.molpro.net).

Depending on how the programs are used, other references should also be cited. For instructions see the [manual](http://www.molpro.net/info/current/doc/manual/node3.html).

#### Licensing restrictions

*   You may use the Software exclusively for non-profit research purposes.
*   See the [Licence Agreement](https://www.molpro.net/resources/licence_deliver.php?format=html&type=service&use=non-commercial&duration=indefinite) for additional details

* * *

### Support

* * *

### Manual

The manual is available in different formats:

*   [PDF format](http://www.molpro.net/info/current/doc/manual.pdf)
*   [HTML format](http://www.molpro.net/info/current/doc/manual/?portal=user&choice=User%27s+manual)
    
    #### More information
    
    Additional information can be found at the [MOLPRO homepage](http://www.molpro.net/). There is also a [mailing list](http://www.molpro.net/mailman/listinfo/molpro-user/?portal=user&choice=User+mailing+list) for MOLPRO users, the use of which is encouraged.
    

* * *