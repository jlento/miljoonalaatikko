# 2.2 Advanced topics

## [][1]2.3.1 Module hierarchy {#Themodulesystem-231Modulehierarchy .western}

In general, libraries built with one compiler need to be linked with
applications using the same compiler. For example, you can not use the
MPI Fortran90 module compiled with Intel compilers with *gfortran*, but
you have to use a version compiled with *gfortran*. Environment modules
have several mechanisms that prevent the user from setting up a
non-working environment.

The module hierarchy helps us to keep the compiler and MPI library
settings compatible with each other. In practice, for each supported
compiler there is a module for a supported MPI library. When user
switches the compiler module, the module system tries to find the
correct versions of loaded modules:

    -bash-4.1$ module list
    Currently Loaded Modules:
      1) intel/12.1.5 2) mkl/10.3.11 3) intelmpi/4.0.3

    -bash-4.1$ module switch intel gcc
    Due to MODULEPATH changes the following modules have been reloaded:
     1) mkl/10.3.11 2) intelmpi/4.0.3

 

If a correct version is not found, the module system *deactivates* these
modules. In practice, the module is unloaded, but it is marked so that
when the compiler/MPI configuration is changed, the system tries to find
a correct version automatically.

This hierarchy is implemented by changing the **$MODULEPATH** variable.
Every compiler module adds its own path to the module path so that
software modules compatible with that specific compiler can be listed.
When the compiler module is unloaded, this path is removed from the
module path. Same applies also to the MPI modules.

## [][2]2.2.2 Using your own module files {#Themodulesystem-232Usingyourownmodulefiles .western}

If you want to use modules to control the software packages that you
install by yourself, you can add your own modules files to your home
directory. For example, if you add the module files to
**$HOME/modulefiles**, you can access them after you add the path to the
modules search path using command:

    module use $HOME/modulefiles

 

 

  [1]: https://research.csc.fi/ {#2.3.1}
  [2]: https://research.csc.fi/ {#2.2.2}
