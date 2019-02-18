# 1.5 Monitoring and applying computing resources

In  CSC's environment  the  computing quota  is  measured in  *billing
units* and the storage space in *terabytes*.

## [][1]1.5.1 Applying for computing resources {#applying-for-computing-resources .western}

Each  project has  got  a certain  amount of  billing  units that  are
consumed  by the  computing  tasks and  virtual  machines executed  at
CSC. The billing  unit consumption is calculated in  different ways in
different platforms:

-   In  **Sisu** supercomputer the billing  unit is defined so  that 1
    CPU core hours consumes 2 billing units.
-   In **Taito** cluster the  billing unit consumption is based either
    on  the number  of reserved  cores or  number (rounded  up to  the
    nearest  integer) of  4 GB  blocks of  memory, depending  which is
    larger. For example:
    -   an 8 core job with 16 GB of memory will be billed with 2 x 8 =
        16 billing units per hour,
    -   an 8 core job with 64 GB  of memory will be billed with 2 x 16
        = 32 billing units per hour.

To get more  resources for a *Commercial Project*  requires renewal of
the [customer agreement] with CSC.

Additional  computing  resources  can  be  applied  for  an  *Academic
Project*  in the  Scientist's User  Interface. Any project  member can
apply for additional resources, not just the project's PI.

To apply  for more billing  units for  computing, please open  the [My
Projects tool].  Select the project  for which  you want to  apply for
more resources.  Then choose *Apply  For Resources*. Fill in  the form
that  opens.  You  can  find  the  filling  instructions  by  clicking
Help. Press Send to submit your application.

![][2]

**Figure:** Resource application form for an Academic Project.

[The upcoming  deadlines for  resource applications] are  available on
main CSC  webpages. See also the  instructions on how to  to apply for
more data storage space for your project.

Those who  require exceptionally large computing  or storage resources
can apply  for them  through periodically announced  [Grand Challenge]
and [PRACE] Tier-0 and Tier-1 calls.

## [][3]1.5.2 Switching between projects {#switching-between-projects .western}

If you have  more than one project  you might want to  use one project
for certain tasks and the other  projects for other tasks. This can be
done by changing the user's *billing project*.

The default  billing project for Taito  and Sisu can changed  with the
[My Projects tool] in the  Scientist's User Interface. This tool lists
the  computing  projects you  can  use.  To  set the  default  billing
project, select  a project  from the  list and  press "Set  As Billing
Project" as decribed in [Chapter 1.4.3.]

To change  the billing project temporarily  on Taito or Sisu,  run the
[][4]**newgrp**  command on  the command  line. This  command actually
changes the primary Linux group. It  takes as the argument the name of
the  group that  you want  your new  primary group  to be.  Groups and
projects are linked with each other.

The *newgrp*  command is  best used in  combination with  the *sbatch*
command (the command  that submits batch jobs to  computing nodes, see
[chapter 4.3]):

    taito-login3:~$ newgrp project_2000084
    taito-login3:~$ sbatch job1.sh
    Submitted batch job 10282312
    taito-login3:~$ newgrp project_2000251
    taito-login3:~$ sbatch job2.sh
    Submitted batch job 10282313

The first job will be charged to the project 2000084 and the second to
the project 2000251. You can check  the groups you belong to using the
command **groups** or **id**.

## [][5]1.5.3 Viewing computing resource usage {#viewing-computing-resource-usage .western}

When your computing quota is zero  or close to zero, you start getting
this kind of warnings:

    WARNING: You belong to the project 2000251, which has used over 90% of its quota.
    CRITICAL: You belong to the project 2000084, which has used all its CPU time quota.
    Project 2000084 is not allowed to submit any new jobs.

 

The project whose  resources are finished you can no  longer use batch
jobs in Sisu or Taito:

    taito-login4:~$ sbatch job.sh
    sbatch: error: Job aborted, your project ran out of CPU quota.
    sbatch: error: Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)

When your storage quota is used up, you get this kind of errors:

    write error: Disk quota exceeded

The usage  of computing resources  can be monitored both  on computing
servers and at the Scientist's User Interface. The storage space usage
can be monitored only on computing servers.

To view  computing resource usage  at the Scientist's  User Interface,
sign in to the service and open the My Projects tool (Figure 1.4). The
usage  is shown  in the  *Information* box.  In the  future, the  *CPU
Usage* box  will provide more  detailed information about  your usage:
you could for example define a time  period to be viewed or break down
the usage by project members.

Computing quota is expressed in billing units and the storage space in
gigabytes. The  billing unit  is defined  so that 1  CPU core  hour on
Sisu, Taito or cPouta consumes 2 billing units.

The computing  resource usage  can be  monitored on  computing servers
using the [][6]**saldo** command. An  example output is shown below. A
more detailed documentation about the [saldo command] is available.

    taito-login4:~$ saldo
    -----------------------------------------------------------------
    Saldo for year 2016 month 8
    Report updated 23.08.2016 10:15
    -----------------------------------------------------------------
    Project 10002444  Personal group of adam
    start 17.06.2016      end: XXX              budget: 01.01.1970
    CSC budget: 1000      used: 1000            remain: 0
    -----------------------------------------------------------------
    Project 2000084  Air flow simulations of funny hats Professor Propelli
    start 14.09.2015      end: 13.09.2017       budget: 14.08.2016
    CSC budget: 10000     used: 10000           remain: 0
    -----------------------------------------------------------------
    Project 2000251  Optimization of propeller design for hats Professor Propelli
    start 03.02.2016      end: 02.02.2018       budget: 03.02.2016
    CSC budget: 10000     used: 800             remain: 200
    -----------------------------------------------------------------
             Cpu usage         Cpu secs     Bu
                             ------------------
    2000084  adam                360000    100 sisu
             adam                720000    200 taito
             adam       Tot     1080000    300

    2000084  bertta              360000    100 taito
             bertta     Tot      360000    100

             Cpu        total   1440000    400

 

## [][7]1.5.4 Viewing storage space usage {#viewing-storage-space-usage style="text-align: justify;"}

The storage space usage can be checked from the command line using the
**quota**  command.  An  example  output  is  shown  below.  For  more
information on the *quota* command, and hints on how to find the files
that use the most space, see [chapter 3.1].

    taito-login4:~$ quota
    [_$WRKDIR_usage_]
    Size  Used   Quota  Files  User/Group  /wrk/adam
    3.4P  9.54G  5120G  14     adam
    3.4P  0.00G  0G     0      project_2000084
    3.4P  9.54G  0G     14     project_2000251
    3.4P  0.00G  0G     0      project_10002444
    [_$HOME_usage_]
    Size  Used   Quota  Files  User/Group  /homeappl
    43T   8.19G  50G    87156  adam
    43T   4.83G  0G     49839  project_2000084
    43T   2.64G  0G     34886  project_2000251
    43T   0.72G  0G     2431   project_10002444
    [_$PROJ_usage_]
    Size  Used   Quota  Files  Group    /proj
    385T  0.00G  0G     0      project_2000084
    385T  0.00G  0G     0      project_2000251
    385T  0.00G  0G     0      project_10002444
    [_HPC_Archive_usage_]
    HPC-Archive used space summary for 'adam'.
    Amount of archived files: 1.
    Amount of files received but not yet archieved (in queue for archiving): 0.
    Quota: 2500.0GB.
    Space used (archived files): 0/2500GB.
    Total space used (archived files + files in queue): 0/2500GB (0.00 %).

 

  [1]: https://research.csc.fi/ {#1.5.1}
  [customer agreement]: https://www.csc.fi/services-for-companies/
  [My Projects tool]: https://sui.csc.fi/group/sui/my-projects
  [2]: https://research.csc.fi/documents/48467/84606/SUI_Applyresources_formHelp.png/a8d0bc6e-a0cc-476a-bbf8-96f6bf74b791?t=1489675661643
  [The upcoming deadlines for resource applications]: https://www.csc.fi/applying-for-computing-resources/
  [Grand Challenge]: http://www.csc.fi/grand-challenge-proposals/
  [PRACE]: https://research.csc.fi/prace
  [3]: https://research.csc.fi/ {#1.5.2}
  [Chapter 1.4.3.]: https://research.csc.fi/csc-guide-projects-and-resource-allocation#1.4.3
  [4]: https://research.csc.fi/ {#newgrp}
  [chapter 4.3]: https://research.csc.fi/csc-guide-batch-jobs
  [5]: https://research.csc.fi/ {#1.5.3}
  [6]: https://research.csc.fi/ {#saldo}
  [saldo command]: https://research.csc.fi/saldo
  [7]: https://research.csc.fi/ {#1.5.4}
  [chapter 3.1]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc
