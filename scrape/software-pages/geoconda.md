## Geoconda

### Description

Geoconda  includes Python  GIS packages  and enables  users easily  to
install new  Python packags for  their own  use. It is  an alternative
installation to the [GeoPython] module.

[Conda] is  a package management tool  that is used to  distribute and
install  software tools  together  with  their dependencies.  Geoconda
installation is done with miniconda3, it includes **Python3**

Geoconda  is  a collection  of  python  packages that  facilitate  the
development  of python  scripts  for  geoinformatics applications.  It
includes following python packages (mostly the same as [GeoPython]):

-   [cartopy] - for map plotting (not included in GeoPython).
-   [descartes]  - use  Shapely or  GeoJSON-like geometric  objects as
    matplotlib paths and patches.
-   **[fiona]** - reads and writes spatial data files.
-   [gdal]  - reads and writes  spatial data files, and  GDAL/OGR data
    manipulation tools.
-    [geoalchemy2] (only  in  geoconda/3.7) -  provides extensions  to
    [SQLAlchemy] for working with spatial databases, primarly PostGIS.
-    **[geopandas]**  -  GeoPandas   extends  the  datatypes  used  by
    [pandas.]
-   [laspy] - reading and writing .las and .laz files.
-    [networkx] -  for the  creation, manipulation,  and study  of the
    structure, dynamics, and functions of complex networks.
-   [pyfor] - lidar analysis for forestry purposes.
-    [pyproj] -  performs  cartographic  transformations and  geodetic
    computations.
-   **[pysal]** - spatial analysis functions.
-   [osmnx] (only  in geoconda/3.7) - download  spatial geometries and
    construct, project,  visualize, and  analyze street  networks from
    OpenStreetMap's APIs.
-   **[rasterio]** - access to geospatial raster data.
-   [rasterstats]  - for summarizing geospatial  raster datasets based
    on vector  geometries. It includes functions  for zonal statistics
    and interpolated point queries.
-   [rtree] - spatial indexing and search.
-   [shapely] - manipulation and  analysis of geometric objects in the
    Cartesian plane.
-    <span   id="yui_patched_v3_11_0_1_1503314242269_554">[skimage]  -
    algorithms for image processing.</span>
-    [scikit-learn]  (only in  geoconda/3.7)  -  machine learning  for
    Python.
-   And many  more, for retrieving the full list  in Taito use: `conda
    list`
-   ([pdal] package is available only with [GeoPython])
-   ([snappy] has its own conda environment, see [SNAP])

Additionally geoconda includes:

-    [spyder]   -  Scientific  PYthon  Development   EnviRonment  with
    graphical interface (similar to RStudio for R). If you want to use
    Spyer, you should  connect to taito-shell using  [-X connection or
    NoMachine for Windows users].
-   GDAL/OGR commandline tools and proj
-   And  many more,  see /appl/earth/geoconda/miniconda3/bin  for full
    list.

Python  has   also  packages  for  parallel   computing,  for  example
**multiprocessing**. In our  examples there is two  cases using Python
multiprocessing: [zonal statistics] and [focal mean].

If you want to use Python2, see also [GeoPython] module.

Geoconda  can not  be used  simultaneously with  [geo-env] (GeoPython)
module

(If you  think that some important  GIS package for Python  is missing
from here, you can ask for installation from servicedesk@csc.fi.)

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 3.6, 3.7 (version number is the same as Python version)

------------------------------------------------------------------------

### Usage

**1. Using packages installed by CSC**

To use software  environments that are installed to  Taito using Conda
(either by CSC or yourself),  first load geoconda module:

    module load geoconda

This loads latest geoconda module. If  you want a specific version you
can do:

    module load geoconda/VERSION

After   that  you   can  use   Python  with   GIS  packages   as  with
[GeoPython.][GeoPython]

For using the Spyder IDE give:

`spyder`

 

**2. Adding more Python packages to packages included in GeoConda**

You can add  more packages to your  own use, the details  can be found
from [Python] documention.

The   packages   are   installed   to  your   home   directory   under
`.local/lib/python3.6 or .local/lib/python3.7`

The packages installed  for GeoPython are not  available together with
GeoConda Python because of different Python versions.

 

**3. Installing software for your own use with geoconda**

You can use  the geoconda module to install software  to your personal
Conda environments. Please see  [Conda environments] documentation for
details  and CSC  [Bioconda] documentation  for example.  The personal
Conda  environment  does not  include  software  included in  GeoConda
environment.  The software is installed to:

`/wrk/your_user_name/DONOTREMOVE/geoconda3_env`

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

-   [Conda home page][Conda]

[Python spatial] kirjastot.

-   [Essential Python Geospatial Libraries]
-   [Geoprocessing with Python using Open Source GIS]
-    <span id="yui_patched_v3_11_0_1_1502174857789_709">[GeoExamples],
    a lot of examples of using Python for spatial analysis</span>
-   [Automating  GIS processes  course materials],  where most  of the
    exercises are done using Python (University of Helsinki)
-   [Geohack Week materials]
-   [Multiprocessing Basics]

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [GeoPython]: https://research.csc.fi/-/geopython
  [Conda]: https://conda.io/docs/
  [cartopy]: http://scitools.org.uk/cartopy/
  [descartes]: https://pypi.python.org/pypi/descartes
  [fiona]: https://pypi.python.org/pypi/Fiona
  [gdal]: https://pypi.python.org/pypi/GDAL
  [geoalchemy2]: https://geoalchemy-2.readthedocs.io/en/latest/
  [SQLAlchemy]: http://sqlalchemy.org {.reference .external}
  [geopandas]: http://geopandas.org/
  [pandas.]: http://pandas.pydata.org {.reference .external}
  [laspy]: https://github.com/laspy/laspy
  [networkx]: https://networkx.github.io/
  [pyfor]: https://github.com/brycefrank/pyfor
  [pyproj]: https://pypi.python.org/pypi/pyproj?
  [pysal]: http://pysal.readthedocs.io/en/latest/
  [osmnx]: https://osmnx.readthedocs.io/en/stable/index.html
  [rasterio]: https://mapbox.github.io/rasterio/
  [rasterstats]: http://pythonhosted.org/rasterstats/
  [rtree]: http://toblerity.org/rtree/
  [shapely]: https://pypi.python.org/pypi/Shapely
  [skimage]: http://scikit-image.org/
  [scikit-learn]: https://scikit-learn.org/stable/
  [pdal]: https://github.com/PDAL/python
  [snappy]: https://senbox.atlassian.net/wiki/spaces/SNAP/pages/19300362/How+to+use+the+SNAP+API+from+Python
  [SNAP]: https://research.csc.fi/-/snap
  [spyder]: https://pythonhosted.org/spyder/
  [-X connection or NoMachine for Windows users]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc
  [zonal statistics]: https://github.com/csc-training/geocomputing/tree/master/python/zonal_stats
  [focal mean]: https://github.com/csc-training/geocomputing/tree/master/python/focal_mean
  [geo-env]: https://research.csc.fi/-/geo-env
  [Python]: https://research.csc.fi/-/python
  [Conda environments]: https://conda.io/docs/user-guide/tasks/manage-environments.html#
  [Bioconda]: https://research.csc.fi/-/bioconda
  [Python spatial]: https://github.com/SpatialPython/spatial_python/blob/master/packages.md
  [Essential Python Geospatial Libraries]: http://spatialdemography.org/essential-python-geospatial-libraries/
  [Geoprocessing with Python using Open Source GIS]: http://www.gis.usu.edu/%7Echrisg/python/2009/
  [GeoExamples]: http://geoexamples.blogspot.fi/
  [Automating GIS processes course materials]: https://automating-gis-processes.github.io
  [Geohack Week materials]: https://geohackweek.github.io/schedule.html
  [Multiprocessing Basics]: https://pymotw.com/2/multiprocessing/basics.html
