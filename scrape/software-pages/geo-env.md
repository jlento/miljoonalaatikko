## geo-env

### Description

This is an convenience module for loading easily Python and spatial
analysis tools. It loads the following software:

-   [GeoPython] (2.7.10)
-   [GDAL/OGR] (2.2.1), [Proj4] (4.9.3)
-   GEOS (3.6.1)
-   [QGIS] (2.18.11)
-   [LasTools]
-   [PDAL] (1.5.0)
-   [Taudem] (5.3.8)
-   [Zonation] (4.0.0)

------------------------------------------------------------------------

### Available

### Usage

If you want to use QGIS, Saga GIS or GRASS with GUI, you should connect
to taito-shell using [-X connection or NoMachine for Windows users].

In Taito and Taito-shell, to load:

`module load geo-env`

Please note that execution of the command unloads all current modules.
Thus, if you want to use also some other software, these modules must be
loaded after geo-env.

Comments:

-   You can use both *GRASS* and *SagaGIS* together with geo-env, but
    only one of them at a time, because they have conflicting
    dependencies.
-   It is not possible to use *rspatial-env* together with geo-env.

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

  [GeoPython]: https://research.csc.fi/-/geopython
  [GDAL/OGR]: https://research.csc.fi/-/gdal-o-1
  [Proj4]: https://research.csc.fi/-/proj4
  [QGIS]: https://research.csc.fi/-/qgis
  [LasTools]: https://research.csc.fi/-/lastools
  [PDAL]: https://research.csc.fi/-/pdal
  [Taudem]: https://research.csc.fi/-/taudem
  [Zonation]: https://research.csc.fi/-/zonation
  [-X connection or NoMachine for Windows users]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc
