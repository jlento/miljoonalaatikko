# 3.5 Array jobs in Taito

## [][1]3.5.1 Defining an array job

In many cases the computational analysis job contains a number of
similar independent subtasks. The user may have several datasets that
will be analyzed in the same way or same simulation code is executed
with a number of different parameters. These kind of tasks are often
called as "*embarrassingly parallel*" jobs as the task can be in
principle distributed to as many processors as there are subtasks to be
run. In Taito this kind of tasks can be effectively run by using the
*array job* function of the SLURM batch job system.

In SLURM, an array job is defined by using the option **--array ** or
-***a*** . For example definition:

    #SBATCH --array=1-100

  
will launch not just one batch job, but 100 batch jobs where the subjob
specific environment variable **$SLURM\_ARRAY\_TASK\_ID** gets values
form 1 to 100. This variable can then be utilized in the actual job
launching commands so that each subtask gets processed. All the subjobs
are launched to the batch jobs system at once and they will be executed
using as many processors as there are available.

**Note that in Taito the range of the $SLURM\_ARRAY\_TASK\_ID variable
is limited between 0 and 1000. **

In addition to a defining a job range, you can also provide a list of
job index values. For example definition:

    #SBATCH --array=4,7,22

would launch three jobs with $SLURM\_ARRAY\_TASK\_ID values 4, 7 and 22.

You can also add a step size to the job range definition. For example
following array job definition:

    #SBATCH --array=1-100:20

would run five jobs with $SLURM\_ARRAY\_TASK\_ID values: 1, 21, 41, 61
and 81.

In some cases it may be reasonable to limit to number of simultaneously
running processes. This is done with notation: %*max\_number\_of\_jobs.*
For example, in a case were you have 100 jobs but a license for only
five simultaneous processes, you could ensure that you will not run out
of license with following definition:

    #SBATCH --array=1-100%5

 

## [][2]3.5.2 Simple array job example

As a first array job example lets assume that we have 50 datasets
(data\_1.inp, data\_2.inp … data\_50.inp) that we would like to analyze
using program *my\_prog,* that uses syntax:  
`   my_prog inputfile outputfile`  
Each of the subtasks requires less than 2 hours of computing time and
less than 4 GB of memory. We can perform all 50 analysis tasks with
following batch job script:[][3]

    #!/bin/bash -l
    #SBATCH -J array_job
    #SBATCH -o array_job_out_%A_%a.txt
    #SBATCH -e array_job_err_%A_%a.txt
    #SBATCH -t 02:00:00
    #SBATCH --mem-per-cpu=4000
    #SBATCH --array=1-50
    #SBATCH -n 1
    #SBATCH -p serial

    # move to the directory where the data files locate
    cd data_dir
    # run the analysis command
    my_prog data_"$SLURM_ARRAY_TASK_ID".inp data_"$SLURM_ARRAY_TASK_ID".out

In the batch job script the line *\#SBATCH --array=1-50* defines that 50
subjobs will be submitted. Other *\#SBATCH* lines refer to the
individual subjobs. In this case one subjob uses one processor (*-n 1*)
max. 4 GB of memory (*--mem-per-cpu=4000*) and can last max. 2 hours (
*-t 02:00:00* ). However, the total wall clock time needed to process
all the 50 tasks is not limited by any sense.  
  
In the job execution commands, the script utilizes
*$SLURM\_ARRAY\_TASK\_ID* variable in the definition of input and output
files so that the first subjob will run command:

    my_prog data_1.inp data_1.out

second will run command:

    my_prog data_2.inp data_2.out

and so on.  
  
The job can be now launched with command:

    sbatch job_script.sh

Typically not all jobs get into the execution at once. However after a
while a large number of jobs may be running in the same time. When the
batch job is finished the data\_dir directory contains 50 output files.

If you give command **squeue -l** after submitting your array job, you
can see that you have one job pending and possibly several jobs running
in the batch job system. All these jobs have a *jobid* that contain two
parts: *jobid number* of the array job and the *sub-job number*.
Directing the output of each subjob into a separate file is recommended
as the file system may fail if several dozens of processes try to write
into same file at the same time. If the output files need to be merged
into one file it can often be easily done after the array job has
finished. For example in the case above we could collect the results
into one file with command:

    cat data_*.out > all_data.out

In the case of standard output and error files, defined in the SBATCH
lines,  you can use definitions **%A**  and **%a** to give unique names
to the output files of each sub-job. In the file names *%A* will be
replaced by the *ID of the array job* and *%a* will be replaced by the
*$SLURM\_ARRAY\_TASK\_ID*.

## [][4]3.5.3 Using a file name list in an array job

In the example above, we were able to use $SLURM\_ARRAY\_TASK\_ID to
refer to the order numbers in the input files. If this type of approach
is not possible a list of files or commands, created before the
submission of the batch jobs, can be used. Let's assume that we have a
similar task as defined above, but the file names don't contain numbers
but are in format data\_aa.inp, data\_ab.inp, data\_ac.inp… and so on.
Now we need first to make a list of files to be analyzed, In this case
we could collect the file names into file "namelist" with command:

    ls data_*.inp > namelist

In example below we will use command :

     sed –n "row_number"p inputfile

to read a certain line form the name list file. In this case the actual
command script could be following:[][5]

    #!/bin/bash -l
    #SBATCH -J array_job
    #SBATCH -o array_job_out_%j.txt
    #SBATCH -e array_job_err_%j.txt
    #SBATCH -t 02:00:00
    #SBATCH --mem-per-cpu=4000
    #SBATCH --array=1-50
    #SBATCH -n 1
    #SBATCH -p serial

    # move to the directory where the data files locate
    cd data_dir
    # set input file to be processed
    name=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist)
    # run the analysis command
    my_prog $name $name.out

This example is otherwise similar to the first one, but it will read the
name of the file to be analyzed form a file called *namelist*. This
value is stored into variable *$name*, which will be used in the job
execution command. As the row number to be read is defined by the
*$SLURM\_ARRAY\_TASK\_ID,* each data file listed in the file *namelist*
will get processed in a different subjob. Note that as we now use the
*$name* also in the output definition the output file name will be in
format data\_aa.inp.out, data\_ab.inp.out, data\_ac.inp.out… and so on.

 

[][6]

## 3.5.4 Using array jobs in workflows with sbatch\_commandlist

In Taito, you can use command **sbatch\_commandlist** to execute a list
of commands as an array job. This command takes as an input a text file.
Each row in this file is executed as an independet sub-task of a array
batch job, automatically generated by the *sbatch\_commandlist*.

The sytax of this command is:

    sbatch_commandlist -commands commandlist

Options *-t* and *-mem* can be used to modify the time and memory
reservation of the subjobs (default 12 h, 8GB).

After submitting an array job, *sabatch\_commandlist* monitors the
progress of the job and finishes only when the array job has finished.
Thus this command can be used in workflows (including batch job 
scripts), where only certain steps of the workflow can utilize array
jobs based parallel computing.

As an example, lets assume we have a gzip compressed tar-archive file
*my\_data.tgz* containing a directory with a large number of files. To
create a new compressed archive, that includes also a md5 checksum file
for each file we would need to: (1) un-compress and un-pack
*my\_data.tgz*,  (2) execute *md5sum* for each file and finally (3) pack
and compress the *my\_data* directory again. The second step of the
workflow could be executed using a for-loop, but we could also use the
loop just to generate a list of *md5sum* commands, that can be processed
with *sbatch\_commandist*.

[][7]

    #!/bin/bash -l
    #SBATCH -J workfow
    #SBATCH -o workflow_out_%j.txt
    #SBATCH -e workflow_err_%j.txt
    #SBATCH -t 12:00:00
    #SBATCH --mem=4000
    #SBATCH -n 1
    #SBATCH -p serial

    #open the tgz file
    tar zxf my_data.tgz
    cd my_data

    #generate a list of md5sum commands
    for my_file in *
    do
      echo "md5sum $my_file > $my_file.md5" >> md5commands.txt
    done

    #execute the md5commands as an array job
    sbatch_commandlist -commands md5commands.txt

    #remove the command file and compress the directory
    rm -f md5commands.txt
    cd ..
    tar zcf my_data_with_md5.tgz my_data
    rm -rf my_data

Note that the batch job script above is not an array job, but it
launches a another batch job that is an array job.

|                    |     |                |     |                |     |     |
|--------------------|-----|----------------|-----|----------------|-----|-----|
| [Previous chapter] |     | [One level up] |     | [Next chapter] |     |     |

 

  [1]: https://research.csc.fi/ {#3.5.1}
  [2]: https://research.csc.fi/ {#3.5.2}
  [3]: https://research.csc.fi/ {#slurm5}
  [4]: https://research.csc.fi/ {#3.5.3}
  [5]: https://research.csc.fi/ {#slurm6}
  [6]: https://research.csc.fi/ {#3.5.4}
  [7]: https://research.csc.fi/ {#slurm7}
  [Previous chapter]: https://research.csc.fi/taito-interactive-batch-jobs
  [One level up]: https://research.csc.fi/taito-batch-jobs
  [Next chapter]: https://research.csc.fi/taito-allinea-perf
