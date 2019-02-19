## QGIS

### Description

QGIS is a general GIS desktop software for viewing, modifying, analyzing
and visualizing spatial data. Supports a very wide range of vector and
raster formats, also WMS, WMTS, WCS and WFS. QGIS can connect to
PostGIS, Oracle, SpatiaLite and MSSql. There are a lot plug-ins, for
extended functionality. It is possible to use functionality of GRASS,
SAGA and R via QGIS user interface..

In Taito it could be used for visualizing computing results locally.

-   Includes grass, taudem and open source lastools processing tools.
-   Supports parallel rendering of layers, so feels more responsive when
    using multiple or large layers.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.18.11

------------------------------------------------------------------------

### Usage

If you want to use QGIS GUI, you should connect to taito-shell using [-X
connection or NoMachine for Windows users].

There are two options for opening QGIS in Taito-shell:

1) You can open QGIS from NoMachine's Fluxbox menu (right-click to
open): Applications -&gt; Taito-shell -&gt; GIS -&gt; QGIS. This loads
in the background the same modules as option 2.

2) Load appropriate modules

`module load geo-env wxwidgets saga/2.3.1`

You can skip saga (+ wxwidgets) modules, if you do not use SAGA
processing tools.

Start QGIS GUI:

`qgis`

Using SAGA processing toolbox

Qgis processing toolbox supports only saga 2.3.x versions so you must
have wxwidgets and saga/2.3.1 modules loaded if you want to use Saga
through qgis.

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   QGIS [homepage].
-   [QGIS Training Manual]
-   [Tutorials].
-   Juha Härkönen (University of Oulu), [QGIS 2.8.1 desktop ohje] (in
    Finnish)
-   Samppa Kaivosoja (Lapin AMK), [QGIS-opas: Paikkatietojen
    visualisointi] (Liite 1, in Finnish)

------------------------------------------------------------------------

  [-X connection or NoMachine for Windows users]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc
  [homepage]: http://qgis.org/en/site/
  [QGIS Training Manual]: http://docs.qgis.org/2.18/en/docs/training_manual/
  [Tutorials]: http://www.qgistutorials.com/en/
  [QGIS 2.8.1 desktop ohje]: http://www.oulu.fi/sites/default/files/content/QGIS%202%208%201%20ohje%20toukokuu.pdf
  [QGIS-opas: Paikkatietojen visualisointi]: http://www.theseus.fi/bitstream/handle/10024/114897/LapinAMK_ONT_SK_5.pdf;sequence=1
