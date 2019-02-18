## LasTools

### Description

LAStools  provides tools  for processing  lidar point  cloud data.  In
taito the following open source tools are installed:

-   las2las
-   las2txt
-   txt2las
-   lasdiff
-   lasindex
-   lasinfo
-   lasmerge
-   lasprecision
-   laszip

Rest of the LAStools tools are not available in Taito at the moment.

------------------------------------------------------------------------

### Available

### Usage

Load lastools module :

`module load gcc/4.9.3 lastools`

or

`module load geo-env lastools`

..and run individual tools, for example:

`lasinfo -h`

Usage instructions for  individual tools can be found with  -h flag or
by looking at the readme files in /appl/earth/lastools/LAStools/bin

 

## Finnish National Land Survey's lidar data in Taito

Lidar data from NLS is available from Taito under the shared [GIS data
folder][]: */proj/ogiir-csc/mml/laser/*

 

## <span id="chapter_data_lastoolstaitossa_4" class="ecpHeading">Working with a lot of files in Taito </span> {#Submitting_batch_jobs:}

If you want to analyze several lidar  files in a similar manner, it is
easiest to  obtain a list  of files you want  to process and  then use
Taito's [array jobs] to process those files.

Below is  a simple example for  converting list of .laz  files to .las
files keeping only first returns using las2las:

`#!/bin/bash    -l     #SBATCH    -J    las2las_test     #SBATCH    -o
array_job_out_%A_%a.txt #SBATCH -e  array_job_err_%A_%a.txt #SBATCH -t
00:00:10 #SBATCH --mem-per-cpu=2 #SBATCH --array=1-20 #SBATCH -p array
#load lastools  module, for accessing the  lastools command-line tools
module load  lastools # read  file names to  be processed from  a list
given as  an argument fullname=$(sed -n  "$SLURM_ARRAY_TASK_ID"p $1) #
get  base file  names from  full  names including  path and  extension
filename="${fullname##*/}"  filename="${filename%.*}" ua='USERAPPL'  #
run the analysis command and save results to out/ directory las2las -i
$fullname -o out/$filename.las -first_only`

After modifying \#SBATCH variables with suitable values above script
could then be run using:  
sbatch  &lt;script\_file&gt; &lt;txt  file containing  names for  .laz
files&gt;

------------------------------------------------------------------------

### Discipline

Geosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

-   [LasTools homepage]
-   [Tutorials]

------------------------------------------------------------------------

  [GIS data folder]: https://research.csc.fi/gis_data_in_taito
  [array jobs]: https://research.csc.fi/taito-array-jobs#3.5.2
  [LasTools homepage]: https://rapidlasso.com/lastools/
  [Tutorials]: http://rapidlasso.com/category/tutorials/
