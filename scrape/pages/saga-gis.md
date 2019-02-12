## SAGA GIS

### Description

SAGA - System for Automated Geoscientific Analyses is a GIS software designed for easy implementation of spatial algorithms. It can be used with its own graphic interface, from command line or through an API. SAGA can be integrated with R language using RSAGA library in R.

Some SagaGIS functions seem to support parallel computing, but there is no documentation which these are. So trying and testing is the only way to find out.. In Taito-shell SagaGIS uses all available cores by default.

* * *

### Available

##### Version on CSC's Servers

*   2.1.4 on Taito
*   5.0.0 on Taito

* * *

### Usage

If you want to use Saga GIS with GUI, you should connect to taito-shell using [\-X connection or NoMachine for Windows users](https://research.csc.fi/csc-guide-connecting-the-servers-of-csc).

First load appropriate module. There is four options for that:

1) If you want to use SagaGIS 5.0.00 stand-alone, you can open Saga-GIS from NoMachine's Fluxbox menu (right-click to open): Applications -> Taito-shell -> GIS -> SagaGIS. This loads in the background the same modules as option 2.

2) If you want to use SagaGIS 5.0.00 stand-alone or with Python or QGIS, you can use [geo-env](https://research.csc.fi/-/geo-env), which includes **Python** with GIS packages, GDAL, QGIS and LasTools.  It does not include Saga GIS directly, but Saga can be easily added like this:

    module load geo-env wxwidgets saga/5.0.0

3) If you want to use RSAGA, please see [rspatial-env](https://research.csc.fi/-/rspatial-env) page for details.

4) If you want to use plain SagaGIS, with minial extra libraries loaded, you shoud load the following for SAGA 5.0.0:

    module load gcc/4.9.3 hdf5-serial/1.8.15 netcdf4-serial/4.3.3.1 sqlite/3.19.3 proj4/4.9.3 geos/3.6.1 spatialite/4.3.0 gdal/2.2.1 wxwidgets/3.0.2 saga/5.0.0

And this for SAGA 2.1.4

        module load proj4/4.9.1 geos/3.4.2 gdal/1.11.1  wxwidgets    /3.0.2     saga/2.1.4

Both of the xx-env modules unload all previously loaded modules, so they should be loaded first, if you need to load also some other modules.

Comments

*   SagaGIS and GRASS GIS use different versions of wxwidgets library, which is used for the GUI. So if you would like to use both GUIs please open two sessions to Taito-shell.

 

Now it is possible to run **saga\_cmd** or **saga\_gui**.

Note: If some tools seem to be missing they can be loaded with from Geoprocessing->Load Tool Library. Tool libraries are located at /appl/earth/saga/5.0.0/lib/saga.

* * *

### Discipline

Geosciences  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

*   [SAGA web site](http://www.saga-gis.org/)
*   [RSAGA project page](http://cran.r-project.org/web/packages/RSAGA/index.html)

* * *