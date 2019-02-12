## sofi3D

### Description

# SOFI3D

3D Finite-Difference Seismic Wave Simulation

* * *

### Available

##### Version on CSC's Servers

Taito:

1.0.0 (release)

* * *

### Usage

To use SOFI3D on taito load the module:

    module load sofi3D 

The program can then be run with:

    sofi3D 

Other executables provided by the module are:

    partmodel  seismerge  snapmerge sofi3D\_acoustic
    

## Example batch job

SOFI3D creates a lot of a auxiliary files, so in this example subdirectories are used in order to reduce clutter.

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
                "FDORDER\_TIME" : "2",
                "FDCOEFF" : "2",
                "fdcoeff values: Taylor=1, Holberg=2" : "comment",
    
    "Time Stepping" : "comment",
                "TIME" : "5.0",
                "DT" : "6.6e-3",
    
    "Source" : "comment",
    
                "SOURCE\_SHAPE" : "1",
                "source shape values: ricker=1;fumue=2;from\_SIGNAL\_FILE=3;SIN\*\*3=4" : "comment",
                "SIGNAL\_FILE" : "signal\_mseis.tz",
    
                "SOURCE\_TYPE" : "1",
                "source\_type values (point\_source): explosive=1;force\_in\_x=2;in\_y=3;in\_z=4;custom=5;earthquake=6" : "comment",
                "SOURCE\_ALPHA, SOURCE\_BETA" : "0.0 , 0.0",
                "AMON, STR, DIP, RAKE" : "1.0e2 , 45.0 , 90.0 , 45.0",
                "SRCREC" : "1",
                "srcrec values :  read from SOURCE\_FILE=1, PLANE\_WAVE=2 (internal)" : "comment",
    
                "SOURCE\_FILE" : "./sources/sources.dat",
                "RUN\_MULTIPLE\_SHOTS" : "0",
    
                "PLANE\_WAVE\_DEPTH" : "2106.0",
                "PLANE\_WAVE\_ANGLE" : "0.0",
                "TS" : "0.2",
    
    "Model" : "comment",
                "READMOD" : "0",
                "MFILE" : "model/test",
                "WRITE\_MODELFILES" : "2",
    
    "Q-approximation" : "comment",
                "L" : "0",
                "FREF" : "5.0",
                "FL1" : "5.0",
                "TAU" : "0.00001",
    
    "Boundary Conditions" : "comment",
                "FREE\_SURF" : "1",
                "ABS\_TYPE" : "1",
                "FW" : "20.0",
                "DAMPING" : "8.0",
                "FPML" : "5.0",
                "VPPML" : "3500.0",
                "NPOWER" : "4.0",
                "K\_MAX\_CPML" : "1.0",
                "BOUNDARY" : "0",
    
    "Snapshots" : "comment",
                "SNAP" : "4",
                "TSNAP1" : "6.6e-3",
                "TSNAP2" : "4.8",
                "TSNAPINC" : "0.2",
                "IDX" : "1",
                "IDY" : "1",
                "IDZ" : "1",
                "SNAP\_FORMAT" : "3",
                "SNAP\_FILE" : "./snap/test",
                "SNAP\_PLANE" : "2",
    
    "Receiver" : "comment",
                "SEISMO" : "4",
                "READREC" : "0",
                "REC\_FILE" : "./receiver/receiver.dat",
                "REFRECX, REFRECY, REFRECZ" : "0.0 , 0.0 , 0.0",
                "XREC1,YREC1, ZREC1" : "54.0 , 2106.0, 2592.0",
                "XREC2,YREC2, ZREC2" : "5400.0 , 2106.0, 2592.0",
                "NGEOPH" : "1",
    
    "Receiver array" : "comment",
    
                "REC\_ARRAY" : "0",
                "REC\_ARRAY\_DEPTH" : "1350.0",
                "REC\_ARRAY\_DIST" : "640.0",
                "DRX" : "2",
                "DRZ" : "2",
    
    "Seismograms" : "comment",
                "NDT, NDTSHIFT" : "1, 0",
                "SEIS\_FORMAT" : "1",
                "SEIS\_FILE" : "./su/test",
    
    "Monitoring the simulation" : "comment",
                "LOG\_FILE" : "log/test.log",
                "LOG" : "1",
                "OUT\_SOURCE\_WAVELET" : "1",
                "OUT\_TIMESTEP\_INFO" : "10",
    
    "Checkpoints" : "comment",
                "CHECKPTREAD" : "0",
                "CHECKPTWRITE" : "0",
                "CHECKPT\_FILE" : "tmp/checkpoint\_sofi3D",
    }

This example runs sofi3D on 4 nodes with 4 cpu:s on each node (just for demonstration purposes, could also be run on a single node with 16 cpu:s). For a single node job we would set

    \--nodes=1, --ntasks-per-node=16, --partition=serial

## Common errors

*   The variables NPROCX, NPROCY and NPROCZ can be found under Domain Decomposition in the json file. Their product has to be equal to the --ntasks option, otherwise the program will stop. So NPROCX\*NPROCY\*NPROCZ=16 in the example run.

*   A json file must be provided     sofi3D my_file.json, otherwise the program will try read a default sofi3D.json file in the current directory.

*   The folders specified in the json file have to exist when the program is run as it does not create them.

*   The output from different workers have to be accessible to each other, as one worker will merge the results from the other workers and will fail if it can't access all the data.

* * *

### Discipline

Geosciences  
Physics  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

* * *