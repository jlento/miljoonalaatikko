## geo-env

### Description

This is an convenience module for loading easily Python and spatial analysis tools. It loads the following software:

*   [GeoPython](https://research.csc.fi/-/geopython) (2.7.10)
*   [GDAL/OGR](https://research.csc.fi/-/gdal-o-1) (2.2.1), [Proj4](https://research.csc.fi/-/proj4) (4.9.3)
*   GEOS (3.6.1)
*   [QGIS](https://research.csc.fi/-/qgis) (2.18.11)
*   [LasTools](https://research.csc.fi/-/lastools)
*   [PDAL](https://research.csc.fi/-/pdal) (1.5.0)
*   [Taudem](https://research.csc.fi/-/taudem) (5.3.8)
*   [Zonation](https://research.csc.fi/-/zonation) (4.0.0)

* * *

### Available

### Usage

If you want to use QGIS, Saga GIS or GRASS with GUI, you should connect to taito-shell using [\-X connection or NoMachine for Windows users](https://research.csc.fi/csc-guide-connecting-the-servers-of-csc).

In Taito and Taito-shell, to load:

    module load geo-env

Please note that execution of the command unloads all current modules. Thus, if you want to use also some other software, these modules must be loaded after geo-env.

Comments:

*   You can use both _GRASS_ and _SagaGIS_ together with geo-env, but only one of them at a time, because they have conflicting dependencies.
*   It is not possible to use _rspatial-env_ together with geo-env.

* * *

### Discipline

Geosciences  

* * *

### References

* * *

### Support

* * *

### Manual

* * *