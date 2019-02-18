## TauDEM

### Description

**TauDEM**    (**T**errain    **A**nalysis    **U**sing    **D**igital
**E**levation **M**odels) is a suite  of Digital Elevation Model (DEM)
tools for the  extraction and analysis of  hydrologic information from
topography  as represented  by a  DEM. TauDEM  provides the  following
capability:

-   Development of hydrologically conditioned (pit removed) DEMs using
    the flooding approach
-   Calculates flow paths (directions) and slopes
-    Calculates  contributing  area  using single  and  multiple  flow
    direction methods
-   Multiple methods for the  delineation of stream networks including
    topographic  form-based methods  sensitive  to spatially  variable
    drainage density
-    Objective  methods  for  determination  of  the  channel  network
    delineation threshold based on stream drops
-    Delineation  of watersheds  and  subwatersheds  draining to  each
    stream  segment  and  association between  watershed  and  segment
    attributes for setting up hydrologic models
-   Specialized functions for terrain analysis, including:
    -    Calculates the  slope/area ratio  that is  the basis  for the
        topographic wetness index
    -   Calculates both the distance up  to ridges and down to streams
        in horizontal, vertical, along slope and direct variants
    -   Maps  locations upslope where  activities have an effect  on a
        downslope location
    -   Evaluates upslope contribution subject to decay or attenuation
    -    Calculates  accumulation  where  the  uptake  is  subject  to
        concentration limitations
    -    Calculates  accumulation  where  the  uptake  is  subject  to
        transport limitations
    -   Evaluates reverse accumulation
    -   Evaluates potential avalanche runout areas

For                  more                   info                  see:
<http://hydrology.usu.edu/taudem/taudem5/index.html>

**Most of the TauDEM functions make good use of several CPUs.**

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 5.3.8

------------------------------------------------------------------------

### Usage

First load Taudem  as part of geo-env module  (includes other software
as well)

`module load geo-env`

 

**Taudem command-line tools**

Taudem  includes several  commandline  tools, which  are described  in
detail on  [Taudem's documentation].  (Please note  that all  names of
tools are in lower  case in Taito, in documentation there  is a mix of
lower and upper case.)

Example of running a Taudem command:

`dinfflowdir   -fel    L4213_no_pit.tif   -slp    L4213_slp.tif   -ang
L4213_ang.tif`

For  parallel execution  add srun  command  and define  the number  of
processes  to  use with  -n  parameter.  For  example to  create  flow
direction and slope using dinf algorithm in 4 parallel processes:

`srun -n  4 dinfflowdir -fel L4213_no_pit.tif  -slp L4213_slp.tif -ang
L4213_ang.tif`

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [Taudem's documentation]: http://hydrology.usu.edu/taudem/taudem5/documentation.html
