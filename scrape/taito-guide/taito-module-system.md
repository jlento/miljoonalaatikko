# 2. The module system in Taito {#Themodulesystem-2ThemodulesysteminTaito .western}

Managing the software environment of a cluster with big user base is a
complicated task. One have to take into account several, often
contradictory, requirements set by different applications, compilers and
libraries. For example, it is often necessary to have access to older
versions of an application, or to have a library configured with
different options for different applications. Setting up a working
environment for the user is very difficult when you have several
versions of hundreds of applications and libraries. The situation is
also difficult for the users looking for a particular application or
library.

*Environment modules* provide a convenient way to dynamically change the
user's environment so that different compiler suites and application
versions can be used more easily. Modules system modifies the
environment variables of the user's shell so that the correct versions
of executables are in the path and linker can find the correct version
of needed libraries. For example, the command *mpicc* points to
different compilers depending of the loaded module. Modules system also
provides extensive search commands that can be used to find suitable
software modules from the list of installed packages.

Taito uses a recently developed version of environment modules called
**Lmod**. It is developed at Texas Advanced Computing Center (TACC) and
it is implemented using *Lua* programming language. More technical
details can be found from the [Lmod homepage]. Those who are familiar
with the *environment modules* systems used in Sisu should note that the
Lmod significantly differs from Sisu's implementation.

 

## [2.1 Basic usage] {#basic-usage .western}

[2.1.1 Finding modules][]  
[2.1.2 Solving conflicts]

 

 

## [2.2 Advanced topics] {#Themodulesystem-23Advancedtopics .western}

[2.2.1 Module hierarchy][]  
[2.2.2 Using your own module files]  
 

 

 

  [Lmod homepage]: http://www.tacc.utexas.edu/tacc-projects/mclay/lmod
  {.external-link}
  [2.1 Basic usage]: https://research.csc.fi/taito-modules-basic-usage
  [2.1.1 Finding modules]: https://research.csc.fi/taito-modules-basic-usage#2.1.1
  [2.1.2 Solving conflicts]: https://research.csc.fi/taito-modules-basic-usage#2.1.2
  [2.2 Advanced topics]: https://research.csc.fi/taito-modules-advanced-topics
  [2.2.1 Module hierarchy]: https://research.csc.fi/taito-modules-advanced-topics#2.2.1
  [2.2.2 Using your own module files]: https://research.csc.fi/taito-modules-advanced-topics#2.2.2
