## Molden

### Description

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

-   Taito: 5.8

------------------------------------------------------------------------

### Usage

**Taito**

Use -X or -Y options with ssh command to enable X11 forwarding. For
Example:

`ssh -Y username@taito-shell.csc.fi`

Load Molden module file:

`module load molden`

`molden`

It is recommended to run Molden interactively i.e. use  [Taito-shell].

Some X-windows (X11) windowing software is needed. The recommended
option is to use the [NoMachine] remote desktop service which will
improve remote performance on both Windows and Linux. With NoMachine you
can select Molden directly from the application list with a mouse (right
click, taito, applications, chemistry, molden).

**Features**

-   Molecule builder/Z-matrix editor (different formats: Gaussian,
    Gamess, cartesian...).
-   Molden can utilize [Tinker] to preoptimize molecular structure.
-   Molden can  visualize  computational results from many software
    packages: Gaussian, Molpro, Turbomole, Gamess...
-   Full list of Molden features  can be found from  [Molden  web page].

------------------------------------------------------------------------

### Discipline

Chemistry  

------------------------------------------------------------------------

### References

-   Full list of Molden features  can be found from  [Molden  web page].

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [Taito-shell]: https://research.csc.fi/taito-shell-user-guide
  [NoMachine]: http://www.csc.fi/english/research/software/freenx
    "NoMachine/FreeNX"
  [Tinker]: http://www.csc.fi/english/research/software/tinker-42
  [Molden  web page]: http://www.cmbi.ru.nl/molden/molden.html
