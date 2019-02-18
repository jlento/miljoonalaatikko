## 3.6 Profiling applications using Allinea Performance Reports

*Allinea Performance Reports* is a performance analytics tool that
produces a one-page performance report of your application detailing the
amount of time spent in computation, I/O and communication. This
information is essential when trying to run the programs using optimal
configuration. The detailed user guide can be found from [Allinea web
pages].

#### [][1]3.6.1 Using Performance Reports

Set up the environment for analysis by loading the Performance Reports
module as follows:

      module load allinea/reports-6.0

The module adds a wrapper to the srun command so that profiling a MPI
program can be done by loading the module in the batch job script before
the srun command, for example:

    #!/bin/bash
    #SBATCH -ptest
    #SBATCH -Chsw
    #SBATCH -t5
    #SBATCH -n24

    module load allinea/reports-6.0

    srun ./my_application

Results of the profiling is written to a file that is named as
*aperf\_NNNNN.txt* where *NNNNN* is the slurm job id of your job.

Serial programs can be profiled by adding the command perf-reports
--nompi to your command line before the name of your application. Here
is an example of serial job script:

    #!/bin/bash
    #SBATCH -ptest
    #SBATCH -Chsw
    #SBATCH -t5
    #SBATCH -n1

    module load allinea/reports-6.0

    srun perf-report --nompi ./my_application -i input_file

In this case the result file will be named as
*my\_application\_1p\_2016-04-08\_14-10.txt* where the end of the name
is a time stamp.

#### [][2]3.6.2 Examining the results

The result files are quite self explanatory and in the beginning of the
report there is a short summary with general suggestions for improving
the performance. [Allinea web page] has some example reports with
additional analysis.

|                    |     |                |     |                |     |     |
|--------------------|-----|----------------|-----|----------------|-----|-----|
| [Previous chapter] |     | [One level up] |     | [Next chapter] |     |     |

  [Allinea web pages]: http://www.allinea.com/user-guide/reports/userguide.html
  [1]: https://research.csc.fi/ {#3.6.1}
  [2]: https://research.csc.fi/ {#3.6.2}
  [Allinea web page]: https://www.allinea.com/products/see-allinea-performance-reports-action
  [Previous chapter]: https://research.csc.fi/taito-array-jobs
  [One level up]: https://research.csc.fi/taito-batch-jobs
  [Next chapter]: https://research.csc.fi/taito-compiling-environment
