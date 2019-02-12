## GDAL/OGR

### Description

GDAL/OGR library is for accessing and transforming raster and vector data. Enables for example format and coordinate system changes. Includes also command-line binaries, no GUI.

* * *

### Available

##### Version on CSC's Servers

Taito: 2.2.1, 2.0.1, 1.11.1, 1.10.1.

Only 2.2.1 supports xx.py tools and has also wider formats support than others.

* * *

### Usage

First load appropriate module. There is three options for that:

1) If you want to use GDAL 2.2.1 stand-alone or with Python, QGIS or LasTools, use [geo-env](https://research.csc.fi/-/geo-env), which includes **Python** with GIS packages, GDAL, QGIS and LasTools.  It does not include Saga GIS directly, but Saga can be easily added like this:

    module load geo-env

2) If you want to use rgdal (R), please see [rspatial-env](https://research.csc.fi/-/rspatial-env) page for details.

3) If you want to use plain GDAL or some older version of GDAL, you should load all the needed modules explicitly. For GDAL/2.2.1 these:

    module load gcc/4.9.3 hdf5-serial/1.8.15 netcdf4-serial/4.3.3.1 sqlite/3.19.3 proj4/4.9.3 geos/3.6.1 spatialite/4.3.0 mysql hdf4/4.2.13 gdal/2.2.1

For GDAL/2.0.1:

        module load gdal/2.0.1

For GDAL/1.11.1:

        module load gdal/1.11.1

For GDAL 1.10.1:

        module load gcc/4.7.2 gdal/1.10.1

Both of the xx-env modules unload all previously loaded modules, so they should be loaded first, if you need to load also some other modules. They also load only GDAL/2.2.1

Then you can use the GDAL command-line utilities, for example

    gdalinfo example.tif

For processing a lot of files, so that processing order of files is not important, please use [array jobs](https://research.csc.fi/taito-array-jobs).

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

*   [GDAL utilities](http://www.gdal.org/gdal_utilities.html) (raster data)
*   [OGR utilities](http://www.gdal.org/ogr_utilities.html) (vector data)
*   [Examples in Finnish](https://research.csc.fi/gdal_ogr) (CSC)

Main GDAL raster formats supported:

  ECW -raster- (rw): ERDAS Compressed Wavelets (SDK 3.x)  
  EIR -raster- (rov): Erdas Imagine Raw  
  ENVI -raster- (rw+v): ENVI .hdr Labelled  
  ERS -raster- (rw+v): ERMapper .ers Labelled  
  ESAT -raster- (rov): Envisat Image Format  
  FAST -raster- (rov): EOSAT FAST Format  
  GIF -raster- (rwv): Graphics Interchange Format (.gif)  
  GPKG -raster,vector- (rw+vs): GeoPackage  
  GRASSASCIIGrid -raster- (rov): GRASS ASCII Grid  
  GRIB -raster- (rov): GRIdded Binary (.grb)  
  GTiff -raster- (rw+vs): GeoTIFF  
  HDF4 -raster- (ros): Hierarchical Data Format Release 4  
  HDF4Image -raster- (rw+): HDF4 Dataset  
  HDF5 -raster- (ros): Hierarchical Data Format Release 5  
  HDF5Image -raster- (ro): HDF5 Dataset  
  HFA -raster- (rw+v): Erdas Imagine Images (.img)  
  JP2ECW -raster,vector- (rw+v): ERDAS JPEG2000 (SDK 3.x)  
  JP2MrSID -raster- (rov): MrSID JPEG2000  
  JPEG -raster- (rwv): JPEG JFIF  
  JPEG2000 -raster,vector- (rwv): JPEG-2000 part 1 (ISO/IEC 15444-1), based on Jasper library  
  MrSID -raster- (rov): Multi-resolution Seamless Image Database (MrSID)  
  netCDF -raster,vector- (rw+s): Network Common Data Format    
  PNG -raster- (rwv): Portable Network Graphics  
  PostGISRaster -raster- (rws): PostGIS Raster driver  
  R -raster- (rwv): R Object Data Store  
  RRASTER -raster- (rov): R Raster  
  SAGA -raster- (rw+v): SAGA GIS Binary Grid (.sdat)  
  SENTINEL2 -raster- (rovs): Sentinel 2  
  WCS -raster- (rovs): OGC Web Coverage Service  
  WMS -raster- (rwvs): OGC Web Map Service  
  WMTS -raster- (rwv): OGC Web Mab Tile Service  
  XYZ -raster- (rwv): ASCII Gridded XYZ

... and more, see the full list in Taito, with gdalinfo --formats

Main OGR vector formats supported:

  CAD -raster,vector- (rovs): AutoCAD Driver  
  CSV -vector- (rw+v): Comma Separated Value (.csv)  
  Carto -vector- (rw+): Carto  
  DGN -vector- (rw+): Microstation DGN  
  DXF -vector- (rw+v): AutoCAD DXF  
  ESRI Shapefile -vector- (rw+v): ESRI Shapefile  
  ElasticSearch -vector- (rw+): Elastic Search  
  GFT -vector- (rw+): Google Fusion Tables  
  GML -vector- (rw+v): Geography Markup Language (GML)  
  GPKG -raster,vector- (rw+vs): GeoPackage  
  GPSBabel -vector- (rw+): GPSBabel  
  GPSTrackMaker -vector- (rw+v): GPSTrackMaker  
  GPX -vector- (rw+v): GPX  
  GeoJSON -vector- (rw+v): GeoJSON  
  GeoRSS -vector- (rw+v): GeoRSS  
  JP2ECW -raster,vector- (rw+v): ERDAS JPEG2000 (SDK 3.x)  
  JPEG2000 -raster,vector- (rwv): JPEG-2000 part 1 (ISO/IEC 15444-1), based on Jasper library  
  KML -vector- (rw+v): Keyhole Markup Language (KML)  
  MSSQLSpatial -vector- (rw+): Microsoft SQL Server Spatial Database  
  MapInfo File -vector- (rw+v): MapInfo File  
  MySQL -vector- (rw+): MySQL  
  netCDF -raster,vector- (rw+s): Network Common Data Format    
  ODBC -vector- (rw+): ODBC  
  ODS -vector- (rw+v): Open Document/ LibreOffice / OpenOffice Spreadsheet  
  OSM -vector- (rov): OpenStreetMap XML and PBF  
  OpenFileGDB -vector- (rov): ESRI FileGDB  
  PDF -raster,vector- (w+): Geospatial PDF  
  PGDUMP -vector- (w+v): PostgreSQL SQL dump  
  PGeo -vector- (ro): ESRI Personal GeoDatabase  
  PostgreSQL -vector- (rw+): PostgreSQL/PostGIS  
  SQLite -vector- (rw+v): SQLite / Spatialite  
  SVG -vector- (rov): Scalable Vector Graphics  
  WFS -vector- (rov): OGC WFS (Web Feature Service)  
  XLSX -vector- (rw+v): MS Office Open XML spreadsheet

... and more, see the full list in Taito, with ogrinfo --formats

* * *