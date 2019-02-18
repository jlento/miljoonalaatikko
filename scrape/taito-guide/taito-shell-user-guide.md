# 7. Using Taito-shell for running interactive jobs in Taito

## [][1]7.1 What is Taito-shell {#what-is-taito-shell style="text-align: justify;"}

The *Taito-shell* environment is intended for **interactive use of
scientific applications maintained by CSC**, **serial jobs** and usage
of **graphical application interfaces**. The Taito-shell computing
environment is part of the [Taito cluster].

Taito-shell emulates normal application server like behavior. For the
user, it appears very much like a normal Linux server: you can log in
and run applications interactively with Linux commands. Taito-shell uses
the same the [disk environment], software stack [and module system] as
the normal Taito cluster. The difference to the Taito login nodes is,
that Taito-shell does not have the 1 hour time limit for jobs, that are
executed interactively. Instead, a job started in Taito-shell can run as
long as the Taito-shell session remains open.

From the technical point of view, Taito-shell is an oversubscribed
interactive batch queue on the Taito super cluster. When you log in to
*taito-shell.csc.fi*, you are automatically connected to an interactive
batch job running in this unlimited partition.

Using this kind of approach has the following advantages over a
traditional application server:

-   Taito-shell uses the same resources as Taito, like home directory,
    $WRKDIR directory and installed software. You can easily switch
    between interactive working and batch jobs based working.
-   Better scalability: In case of high demand, more Taito nodes can be
    assigned to Taito-shell and vice versa.
-   Improved load balancing: The number of users per Taito-shell node
    can be better controlled.

Taito-shell is, however, not a separate Linux server and it has two
important exceptions compared to traditional Linux application servers:

-   **No direct node access**. "ssh taito-shell.csc.fi" logs in to the
    next free Taito-shell node on Taito. You cannot determine on which
    node you will end up. We are aware that specific node access is
    sometimes necessary, please see the FAQ section below on how to
    achieve this.
-   **screen/nohup does not work** in Taito-shell. Logging out of
    Taito-shell kills all processes of the user in question, also
    background jobs. For long running jobs you can use [Taito's batch
    job system], or, for smaller scale jobs, consult the FAQ.

**The features of Taito-Shell environment in a nutshell:**

-   Direct login with the address: taito-shell.csc.fi
-   Offers no-queuing interactive use of software installed on Taito
-   Uses the same file system and network shares as Taito.
-   Enables seamless switching between quick interactive use and batch
    jobs.
-   Computing capacity up to 4 cores per user
-   Shared memory of up to 128 GB per user

Jobs that utilize more than 4 cores or that require more than 128 GB
memory usage should be executed as batch jobs in Taito or in Sisu.

## [][2]7.2 Using Taito-shell

### [][3]7.2.1 Obtaining a user id

If you have a user account for Taito, you can use it to login to
*Taito-shell* too.

**If you are a new customer** for CSC's computing and application
software services, see first instructions for new customers below. The
application procedure depends on whether your are an academic user or
not.

<https://research.csc.fi/csc-guide-getting-access-to-cscs-resources>

New CSC users get access to Taito and Taito-Shell per default. After
registration, users not assigned to any project, get a small default
quota ( 5000 bu) to run small jobs on Taito-shell.

### [][4]7.2.2 Logging in

There are two ways to login:shell login (ssh, Putty etc.)  and
*[NoMachine]* for graphical logins.

### 7.2.2.1 Logging in via ssh

To log in, normally one has to first access a local workstation (at
university or some other site on the Internet) and then use an SSH
program to connect to Taito-shell (**taito-shell.csc.fi**) with your
**CSC user\_id**:

    ssh -X csc_user_id@taito-shell.csc.fi

After you have provided your password, you will see a prompt similar to
the one below, the number might be different:

    [user_id@c305 ~]

Taito-shell is now ready to execute your commands. For more information
on connecting to CSC's servers via SSH please consult [the general guide
on how to use SSH at CSC].

### 7.2.2.2. Logging in via NoMachine

Graphical logins to *Taito-shell* are possible via [NoMachine][5]. You
need to download and install a NoMachine client and configure it to use
the server *nxkajaani.csc.fi*. Please consult the [NoMachine][5]
documentation on how to get graphical access. To start Taito-Shell in
*NoMachine*, right click with the mouse in the Desktop area, choose
*Taito-shell* from the pull-down menu, add your password, and you are
logged in. You can now type in the commands to launch the software you
want to use, eg. for Rstudio commands would be

    module load r-env
    module load rstudio
    rstudio

 

### 7.2.3 Submitting batch jobs from Taito-shell

Taito-shell.csc.fi environment is configured for running commands
interactively. You can submit batch jobs from Taito-shell to
taito.csc.fi cluster. However to do that, you need to add definition **
**-M csc** either top the batch job commands or to the \#SBATCH lines of
the batch job files.

For example to submit a batch job command you should use command:

    sbatch -M csc batch_job_file.sh

In the same way, the status of the jobs , running in Taito cluster, can
be checked with command

    squeue -M csc -l

(Running *squeue* command without *-M csc* would list the current
taito-shell.csc.fi sessions)

 

###   {#section style="text-align: justify;"}

### [][6]7.3 Taito-shell FAQ

  [1]: https://research.csc.fi/ {#8.1}
  [Taito cluster]: https://research.csc.fi/taito-operating-system-and-shell-environment
  [disk environment]: https://research.csc.fi/taito-disk-environment
  [and module system]: https://research.csc.fi/taito-module-system
  [Taito's batch job system]: https://research.csc.fi/taito-batch-jobs
  [2]: https://research.csc.fi/ {#8.2}
  [3]: https://research.csc.fi/ {#8.2.1}
  [4]: https://research.csc.fi/ {#8.2.2}
  [NoMachine]: https://research.csc.fi/-/nomachine "Create this topic"
  {.foswikiNewLink}
  [the general guide on how to use SSH at CSC]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc#1.3.2
  [5]: https://research.csc.fi/csc-guide-connecting-the-servers-of-csc#1.3.3
  [6]: https://research.csc.fi/ {#8.3}
