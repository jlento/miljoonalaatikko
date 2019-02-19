## GeoPython

### Description

Geopython is a collection of python packages that facilitate the
development of python scripts for geoinformatics applications. It
includes following python packages:

-   [descartes] - use Shapely or GeoJSON-like geometric objects as
    matplotlib paths and patches.
-   [fiona] - reads and writes spatial data files.
-   [gdal] - reads and writes spatial data files, and GDAL/OGR data
    manipulation tools.
-   [geopandas] - GeoPandas extends the datatypes used by [pandas.]
-   [networkx] - for the creation, manipulation, and study of the
    structure, dynamics, and functions of complex networks.
-   [pyproj] - performs cartographic transformations and geodetic
    computations.
-   osgeo - used currently only for gdal.
-   [pysal] - spatial analysis functions.
-   [rasterio] - access to geospatial raster data.
-   [rasterstats] - for summarizing geospatial raster datasets based on
    vector geometries. It includes functions for zonal statistics and
    interpolated point queries.
-   [rtree] - spatial indexing and search.
-   [shapely] - manipulation and analysis of geometric objects in the
    Cartesian plane.
-   <span id="yui_patched_v3_11_0_1_1503314242269_554">[skimage] -
    algorithms for image processing.</span>

GeoPython module is build on top of Taito's [python-env/2.7.10 module].
See that page for packages included in the basic module and how to
install your own packages.

Python has also packages for parallel computing, for example
**multiprocessing**. In our examples there is two cases using Python
multiprocessing: [zonal statistics] and [focal mean].

If you want to use Python3, cartopy package and/or Spyder IDE, see also
[Geoconda] module.

(If you think that some important GIS package for python is missing from
here, you can ask for installation from servicedesk@csc.fi.)

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: Python-2.7.10

------------------------------------------------------------------------

### Usage

To use geopython in Taito, load first the [geo-env] module, which
includes **Python** with GIS packages, GDAL, QGIS and LasTools.

    module load geo-env

The module unloads all previously loaded modules, so it should be loaded
first, if you need to load also some other modules.

After this you can launch your python program with command

`python my_geopython_code.py`

For running your script via batch job system, use:

`srun python my_geopython_code.py`

Alternatively you can change the python definition in the first line of
your code to `#!/bin/env python`

and execute the python program

`./my_geopython_code.py`

 

## Example scripts: {#yui_patched_v3_11_0_1_1503314242269_1145}

Gis related example python scripts and how to run them in Taito can be
found at [CSC-Training github page.]

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

[Python spatial] kirjastot.

-   [Essential Python Geospatial Libraries]
-   [Geoprocessing with Python using Open Source GIS]
-   <span id="yui_patched_v3_11_0_1_1502174857789_709">[GeoExamples], a
    lot of examples of using Python for spatial analysis</span>
-   [Automating GIS processes course] materials, where most of the
    exercises are done using Python (University of Helsinki)
-    
-   [Multiprocessing Basics]

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [descartes]: https://pypi.python.org/pypi/descartes
  [fiona]: https://pypi.python.org/pypi/Fiona
  [gdal]: https://pypi.python.org/pypi/GDAL
  [geopandas]: http://geopandas.org/
  [pandas.]: http://pandas.pydata.org {.reference .external}
  [networkx]: https://networkx.github.io/
  [pyproj]: https://pypi.python.org/pypi/pyproj?
  [pysal]: http://pysal.readthedocs.io/en/latest/
  [rasterio]: https://mapbox.github.io/rasterio/
  [rasterstats]: http://pythonhosted.org/rasterstats/
  [rtree]: http://toblerity.org/rtree/
  [shapely]: https://pypi.python.org/pypi/Shapely
  [skimage]: http://scikit-image.org/
  [python-env/2.7.10 module]: https://research.csc.fi/-/python
  [zonal statistics]: https://github.com/csc-training/geocomputing/tree/master/python/zonal_stats
  [focal mean]: https://github.com/csc-training/geocomputing/tree/master/python/focal_mean
  [Geoconda]: https://research.csc.fi/-/geoconda
  [geo-env]: https://research.csc.fi/-/geo-env
  [CSC-Training github page.]: https://github.com/csc-training/geocomputing/tree/master/python
  [Python spatial]: https://github.com/SpatialPython/spatial_python/blob/master/packages.md
  [Essential Python Geospatial Libraries]: http://spatialdemography.org/essential-python-geospatial-libraries/
  [Geoprocessing with Python using Open Source GIS]: http://www.gis.usu.edu/%7Echrisg/python/2009/
  [GeoExamples]: http://geoexamples.blogspot.fi/
  [Automating GIS processes course]: http://Automating%20GIS%20processes%20course
  [Multiprocessing Basics]: https://pymotw.com/2/multiprocessing/basics.html
