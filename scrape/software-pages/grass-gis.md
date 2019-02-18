## GRASS GIS

### Description

GRASS  GIS,  commonly  referred  to  as  GRASS  (Geographic  Resources
Analysis  Support  System),  is  a free  and  open  source  Geographic
Information  System  (GIS) software  suite  used  for geospatial  data
management  and   analysis,  image   processing,  graphics   and  maps
production, spatial modeling, and visualization.

GRASS GIS  has limited  support for [Parallel  GRASS jobs].  Also some
[script  examples]  of running  several  GRASS  jobs in  parallel  are
available. [PyGRASS] includes  also `ParallelModuleQueue` for parallel
computing, see our example about [that].

------------------------------------------------------------------------

### Available

### Usage

If you want to use GRASS  GUI, you should connect to taito-shell using
[-X connection or NoMachine for Windows users].

First load appropriate module. There are three options for that:

1) If you want  to use GRASS GUI, you can  open GRASS from NoMachine's
Fluxbox  menu (right-click  to open):  Applications -&gt;  Taito-shell
-&gt;  GIS -&gt;  GRASS-GIS. This  loads  in the  background the  same
modules as option 2.

2)  If you  want  to use  GRASS  as stand-alone  or  with Python,  use
[geo-env], which includes **Python** with GIS packages, GDAL, QGIS and
LasTools. It  does not include  GRASS GIS  directly, but GRASS  can be
easily added like this:

    module load geo-env grass

3)  If you  want to  use  GRASS GIS  with  R, without  GRASS GUI,  use
[rspatial-env],which includes **R**, GDAL, GRASS and SagaGIS.

    module load rspatial-env

Both of  the xx-env modules  unload all previously loaded  modules, so
they  should be  loaded first,  if you  need to  load also  some other
modules.

\* SagaGIS and GRASS GIS  use different versions of wxwidgets library,
which is  used for  the GUI.  So if you  would like  to use  both GUIs
please open two sessions to Taito-shell.

Then for starting the GRASS GUI:

`grass72`

It is possible to also use GRASS functionality via command-line, shell
scripts or Python code, see [GRASS manual] for details.

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

-   [GRASS GIS documentation]
-   [Shell scripting with GRASS]

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------

  [Parallel GRASS jobs]: http://grasswiki.osgeo.org/wiki/Parallel_GRASS_jobs
  [script examples]: http://grasswiki.osgeo.org/wiki/Parallelizing_Scripts
  [PyGRASS]: https://grass.osgeo.org/grass75/manuals/libpython/pygrass.modules.interface.html?highlight=parallelmodulequeue#pygrass.modules.interface.module.ParallelModuleQueue
  [that]: https://github.com/csc-training/geocomputing/tree/master/python/grass_multiprocessing_with_python
  [-X connection or NoMachine for Windows users]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc
  [geo-env]: https://research.csc.fi/-/geo-env
  [rspatial-env]: https://research.csc.fi/-/rspatial-env
  [GRASS manual]: https://grass.osgeo.org/grass72/manuals/grass7.html
  [GRASS GIS documentation]: https://grass.osgeo.org/documentation/
  [Shell scripting with GRASS]: https://grasswiki.osgeo.org/wiki/GRASS_and_Shell
