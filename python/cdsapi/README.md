# How to download ERA5 data using cdsapi

## Install Python environment with CDS API

In CSC's environments probably the easiest is

```
module load tykky
pip-containerize new --slim --prefix $SCRATCH/cdsapi requirements.txt
PATH=$SCRATCH/cdsapi/bin:$PATH
```

## Configure CDS API and accept the dataset license

Login to Copernicus CDS, and configure access key in file `~/.cdsapirc`,
https://cds.climate.copernicus.eu/how-to-api .

Accept the License in https://cds.climate.copernicus.eu/datasets/reanalysis-era5-complete?tab=d_download
(bottom of the page).

## Download data

Select data from https://apps.ecmwf.int/data-catalogues/era5/?class=ea . The portal
provides python script that can be used to download the data, here in file `era5.py`.
Only the output file name handling and file format (to netcdf) is modified from
the vanilla script from the portal.

```
mkdir -p $SCRATCH/cdsapi/data
nohup python era5.py $SCRATCH/cdsapi/data/2m-temperature-2025-03.nc  > $SCRATCH/cdsapi/data/log.txt &
```
