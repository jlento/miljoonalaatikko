## 4.7 Profiling Applications with Intel Tools

### 4.7.1 Serial and Multithreaded Applications[][1]

*Intel VTune Amplifier* is a powerful profiling tool that can be used to
collect performance data of your application. It is best suited to be
used with serial and multithreaded code.

#### Using Intel VTune Amplifier

Set up the environment for profiling by loading the VTune module as
follows:

    module load intel-vtune/16.1

If you want to get source code level information, compile your code with
optimizations enabled and add also the debugging information option
*-g*. Basic hotspot analysis is the first analysis type you should try.
Here is a sample batch job script that can be used to profile a serial
and OpenMP applications:

    #!/bin/bash
    #SBATCH -ptest
    #SBATCH -Chsw
    #SBATCH -t5
    #SBATCH -n1
    #SBATCH -c4

    module load intel-vtune/16.1

    srun amplxe-cl -r results_dir_name -collect hotspots -- ./my_application

 

#### Analyzing Results Using GUI

Results can be viewed using the **amplxe-gui** application.
Unfortunately it does not work well with *ssh* and X11 forwarding, so we
recommend using the analysis tool in *NoMachine* environment (see
[NoMachine user's guide]). The GUI is available in Taito when the module
*intel-vtune/16.1* is loaded. You can inspect the results of a profile
run by giving the name of the results directory as an argument to the
amplxe-gui, for example, the results of previous example can be viewed
with command amplxe-gui results\_dir\_name. Please see Intel's
documentation for more information on using the GUI:
<https://software.intel.com/en-us/amplifier_2015_help_lin>

### 4.7.2 MPI Applications[][2]

Intel MPI library provides a simple and light-weight profiling for
applications. The collected results include the number of different
communication calls, amount of transferred data, etc. The statistics
collection can be enabled using an environment variable I\_MPI\_STATS,
for example:

    export I_MPI_STATS=1

Different integer values control the output level, for example value 1
gives results for amount of transferred data, value 2 adds to the
results also the number of different communication calls and so on. When
the statistics collection is turned on, the results for each task are
written to an output file stats.txt. For more details, see the MPI
library documentation at Intel's site:
<https://software.intel.com/en-us/node/528838>

 

#### Intel Thread Analyzer and Collector

For more detailed analysis you can use *Intel Thread Analyzer and
Collector* (ITAC), which can be used to visualize the MPI communication
and identify the hotspots and scaling bottle-necks. In order to use the
thread analyze make sure that you have module *intel-TraceCollector*
loaded using command module load intel-TraceCollector. Also make sure
that you are using Intel MPI, that is, you have some version of module
intelmpi loaded. Compile you program code using the mpi wrapper
compilers (mpicc, mpiCC and mpif90) and add options -g -trace to the
linking options. For example:

    mpicc -g -trace -O3 -xCORE-AVX2 my_program.c

After compilation you can run your program code as you would normally
do. Note that the tracing can produce huge log files, so it is
preferable to use as small and short test case as possible. It is also
possible to use the ITAC programming API to collect data only for a
portion of the code. See the Intel documentation for more instructions:
<https://software.intel.com/en-us/articles/intel-trace-analyzer-and-collector-documentation>

 

#### Analyzing the Trace Results

After the collecting is done, a series of log files with .stf. suffix
will be created in the working directory. They can be viewed and
analyzed using the Trace Analyzed GUI called *traceanalyzer*, which is
available on the Taito login nodes when *itac* module is loaded. You can
pass the name of the trace file as an argument, for example
traceanalyzer my\_program.stf, or open the results file using the GUI.
You should also consider using NoMachine (see the VTune instructions for
more information). Please see the documentation at Intel's site for
detailed usage instructions of Trace Analyzer:
<https://software.intel.com/en-us/articles/intel-trace-analyzer-and-collector-documentation>

  [1]: https://research.csc.fi/ {#4.7.1}
  [NoMachine user's guide]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc#1.3.3
  [2]: https://research.csc.fi/ {#4.7.2}
