## FORCE

### Description

**FORCE installation  in Taito is not  properly tested by CSC,  if you
notice any problems. please inform servicedesk@csc.fi**

FORCE  -   Framework  for   Operational  Radiometric   Correction  for
Envirnmental Monitoring is  intended to be an  all-in-one solution for
the  mass-processing  of  selected medium-resolution  satellite  image
archives to  enable large area  + time series  applications. Currently
supported  are Landsat  4/5  TM, Landsat  7 ETM+,  Landsat  8 OLI  and
Sentinel-2 A/B  MSI.  The  software is  capable of  processing Level 1
products as obtained from the space agencies to Level 2–4 products.

The main features are

-    Integration  of  Landsat  4–8,  and  Sentinel-2  A/B  as  Virtual
    Constellation.
-   Data management of Landsat  and Sentinel-2 Level 1 data + Download
    of Sentinel-2 data.
-   Near-realtime (NRT) processing capability.
-   Generation of Analysis Ready  Data (ARD). Advanced cloud and cloud
    shadow  detection. Quality  screening. Integrated  atmospheric and
    topographic correction:  one algorithm for all  sensors. Adjacency
    effect correction. BRDF reduction.  Resolution merge of Sentinel-2
    bands: 20m à 10m. Data cubing: reprojection / gridding.
-   Generation of  highly Analysis Ready Data (hARD).  Large area. Gap
    free. Best  Available Pixel  (BAP) composites.  Phenology Adaptive
    Composites (PAC). Spectral Temporal Metrics (STM). Ideal input for
    your Machine Learners!
-   Generation of highly Analysis Ready Data plus (hARD+). Time Series
    generation:  spectral bands,  spectral  indices, Spectral  Mixture
    Analysis    (SMA).    Time    series    folding.    Time    series
    interpolation.  Time series  statistics.  Trend analysis.  Change,
    Aftereffect, Trend (CAT) analysis. Land Surface Phenology (LSP).
-    Detailed  data   mining  of  the  Clear   Sky  Observation  (CSO)
    availability.
-    Data Fusion.  Improving spatial  resolution of  coarse continuous
    fields:  MODIS  LSP à  medium  resolution  LSP. Improving  spatial
    resolution of  lower resolution  ARD using higher  resolution ARD:
    30m Landsat à 10m using Sentinel-2 targets

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito: 2.1

------------------------------------------------------------------------

### Usage

Load necessary modules:  
`module load force gnu-parallel`

Get list of available force commands:

`ls /appl/earth/force/v2.1/bin/`

For further instructions consult **[FORCE user guide]**.

You can also  **[see a presentation with examples on  how to use FORCE
in  CSC's Taito]**  by  Pekka  Hurskainen from  SYKE  & University  of
Helsinki with examples on how to use FORCE in Taito (from 15.2.2019) .

------------------------------------------------------------------------

### Discipline

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

[FORCE user guide v-2.0][FORCE user guide]

------------------------------------------------------------------------

  [FORCE user guide]: https://www.uni-trier.de/fileadmin/fb6/prof/FER/Downloads/Software/FORCE/FORCE-user-guide-v-2-0.pdf [see a presentation with examples on how to use FORCE in CSC's Taito]: https://research.csc.fi/documents/48467/73370/Satellite_time_series_processing_with_FORCE/45872b86-36fb-470d-910f-d29930767ecd
