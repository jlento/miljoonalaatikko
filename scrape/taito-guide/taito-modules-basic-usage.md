# 2.1 Basic usage

The syntax of the module commands is:

    module command module-name

The currently loaded modules are listed with command:

    module list

For general module information one uses command *module help*. For
example, to get more information about loaded module *intel*, one can
use command:

    module help intel

New modules can be loaded to your environment using *load* command, for
example the *trilinos* module can be loaded using command:

    module load trilinos

Note that you can only load modules that are compatible with other
modules that you have loaded. That is, you can not load modules that are
conflicting with previously loaded modules, or modules that depend on
modules that have not been loaded.

Modules that are not needed or that are conflicting with other modules
can be unloaded using *unload* command:

    module unload mkl

**Table 2.1** Most commonly used module commands.

|  Module command               |  Description                                  |
|-------------------------------|-----------------------------------------------|
| module help *modulename*      | Show information about a module.              |
| module load *modulename*      | Loads the given environment module.           |
| module unload *modulename*    | Unloads the given environment module.         |
| module list                   | List the loaded modules.                      |
| module avail                  | List modules that are available to be loaded. |
| module spider *name*          | Searches the entire list of possible modules. |
| module swap *module1 module2* | Replaces a module with a second module.       |

## [][1][][2] {#Themodulesystem-221Findingmodules .western}

## 2.1.1 Finding modules {#finding-modules .western}

You can list the modules that are compatible with your current module
set by using command:

    module avail

Because of the hierarchical structure of the Lmod system you can not
load all installed modules using just one *module load* command. The
*avail* command does not show modules that can not be loaded due to
conflicts or unmet dependencies. Reason for these protective
restrictions is to prevent you from loading module combination that do
not work.

You can get the list of all installed software packages using command:

    module spider

You can also give the name or part of the name of the module as an
argument, for example:

    module spider int

will list all modules with string "int" in the name. More detailed
description of a module can be printed using the full module name with
version number, for example:

    module spider fftw/3.3.2

## [][3][][4] {#Themodulesystem-222Solvingconflicts .western}

## 2.1.2 Solving conflicts {#solving-conflicts .western}

As mentioned above, the module system does not let the user to load
conflicting modules. In these cases you have to solve these conflicts
before loading the module. In the easiest case the module system gives
you explicit guidance. For example, if you try to load a compiler module
on top of another one, you will get an error message:

     -bash-4.1$ module load gcc

    Lmod has detected the following error: You can only have one compiler module loaded at a time.
    You already have intel loaded.
    To correct the situation, please enter the following command:

      module swap intel gcc/4.8.2

Some modules depend on other modules. Also in these cases the
information from the module system is obvious, for example:

    -bash-4.1$ module load netcdf4

    Lmod has detected the following error: Cannot load module "netcdf4/4.3.0" without these modules loaded:
      hdf5-par/1.8.10

More complicated procedures are needed when the module is not compatible
with currently loaded compiler and/or MPI-library. In these cases the
*module avail* command does not even list the module and *module load*
command can not find it. Easiest way to check what environment is
required for the desired module is to use *module spider* command with
version information. For example:

    -bash-4.1$ module spider hypre/2.9.0b
    ------------------------------------------------------------------
     hypre: hypre/2.9.0b
    ------------------------------------------------------------------
      This module can only be loaded through the following modules:
           intel/12.1.5, intelmpi/4.0.3
           intel/13.0.1, intelmpi/4.1.0
           intel/13.1.0, intelmpi/4.1.0
    ...

  
So in this case you will have to load one the listed environments before
you can proceed with *module load* command.

 

  [1]: https://research.csc.fi/ {#Themodulesystem-Findingmodules}
  [2]: https://research.csc.fi/ {#2.1.1}
  [3]: https://research.csc.fi/ {#Themodulesystem-Solvingconflicts}
  [4]: https://research.csc.fi/ {#2.1.2}
