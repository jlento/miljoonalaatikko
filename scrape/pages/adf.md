## ADF

### Description

ADF (Amsterdam Density Functional) is suitable for calculations on atoms and molecules (in gas phase or solution). It can be used for the study of such diverse fields as molecular spectroscopy, organic and inorganic chemistry, crystallography and pharmacochemistry.

A separate program in the ADF package, **BAND**, is available for the study of periodic systems: crystals, surfaces, and polymers.

**News!**

**For the present licensing period (1 Feb 2019-31 Jan 2020)  we have extended the license to cover three new modules:**  
 

**\* [Quantum Espresso, including a GUI for input generation and output visualization](https://www.scm.com/support/downloads/gui-for-quantum-espresso/)  
\* [COSMO-RS](https://www.scm.com/product/cosmo-rs/)  
\* [ReaxFF](https://www.scm.com/product/reaxff/)  
  
Depending on the level of usage, we might prolong the extended license to the subsequent licensing period.**

The present license also includes the Graphical User Interfaces to ADF and BAND.  For details about installing the GUI on your local workstation please contact [Nino Runeberg](http://www.csc.fi/english/research/sciences/chemistry/index_html "Chemistry").

The GUIs can also be conveniently used from CSC's servers via the [FreeNX Remote Desktop.](https://research.csc.fi/-/nomachine)

The settings for the SLURM batch jobs launced via ADFjobs look like:

![]( http://extras.csc.fi/chem/progs/adf/ADFjob.png)

* * *

### Available

##### Version on CSC's Servers

Taito: ADF 2018.103

Sisu: ADF 2018.103

This documentation only covers the latest version of the software.

*   [Key features in ADF 2018](https://www.scm.com/support/release-notes/)
*   [Release notes of  version 2018](http://www.scm.com/support/release-notes/)

* * *

##### Versions for Workstations

* * *

### Usage

In order to set the interactive ADF environment  issue the command:

    module load adf/2018.103

**Taito**

If you want to use the  ADF  GUI's (adfinput , adfview etc.) it is recommended to run these on the compute nodes

    salloc -p serial -n 1 -t 02:00:00 srun --x11=first adfview

To perform an ADF calculation, you need to prepare a batch job file. There is no difference between a parallel or serial (1 CPU) job, however, except for the number of allocated CPU's, of course. The example below shows one geometry optimization cycle of Tetrapropylammonium (TPA) in a ZSM-5 channel.  
  
Sample [job-adf18-taito.job](http://extras.csc.fi/chem/progs/adf/job-adf18-taito.job) for Taito.  
  
Submit the job with:

    sbatch job-adf18-taito.job

**Sisu**

Sample [job-adf18-sisu.job](http://extras.csc.fi/chem/progs/adf/job-adf18-sisu.job) for Sisu.  
  
Submit the job with:

    sbatch job-adf18-sisu.job

* * *

### Discipline

Chemistry  

* * *

### References

For calculations with the molecular ADF program, version 2017:

G.te Velde, F.M. Bickelhaupt, E.J. Baerends, C. Fonseca Guerra, S.J.A. van Gisbergen, J.G. Snijders and T. Ziegler, _Chemistry with ADF_, [Journal of Computational Chemistry 22, 931 (2001)](http://dx.doi.org/10.1002/jcc.1056)

C.Fonseca Guerra, J.G. Snijders, G. te Velde and E.J. Baerends, _Towards an order-N DFT method_, [Theoretical Chemistry Accounts 99, 391 (1998)](http://dx.doi.org/10.1007/s002140050353)

ADF2017, SCM, Theoretical Chemistry, Vrije Universiteit, Amsterdam, The Netherlands, [http://www.scm.com](http://www.scm.com). Optionally, you may add the following list of authors and contributors: E.J. Baerends, T. Ziegler, A.J. Atkins, J. Autschbach, O. Baseggio, D. Bashford, A. Bérces, F.M. Bickelhaupt, C. Bo, P.M. Boerrigter, L. Cavallo, C. Daul, D.P. Chong, D.V. Chulhai, L. Deng, R.M. Dickson, J.M. Dieterich, D.E. Ellis, M. van Faassen, L. Fan, T.H. Fischer, C. Fonseca Guerra, M. Franchini, A. Ghysels, A. Giammona, S.J.A. van Gisbergen, A. Goez, A.W. Götz, J.A. Groeneveld, O.V. Gritsenko, M. Grüning, S. Gusarov, F.E. Harris, P. van den Hoek, Z. Hu, C.R. Jacob, H. Jacobsen, L. Jensen, L. Joubert, J.W. Kaminski, G. van Kessel, C. König, F. Kootstra, A. Kovalenko, M.V. Krykunov, E. van Lenthe, D.A. McCormack, A. Michalak, M. Mitoraj, S.M. Morton, J. Neugebauer, V.P. Nicu, L. Noodleman, V.P. Osinga, S. Patchkovskii, M. Pavanello, C.A. Peeples, P.H.T. Philipsen, D. Post, C.C. Pye, H. Ramanantoanina, P. Ramos, W. Ravenek, J.I. Rodríguez, P. Ros, R. Rüger, P.R.T. Schipper, D. Schlüns, H. van Schoot, G. Schreckenbach, J.S. Seldenthuis, M. Seth, J.G. Snijders, M. Solà, M. Stener, M. Swart, D. Swerhone, V. Tognetti, G. te Velde, P. Vernooijs, L. Versluis, L. Visscher, O. Visser, F. Wang, T.A. Wesolowski, E.M. van Wezenbeek, G. Wiesenekker, S.K. Wolff, T.K. Woo, A.L. Yakovlev

[Detailed instructions on how to properly cite results obtained with the ADF/BAND package.](http://www.scm.com/Doc/Doc2014/Background/References/page1.html)

* * *

### Support

* * *

### Manual

*   The ADF and BAND manuals are available in different formats online:
    *   [Online docs](http://www.scm.com/Doc/Doc2014/)
*   [Course material from the ADF course at CSC, 2006](http://extras.csc.fi/chem/progs/adf/ADF-course-2006-Patzschke.pdf). Courtesy of Dr. Michael Patzschke.
*   Additional information can be found at the [ADF home page](http://www.scm.com/).
*   There is also a [mailing list](http://lists.scm.com/pipermail/adflist/) for ADF and BAND.

#### Licensing restrictions

*   You may use the Software exclusively for non-profit research purposes.
*   Only users from academic (i.e. degree-granting) institutes are allowed to use the Software
*   Please read the ADF/BAND standard [End User License Agreement (EULA)](http://www.scm.com/Sales/LicAgreement.html) for a complete description

* * *