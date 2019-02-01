# mpif90-conf

How to read a Fortran namelist from a file in a MPI parallel application.

Simply: read the namelist file into a single string in the MPI task 0, broadcast the string to all MPI tasks,
and read the namelist from the string in each MPI task.

As a bonus: namelist can also be given as a command line argument.


## Usage examples and tested platforms

The usage examples compile the example code, and run a test which reads namelist from file `myapp.conf`.

#### OpenMPI 1.6.5, gfortran 4.8.4

```bash
make
mpirun -n 2 ./myapp '&myapp_conf griddims(2) = 5 /'
```

#### IntelMPI 4.1.0, ifort 13.1.0, SLURM, @taito.csc.fi

```bash
make
srun -n 2 -t 1 -p test ./myapp '&myapp_conf griddims(2) = 5 /'
```

#### Cray MPICH 7.2.2, ftn 8.3.12, ALPS, @sisu.csc.fi

ALPS `aprun` does not like metacharacters such as `&`, `(`, `)`, etc.
in command arguments, so no(?) command line configuration override bonus with
ALPS...

```bash
make
aprun -n 2 ./myapp
```
