# 4.1 Available Compilers {#CompilerEnvironment-41AvailableCompilers .western}

C, C++ and Fortran are the most frequently used programming languages in
scientific computing. In Taito supercluster these programming languages
can be used through two *compiler suites*. The default compiler package
is the *Intel Parallel Studio XE 16.0*. Alternatively you can use *GNU
Compiler collection 4.9.3*. To use another compiler package, or another
version of a particular compiler package, one should switch the active
package using the *module* system (more information about module system
in [chapter 2]).

For example to swap the default Intel compiler to GNU compiler, give
command:

`module swap intel gcc `

**Table 4.1** Compiler suites available in Taito

<table>
<thead>
<tr class="header">
<th>Compiler suite</th>
<th>Version</th>
<th>Module</th>
<th>Man pages</th>
<th>User Guides</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><a href="http://gcc.gnu.org/" class="external-link"> GNU Compiler Collection </a></td>
<td>4.9.3</td>
<td>gcc</td>
<td>man gcc C/C++<br />
man gfortran Fortra</td>
<td><a href="http://gcc.gnu.org/onlinedocs" class="external-link">GCC</a></td>
</tr>
<tr class="even">
<td> <a href="https://software.intel.com/en-us/intel-parallel-studio-xe">Intel Parallel Studio</a></td>
<td>16.0</td>
<td>intel</td>
<td>man icc C/C++<br />
man ifort Fortran</td>
<td><a href="http://software.intel.com/en-us/intel-software-technical-documentation" class="external-link">Intel</a></td>
</tr>
</tbody>
</table>

 

To read a man page of a specific compiler, one should execute the *man*
command only after having switched to the relevant programming
environment.

For Intel Parallel Studio you can find extensive documentation from the
Intel Software pages. In the Intel web site you can find the C/C++
documentation under product name [*Intel C/C++ User and Reference
Guide*] and the Fortran77/95 documentation under product name [*Intel
Fortran User and Reference Guide*].

CSC has created generic commands aliases such as ***f95*** or
***mpif90*** which refer to the compiler commands of the loaded compiler
package. For example, in the case of Intel compilers command *f95*
refers to Intel F95 compiler, but when the GNU compiler suite is in use
the same command refers to *gfortran* command*.* The aliases are listed
in table 4.2.

**Table 4.2** Compiler aliases at CSC

| Language   | compiler command | MPI parallel compiler command |
|------------|------------------|-------------------------------|
| Fortran 77 | f77              | mpif77                        |
| Fortran 95 | f95              | mpif90                        |
| C          | cc               | mpicc                         |
| C++        | CC               | mpiCC                         |

 

There are two important factors that should be taken into account when
choosing between the compilers: *correctness* and *performance* of the
compiled program.

-   **Correctness:** Some programs may only produce correct results when
    compiled with a particular compiler. It is also possible that the
    program produces wrong results when compiled using aggressive
    compiler optimizations. It is thus of key importance to always check
    that the compiled program actually produces correct results.

-   **Performance:** One should choose the compiler giving the best
    performance, while still producing correct results. It is impossible
    to know ahead of time which compiler is the best for a particular
    program. One simply has to find the best compiler and its optimal
    compiler options using a '*generate and check*' method.

#### ** ** {#CompilerEnvironment- .western}

Intel and GNU compilers use different compiler options. Detailed list of
options for Intel and GNU compiler can be found from man pages when
corresponding programming environment is loaded, or in the compiler
manuals on the Web (see links above this chapter).

Table 4.3 below lists some good optimization flags for the installed
compilers. It is best to start from the safe level and then move up to
intermediate or even aggressive, while making sure that the results are
correct and that the program has better performance.

Taito has Intel Sandy Brigde and Haswell microarchitecture nodes. To
enable full instruction set that these microarchitectures supports, use
the option *-xHost* with Intel Compiler and the option
*-march=sandybridge* or *-march=haswell* with GNU compiler. Because
*-xHost* will generate instructions for the highest instruction set
available on the compilation host processor this option wiil generate
Sandy Brigde instructions on login nodes. Haswell instructions will be
generated when code is compiled on Haswell nodes ( and *-xHost* option
has been selected *)*. Interactive sessions on compute nodes are
explained on Section 3.4 Interactive bacth jobs. Remember that if the
compiled code has Haswell instructions such as ***AVX2*** and ***FMA***
it will not run on Sandy Bridge nodes. *Gnu* compilers ( *gcc, g++,
gfortran* ) versions *4.9 and later* and *Intel* compilers (*icc, icpc ,
ifort*) versios *14* *and later* support Haswell specific compiling.

**Table 4.3** Simple optimization flags for Intel and GNU compilers.

 

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Optimisation level</th>
<th>Intel</th>
<th>GNU</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Safe</strong></td>
<td>-O2 -fp-model precise -fp-model source<br />
<br />
(Use all three options. One can also use options -fp-model precise -fp-model source with intermediate and aggressive flags to improve the consistency and reproducibility of floating-point results)</td>
<td>-O2</td>
</tr>
<tr class="even">
<td><strong>Intermediate</strong></td>
<td>-O2 -xHost (see Remark1)</td>
<td>-O3 -march=native (see Remark1)</td>
</tr>
<tr class="odd">
<td><strong>Aggressive</strong></td>
<td>-O3 -xHost -opt-prefetch -unroll-aggressive -no-prec-div -fp-model fast=2 (see Remark1)</td>
<td>-O3 -march=native -ffast-math -funroll-loops (see Remark1)</td>
</tr>
<tr class="even">
<td><p><strong>Haswell instructions</strong> (binary works only on Haswell nodes)</p>
<p>Load also: "module load binutils"</p>
<p> </p></td>
<td>-xCORE-AVX2 -fma</td>
<td>-march=haswell</td>
</tr>
<tr class="odd">
<td><strong>Haswell and Sandy Bridge instructions</strong> (binary works on all nodes)</td>
<td>-xAVX -axCORE-AVX2</td>
<td>Gnu do not support this</td>
</tr>
<tr class="even">
<td><strong>Sandy Bridge instructions but tune for Haswell</strong> (binary works on all nodes)</td>
<td>Intel do not support this (use above flags)</td>
<td>-march=sandybridge -mtune=haswell</td>
</tr>
</tbody>
</table>

Remark1: If Intel *-xHost* or GNU flag *-march=native* is selected on
login/Sandybridge nodes a compiler will generate Sandy Bridge
instructions and binary works on all nodes. If Intel *-xHost* or GNU
flag *-march=native* is selected on Haswell nodes a compiler will
generate Haswell instructions and binary works only on Haswell nodes.

Do you need more information about Haswell and Sandybridge compiling?
See chapter [4.6 Processor architecture specific compiling].

Link time optimization methods are available on Intel and GNU compilers.
In GNU case read more from [link] (see option -flto) and in Intel case
this [link][1] (see IPO optimization).

**Table 4.4** Basic options that are common for both Intel and GNU
compilers:

| Option         | Description                                                                                                      |
|----------------|------------------------------------------------------------------------------------------------------------------|
| -c             | Compiles only, produces unlinked object *filename*.o                                                             |
| -o*filename*   | Gives the name filename for the executable. Default: **a.out**                                                   |
| -g             | Produces symbolic debug information                                                                              |
| -I*dirname*    | Searches directory *dirname* for for library files specified by -l                                               |
| -L*dirname*    | Searches directory dirname for for library files specified by -L                                                 |
| -l*libname*    | Searches the specified library file with the name **lib***libname***.a**                                         |
|  -O*\[level\]* | Specifies whether to optimize or not and at which level *level*, for example -O0 means turning off optimizations |

 

 

 

  [chapter 2]: https://research.csc.fi/taito-module-system
  [*Intel C/C++ User and Reference Guide*]: https://software.intel.com/en-us/intel-cplusplus-compiler-16.0-user-and-reference-guide
  [*Intel Fortran User and Reference Guide*]: https://software.intel.com/en-us/intel-fortran-compiler-16.0-user-and-reference-guide
  [4.6 Processor architecture specific compiling]: https://research.csc.fi/taito-architecture-specific-compiling
  [link]: http://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
  {.external-link}
  [1]: https://software.intel.com/en-us/articles/step-by-step-optimizing-with-intel-c-compiler
