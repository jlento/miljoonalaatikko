## ORCA

### Description

ORCA is a flexible, efficient and easy-to-use general purpose tool for
quantum chemistry  with specific emphasis on  spectroscopic properties
of  open-shell  molecules. It  features  a  wide variety  of  standard
quantum chemical methods ranging from  semiempirical methods to DFT to
single- and multireference  correlated ab initio methods.  It can also
treat environmental  and relativistic  effects. For  more information,
see
<https://orcaforum.cec.mpg.de/>  
 

ORCA users should register, agree to the EULA , download and install a
private copy of the program (via <https://orcaforum.cec.mpg.de/> )

1.  **Transfer the downloaded file to Taito**
2.  **Unpack the program to $USERAPPL**
    -   **tar xf orca\_4\_0\_1\_2\_linux\_x86-64\_openmpi202.tar.xz -C
        $USERAPPL**  
         

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito: 4.0.1.2
-   Taito: 3.0.3

------------------------------------------------------------------------

### Usage

`module load orca-env/4.0.1.2 `  
  
An example job file can be copied from /appl/chem/orca/orca\_4.1.job
(orca\_4.1.inp) .  
Please remember to  adjust %pal nproc in your input  file according to
the  --ntasks in your jobfile

------------------------------------------------------------------------

### Discipline

Chemistry  

------------------------------------------------------------------------

### References

The generic reference for ORCA is:  
Neese, F.  (2012) The  ORCA program  system, Wiley  Interdiscip. Rev.:
Comput. Mol. Sci., 2, 73-78.

Please do not only cite the above generic reference, but also cite in
addition the original  
papers that report the development and ORCA implementation of the
methods you have used in  
your studies! The publications that describe the functionality
implemented in ORCA are  
given in the manual (pages 756-782)

 

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

####  

-   ORCA Forum <https://orcaforum.cec.mpg.de/>
-   ORCA Manual <https://orcaforum.cec.mpg.de/OrcaManual.pdf>
-   The installation at CSC is provided on "as is" basis.

------------------------------------------------------------------------
