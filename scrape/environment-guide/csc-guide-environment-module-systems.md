# 4.2 Environment module systems

Many, but not all, application software require, that the user loads an
**environment** [][1]<span style="font-style: normal;">**module**</span>
before starting the program. The environment module system is needed as
the programs and other tools often have contradictory requirements
related to compilers and libraries. For example, it is often necessary
to have access to older versions of an application, or to have a library
configured with different options for different applications.

The syntax of the environment module loading is:

    module load software_environment_name

For example to use *R* statistics software in taito-shell.csc.fi, you
must first run command:

      module load r-env

This command adds the *R* executable to the search path and sets up
environment variables that *R* needs. Only after that you can launch the
actual *R* application.

Environment modules provide a convenient way to dynamically change the
user's environment so that different compiler suites and application
versions can be used more easily. Modules system modifies the
environment variables of the user's shell environment so that the
correct versions of executables are in the path and linker can find the
correct version of needed libraries. For example, the command *R* points
to different R versions depending of the loaded R module.

At the moment CSC is using two slightly different module environment
tools:

**1. Environment Modules Project**

Supercomputer sisu.csc.fi uses TCL based module system developed by the
**Environment Modules Project** (<http://modules.sourceforge.net/>). In
this system all available modules are listed with command:

    module avail

Loading module files is done with commands:

    module load modulefilename

More information about this module environment can be found from the
[Sisu user guide].

**2. Lmod**

Taito.csc.fi supercluster uses a more recently developed version of
environment modules called *Lmod*. It is developed at Texas Advanced
Computing Center (TACC) and it is implemented using *Lua* programming
language. In this system, all the installed modules can be listed with
command:

    module spider

Lmod uses hierarchical module structure which means that you may first
need to load modules higher in the hierarchy before a specific module
can be loaded. More details about the Lmod system can be found from the
[Taito user guide].

 

 

  [1]: https://research.csc.fi/ {#module}
  [Sisu user guide]: https://research.csc.fi/sisu-user-guide
  [Taito user guide]: https://research.csc.fi/taito-user-guide
