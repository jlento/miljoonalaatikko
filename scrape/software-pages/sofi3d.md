## sofi3D

### Description

# SOFI3D <span class="visibility-icon has-tooltip" data-container="body" title=""> </span> {#sofi3d-1 .project-title .qa-project-name}

3D Finite-Difference Seismic Wave Simulation

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Taito:

1.0.0 (release)

------------------------------------------------------------------------

### Usage

To use SOFI3D on taito load the module:

    module load sofi3D 

The program can then be run with:

    sofi3D 

Other executables provided by the module are:

    partmodel  seismerge  snapmerge sofi3D_acoustic

 

## Example batch job

SOFI3D creates a lot of a auxiliary files, so in this example
subdirectories are used in order to reduce clutter.

    #!/bin/bash
    #SBATCH --nodes=4
    #SBATCH --ntasks=16
    #SBATCH --ntasks-per-node=4
    #SBATCH --mem=2G
    #SBATCH --time=00:05:00
    #SBATCH --partition=parallel
    #SBATCH --cpus-per-task=1

    # Load the prerequisites for sofi3D
    module load intel/16.0.0
    module load intelmpi/5.1.1
    module load sofi3D

    # create folders for output
    # The folder names and locations can be configured in the json file
    mkdir  log model snap su tmp

    # create folders for input
    # The folder names and locations can be configured in the json file
    mkdir  sources receiver

    # Write some input data (This could also just be a separate file)
    cat <<EOF > receiver/receiver.dat
    540.0   2106.0  2592.0
    1080.0  2106.0  2592.0
    1620.0  2106.0  2592.0
    2160.0  2106.0  2592.0
    2700.0  2106.0  2592.0
    3240.0  2106.0  2592.0
    3780.0  2106.0  2592.0
    4320.0  2106.0  2592.0
    4860.0  2106.0  2592.0
    5400.0  2106.0  2592.0
    EOF

    # Write some more input data (This could again just be a separate file )
    cat <<EOF > sources/sources.dat
    2592.0        2106.0     2592.0      0.0           5.0           1.0
    EOF

    # run the program
    srun sofi3D sofi3D.json > simulation.out

    # Remove created folders
    # test run, so saving only the simulation output
    # not the actual data
    rm -r sources receiver log model snap su tmp

where the input file is sofi3D.json defined as:

    #-----------------------------------------------------------------
    #      JSON PARAMETER FILE FOR SOFI3D
    #-----------------------------------------------------------------
    # description: example of json input file
    # description/name of the model: homogeneous full space (hh.c)
    #

    {
    "Domain Decomposition" : "comment",
                "NPROCX" : "2",
                "NPROCY" : "4",
                "NPROCZ" : "2",

    "3-D Grid" : "comment",
                "NX" : "100",
                "NY" : "100",
                "NZ" : "100",
                "DX" : "54.0",
                "DY" : "54.0",
                "DZ" : "54.0",

    "FD order" : "comment",
                "FDORDER" : "4",
                "FDORDER_TIME" : "2",
                "FDCOEFF" : "2",
                "fdcoeff values: Taylor=1, Holberg=2" : "comment",

    "Time Stepping" : "comment",
                "TIME" : "5.0",
                "DT" : "6.6e-3",

    "Source" : "comment",

                "SOURCE_SHAPE" : "1",
                "source shape values: ricker=1;fumue=2;from_SIGNAL_FILE=3;SIN**3=4" : "comment",
                "SIGNAL_FILE" : "signal_mseis.tz",

                "SOURCE_TYPE" : "1",
                "source_type values (point_source): explosive=1;force_in_x=2;in_y=3;in_z=4;custom=5;earthquake=6" : "comment",
                "SOURCE_ALPHA, SOURCE_BETA" : "0.0 , 0.0",
                "AMON, STR, DIP, RAKE" : "1.0e2 , 45.0 , 90.0 , 45.0",
                "SRCREC" : "1",
                "srcrec values :  read from SOURCE_FILE=1, PLANE_WAVE=2 (internal)" : "comment",

                "SOURCE_FILE" : "./sources/sources.dat",
                "RUN_MULTIPLE_SHOTS" : "0",

                "PLANE_WAVE_DEPTH" : "2106.0",
                "PLANE_WAVE_ANGLE" : "0.0",
                "TS" : "0.2",

    "Model" : "comment",
                "READMOD" : "0",
                "MFILE" : "model/test",
                "WRITE_MODELFILES" : "2",

    "Q-approximation" : "comment",
                "L" : "0",
                "FREF" : "5.0",
                "FL1" : "5.0",
                "TAU" : "0.00001",

    "Boundary Conditions" : "comment",
                "FREE_SURF" : "1",
                "ABS_TYPE" : "1",
                "FW" : "20.0",
                "DAMPING" : "8.0",
                "FPML" : "5.0",
                "VPPML" : "3500.0",
                "NPOWER" : "4.0",
                "K_MAX_CPML" : "1.0",
                "BOUNDARY" : "0",

    "Snapshots" : "comment",
                "SNAP" : "4",
                "TSNAP1" : "6.6e-3",
                "TSNAP2" : "4.8",
                "TSNAPINC" : "0.2",
                "IDX" : "1",
                "IDY" : "1",
                "IDZ" : "1",
                "SNAP_FORMAT" : "3",
                "SNAP_FILE" : "./snap/test",
                "SNAP_PLANE" : "2",

    "Receiver" : "comment",
                "SEISMO" : "4",
                "READREC" : "0",
                "REC_FILE" : "./receiver/receiver.dat",
                "REFRECX, REFRECY, REFRECZ" : "0.0 , 0.0 , 0.0",
                "XREC1,YREC1, ZREC1" : "54.0 , 2106.0, 2592.0",
                "XREC2,YREC2, ZREC2" : "5400.0 , 2106.0, 2592.0",
                "NGEOPH" : "1",

    "Receiver array" : "comment",

                "REC_ARRAY" : "0",
                "REC_ARRAY_DEPTH" : "1350.0",
                "REC_ARRAY_DIST" : "640.0",
                "DRX" : "2",
                "DRZ" : "2",

    "Seismograms" : "comment",
                "NDT, NDTSHIFT" : "1, 0",
                "SEIS_FORMAT" : "1",
                "SEIS_FILE" : "./su/test",

    "Monitoring the simulation" : "comment",
                "LOG_FILE" : "log/test.log",
                "LOG" : "1",
                "OUT_SOURCE_WAVELET" : "1",
                "OUT_TIMESTEP_INFO" : "10",

    "Checkpoints" : "comment",
                "CHECKPTREAD" : "0",
                "CHECKPTWRITE" : "0",
                "CHECKPT_FILE" : "tmp/checkpoint_sofi3D",
    }

This example runs sofi3D on 4 nodes with 4 cpu:s on each node (just for
demonstration purposes, could also be run on a single node with 16
cpu:s). For a single node job we would set

    --nodes=1, --ntasks-per-node=16, --partition=serial

 

## Common errors

-   The variables NPROCX, NPROCY and NPROCZ can be found under Domain
    Decomposition in the json file. Their product has to be equal to the
    --ntasks option, otherwise the program will stop. So
    NPROCX\*NPROCY\*NPROCZ=16 in the example run.

 

-   A json file must be provided` sofi3D my_file.json`, otherwise the
    program will try read a default sofi3D.json file in the current
    directory.

 

-   The folders specified in the json file have to exist when the
    program is run as it does not create them.

 

-   <span class="word">The</span> <span class="word">output</span> <span
    class="word">from</span> <span class="word">different</span> <span
    class="word">workers</span> <span class="word">have</span> <span
    class="word">to</span> <span class="word">be</span> <span
    class="word">accessible</span> <span class="word">to</span> <span
    class="word">each</span> <span class="word">other</span>, <span
    class="word">as</span> <span class="word">one</span> <span
    class="word">worker</span> <span class="word">will</span> <span
    class="word">merge</span> <span class="word">the</span> <span
    class="word">results</span> <span class="word">from</span> <span
    class="word">the</span> <span class="word">other</span> <span
    class="word">workers</span> <span class="word">and</span> <span
    class="word">will</span> <span class="word">fail</span> <span
    class="word">if</span> <span class="word">it</span> <span
    class="word">can't</span> <span class="word">access</span> <span
    class="word">all</span> <span class="word">the</span> <span
    class="word">data</span>.

------------------------------------------------------------------------

### Discipline

Geosciences  
Physics  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

------------------------------------------------------------------------
