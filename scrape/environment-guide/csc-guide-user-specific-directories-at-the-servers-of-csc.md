# 3.1 User specific directories at the servers of CSC {#user-specific-directories-at-the-servers-of-csc .western}

## [][1]3.1.1 Monitoring disk usage {#monitoring-disk-usage .western}

The  amount of  data that  can be  stored to  different disk  areas is
limited either by user specific quotas  or  by the amount of available
free disk space. You can check your disk usage and quotas with command
:

    quota

Below is a sample output for **[quota] ** command:

    [kkayttaj@taito-login3:~> quota
    [_$WRKDIR_usage_]
    Size  Used   Quota  Files    User/Group  /wrk/kkayttaj
    768T  175G   5120G  50369    kkayttaj
    768T  6542G  0G     3953566  csc
    [_$HOME_usage_]
    Size  Used  Quota  Files    User/Group  /homeappl
    43T   1G    20G    3429     kkayttaj
    43T   647G  0G     4838948  csc

The output above shows that the user *kkayttaj* has 50369 files in the
$WRKDIR directory.  These files take  175 GB of the  5120 GB (=  5 TB)
. In addition the user has 1 GB  of data in his home directory. If the
disk  quota  is exceeded,  the  user  can not  add  more  data to  the
directory. The quota  can be slightly exceeded  for a  short time, but
after a so  called *grace period,* the disk usage  must be returned to
level that is less
than the given quota.  
When  a disk  area fills  up, the  solution is  to remove  unnecessary
files, compress  existing files and/or move  some of the files  to HPC
archive. If  you have  well-grounded reasons to  have more  disk space
than what your quotas allow, you should send a request to the CSC user
manager
(*usermgr\_at\_csc.fi*).  
  
When some of  your directories is approaching the quota  limits, it is
useful to  check what files of  folders require most of  the space. To
list the files in your current directory in the order of the file size
give command:

    ls -lSrh

Note however, that the command above does not tell how much disk space
files that  locate in  subdirectories require. Thus  it is  often more
useful  to use  command  **du** (disk  usage) in  stead.  You can  for
example try command:

    du -sh ./*

This command returns the size of each  file or the total disk usage of
each subdirectory in your current directory. You can also combine *du*
command with [sort] to see what  file or directory is the largest unit
in your current directory:

    du -sh ./* | sort -h

Note  that as  *du*  command  checks all  the  files  in your  current
directory, running the command may in some cases take several minutes.

## [][2]3.1.2 Home directory, $HOME {#home-directory-home .western}

When  you  log  in  to  CSC   you  will  first  locate  in  your  home
directory. The home directory is  the storage place for initialization
and  configuration  files  and  constantly  used  small  programs  and
files. The size of home directory  is rather limited, by default it is
only  50  GB, as  this  directory  is  not  intended for  storing  and
analysing large datasets.

The files  stored in the home  directory will be preserved  as long as
the corresponding user  ID is valid.  This directory  is also backuped
regularly  so that  the data  can  be recovered  in the  case of  disk
failures Sisu and Taito servers share the same home directory. Thus if
you  modify settings  files  like *.my.cnf*,  the  modifications  will
affect to usage in both servers.

In linux commands,  the home directory can be indicated  by the *tilde
characte*r   (**~**)   or   by   using   the   environment   variable,
**$HOME**. Also  command **cd** without  any argument will  return the
user to his/her home directory.

## [][3]3.1.3 Work directory, $WRKDIR {#work-directory-wrkdir .western align="JUSTIFY"}

The work  directory is a place  where you can temporarily  store large
datasets that  are actively  used. By  default, you can  have up  to 5
terabytes of data in it.  This user-specific directory is indicated by
the environment  variable, $WRKDIR. The  Taito and Sisu  servers share
the
same $WRKDIR directory.  
  
The $WRKDIR  is NOT intended  for long  term data storage.  Files that
have not been  used for 90 days will be  automatically removed. If you
want to keep some data in $WRKDIR for longer time periods you can copy
it  to  directory  $WRKDIR/DONOTREMOVE.   The  files  under  this  sub
directory   will   not   be   removed  by   the   automatic   cleaning
process. Please  note that the  DONOTREMOVE directory is  not intended
for storing data  but to keep available ONLY such  important data that
is frequently needed.  Backup copies are not taken of  the contents of
the work  directory (including  DONOTREMOVE directory). Thus,  if some
files are  accidentally removed by  the user  or lost due  to physical
breaking of the disk, the data is irreversibly lost.

Please do  not use  *touch* command  particularly if  you have  lot of
files because it  is metadata heavy operation and  will impact $WRKDIR
performance for all users.

**$WRKDIR F.A.Q.**

-   **Q:** Can I check what files the cleaning process is about to
    remove from my $WRKDIR directory?  
    **A:** You can use command *show\_old\_wrkdir\_files* to check the
    files that are  in danger to be removed. For  example the commands
    below lists  the files that  are are older  than 83 days  and thus
    will be removed after the next seven days.

    ~~~~
    show_old_wrkdir_files 83 > files_to_be_removed
    less files_to_be_removed
    ~~~~

    <span  lang="en-US">The</span><span  lang="en-US">  first  command
    produces the list  and writes it into a file.  Please bear in mind
    that  producing  the  </span><span lang="en-US">list  is  a  heavy
    operation so do it only when needed and refer to the file
    instead.</span>  
     

-   **Q:** I've a zip/tar which I've extracted and file dates are old,
    are those files removed immediately?  
    **A:** No, extracted files will have 90 days grace time.  
     
-    **Q:** I've  old reference  data  which I  need for  verification
    often.
    Are those removed?  
    **A:** All files which have been  accessed within 90 days are safe
    (read, open, write, append, etc.). Command: *stat filename* will
    show timestamps.  
     
-   **Q:** How do I preserve an important dataset I have in $WRKDIR?  
    **A:** Make  a compressed *tar* file  of your data and  copy it to
    HPC archive (see [chapter 3.2]).

 

## [][4]3.1.4 Temporary directory, $TMPDIR {#temporary-directory-tmpdir .western align="JUSTIFY"}

Taito server  has a directory for  storing files during the  run. This
user-specific  directory is  indicated  by  the environment  variable,
$TMPDIR. It is intended for storing  files only during the time when a
program is reading  and writing them. Each batch job  reserves its own
temporary directory,  and the  directory and  its contents  are purged
when the  run is completed.  The temporary directories  of interactive
sessions  are  retained  for  24 hours  after  the  last  (read/write)
action. Backup  copies are not  taken of  the contents of  a temporary
directory.

## [][5]3.1.5 Software installation directory, $USERAPPL {#software-installation-directory-userappl .western align="JUSTIFY"}

The users  of CSC servers  are free  to install their  own application
software to the computing servers of CSC. The software to be installed
may be  developed locally  or downloaded from  the internet.  The main
limitation for the software installation is that the user must be able
to do the installation without   using the root user account. Further,
the software must be installed to users own private disk areas instead
of the common application directories like */p/appl/bin* or
*/usr/bin*.  
The *user application directory* **$USERAPPL**  is a directory that is
intended for  installing users own  software tools. This  directory is
visible to the computing nodes of the server too so software installed
there can be used in batch  jobs. Unlike the work directory, old files
are not removed from this directory.  Thus you do not need worry about
preserving you software installation. It  will stay available for you,
until you remove the executables.

The $USERAPPL directories are server  specific. This is reasonable: if
you wish to  use the same software in different  machines you normally
you
need to compile separate versions of the software in each machine.  
The  $USERAPPL  directories locate  in  your  home directory  and  are
called:  *.sisu\_appl*  and   *.taito\_appl*.  These  directories  are
actually visible to  both Sisu and Taito servers. However  the in Sisu
$USERAPPL variable points to *$HOME/.sisu\_appl*,  and in Taito to the
*$HOME/.taito\_appl*.

The $USERAPPL directory utilizes 50 GB disk quota of $HOME directory.

Below are three examples of using the $USERAPPL directory.

-   [Example 1. Installing your own version of program MCL program]

-   [Example 2. Installing and using your own Perl module to Taito]

-   [Example 3. Installing and using your own Python module at Taito]

### [][6]Example 1. Installing your own version of program MCL program {#example-1.-installing-your-own-version-of-program-mcl-program .western align="JUSTIFY"}

In this  example we  install MCL Markov  cluster algorithm  program to
users own $USERAPPL directory on [Taito].

Once you have logged into Taito,  move to your $USERAPPL directory and
create there a new directory called *mcl*.

    cd $USERAPPL
    mkdir mcl

Go to the just created **mcl** directory and download the installation
package with [wget] command

    cd mcl
    wget http://www.micans.org/mcl/src/mcl-latest.tar.gz

In this case the installation package is a [tar-archive] file that has
been compressed with [**gzip**] program. You can unpack this file with
commands

    gunzip mcl-latest.tar.gz
    tar xvf mcl-latest.tar

After unpacking, the **ls** command  shows that a new directory called
*mcl-14-137* has been created to  your *mcl* directory. This directory
contains  the  actual  installation  files and  documentation  of  the
software. Create a new  empty directory called *version-14-137 *to the
mcl directory.

    ls
    mkdir version-14-137

After this go to the *mcl-14-137* directory and study its' content

    cd mcl-14-137/
    ls -l

Installation packages  often contain short  installation instructions.
Typically this instruction file is called as *INSTALL* or *README*. In
this  case you  should read  the *INSTALL*  file to  find out  how the
installation should be done.

    less INSTALL

Many open  source software tools  are installed using  following three
steps:

1.   Building  up the  so  called  *Makefile* with  a  **./configur**e
    command.

2.  Running [**make**] command that compiles the source code according
    to the instructions in the *Makefile.*

3.  Installing the compiled executables with command **make install.**

  
Normally  the   installation  packages  assume,  that   the  user  has
permissions  to  install  the  software to  the  locations  where  the
standard linux commands and  programs normally get installed. However,
at CSC this is not the case. You can install software only to your own
disk  areas.  Often  you can  use option  **--prefix=*****/path/*** to
tell  to  the  configure  command,  where to  the  program  should  be
installed.  In this  case we  wish to  install the  software into  the
*version-09-308* directory in  your $USERAPPL area. Thus  you must use
the following *./configure* command:

    ./configure --prefix=$USERAPPL/mcl/version-14-137

The *configure* command  checks that all the  compilers and libraries,
that  the software  needs, are  available.  It is  not uncommon,  that
*./configure* reports about missing libraries or incorrect compilation
options.  In those  cases  you can  check if  the  missing library  or
program can be taken  in use with the module system.  In Taito you can
see all  the available modules  with command **module avail.**  To use
certain      module,     execute      command     **module      load**
***module\_name***.  Note  also  that   CSC  environment  has  several
compiler versions available. In some cases you may for example need to
use a  certain C-compiler or  python version  in order to  install the
software. If you  still fail with the installation, ask  help from the
[CSC Service Desk].

In  the case  of *mcl*  the  *./configure* script  runs without  error
messages, when  you use  GNU-compilers. The GNU  compilers are  set up
with command:

    module load PrgEnv-gnu

Next need to compile and install the software with commands:

    make
    make install

  
If *make* and  *make install* commands don't give  any error messages,
you  have   successfully  installed   your  software.   Typically  the
executables,  i.e. the  compiled programs  that can  be launched,  are
stored to a sub directory called *bin*. In this case the bin directory
is created to subdirectory *$USERAPPL/mcl/version-14-137.*

Running command

    ls $USERAPPL/mcl/version-14-137/bin

now shows the programs you have installed:

    clm clmformat mcl mclcm mclpipeline mcx mcxarray mcxassemble mcxdump mcxi mcxload mcxmap
    mcxrand mcxsubs

The  name of  the directory  that  contains the  executables may  vary
between  different software.  In  any  case, to  be  able  to use  the
programs you  must tell the  location of  your own executables  to the
command shell.  This can be done  by adding the directory  path of you
executables to the **$PATH** environment variable. In this case we add
path    "**${USERAPPL}/mcl/version-14-137/bin**"    to    the    $PATH
variable. This is done with command:

    export PATH=${PATH}\:${USERAPPL}/mcl/version-14-137/bin

Note that  the first  PATH word  in the command  above is  without the
dollar sign.  Now you can launch  the program you have  installed. For
example

    mcl -h

Remember that  also in the  future, when you log  in to CSC,  the PATH
variable must be set u before you can use **mcl** command. Also in the
batch  job files  you  need  to run  the  correct *export*  ***PATH***
command  above  before  executing   the  program  you  have  installed
yourself.

If the software you have installed works correctly, you can remove the
installation package  and temporary directories that  were used during
the compilation.  In this  case we  could remove  the *mcl-latest.tar*
file and the directory *mcl-09-308/*

    cd $USERAPPL/mcl
    rm mcl-latest.tar
    rm -rf mcl-14-137/

### [][7]Example 2. Installing and using your own Perl module to Taito {#example-2.-installing-and-using-your-own-perl-module-to-taito .western align="JUSTIFY"}

The CPAN Perl  module archive contains thousands of  Perl modules. The
default Perl installation  contains very limited set  of modules while
the  [Bioperl]  installation  at  CSC  contains  a  bit  wider  module
selection.  However, quite  often the Perl module that  you would need
to use  is not available  at CSC. In these  cases you can  install the
Perl  module to  your $USERAPPL  directory. In  this example  the Perl
module *String-Util* is installed.

First, take in use the *perl*  version used by *bioperl*. This version
is newer  than the  default *perl*  in Taito.  It also  includes wider
module selection.

    module swap intel gcc/4.7.2
    module load bioperl

Then go to your $USERAPPL and create directory **my\_perl**

    cd $USERAPPL
    mkdir my_perl
    cd my_perl

Download the *String-Util* installation  package from the CPAN archive
and uncompress and unpack the installation file.

    wget http://search.cpan.org/CPAN/authors/id/M/MI/MIKO/String-Util-1.24.tar.gz
    tar zxvf String-Util-1.24.tar.gz

Then move  to the String-Util  installation directory and  compile the
package  using  the  standard   *perl*  installation  commands.  These
installation commands work for most, but not all, perl modules.

    cd String-Util-1.24/
    perl Makefile.PL PREFIX=$USERAPPL/my_perl
    make
    make test
    make install

Once you  have the  *String-Utl* module installed,  you still  need to
define *$PERL5LIB* environment variable to point to your personal perl
module library:

    export PERL5LIB=${USERAPPL}/my_perl/lib64/perl5/site_perl/5.16.3

After defining  the environment  variable *PERL5LIB* the  beginning of
your Perl script could look like :

    #!/appl/bio/bioperl/5.16.3/bin/perl

    use String::Util ':all';

The installation  procedure, described  above, needs  to be  done only
once.   After the  installation you  still  need to  use the  *export*
command  to set  the  PERL5LIB variable,  each time  you  start a  new
session in Taito.

### [][8]Example 3. Installing and using your own Python module at Taito {#example-3.-installing-and-using-your-own-python-module-at-taito .western align="JUSTIFY"}

  
Default  Python  installation, alike  Perl,  contains  limited set  of
modules. CSC supports several python versions that can be taken in use
with  command  module  load python/*version*.  These  python  versions
normally contain more modules than the default python version.

If  Python module  of interest  is  not available  at CSC,  it can  be
installed in your $USERAPPL directory.  In this example, the Pycluster
module (Pycluster.py) is installed.

**Virtual pyhon environments**

The easiest way to add missing python module for your own us is to use
[virtual python environments]. In  Taito virtual python environment is
automatically activated when you load biopython module:

    module load biopython-env

When  you  run  this  command  for  the  first  time,  python  virtual
environment is created to your $USERAPPL directory. After that you can
add python modules to your  personal python virtual environment easily
with  **pip**  command.  For   example  Pycluster  is  installed  with
commands:

Download the Pycluster installation package:

    wget http://bonsai.hgc.jp/~mdehoon/software/cluster/Pycluster-1.52.tar.gz

Install the package with command:

    pip install Pycluster-1.52.tar.gz

Now the module is ready be user.  Later on, you can access the modules
installed  to your  virtual environment  by running  the *module  load
biopython-env* command.

**Installation from source (old fashioned way)**  
First set  up Python environment and  go to your $USERAPPL  and create
directory my\_python

    module load python-env
    cd $USERAPPL
    mkdir my_python
    cd my_python

Download  the  Pycluster  python   module  installation  package   and
uncompress and unpack the installation file.

    wget http://bonsai.hgc.jp/~mdehoon/software/cluster/Pycluster-1.52.tar.gz
    tar zxvf Pycluster-1.52.tar.gz

Then, move to the installation file  and compile the package using the
standard python installation command.

    cd Pycluster-1.52/
    python setup.py install --prefix=$USERAPPL/my_python

In  the installation  command  above, the  *--prefix*  option in  used
instruct the installation script to  install the python module to your
own  python  library  directory,  in stead  of  the  standard  library
location.

Once you have the Pycluster module installed, you still need to define
$PYTHONPATH  environment variable  to  point to  your personal  Python
module library:

`export
PYTHONPATH=${USERAPPL}/my_python/lib/python2.7/site-packages:$PYTHONPATH`

After defining  the environment  variable PYTHONPATH the  beginning of
your Python script could look like :

    #!/usr/bin/python
    import Pycluster

The installation  procedure, described  above, needs  to be  done only
once.   After the  installation you  still  need to  use the  *export*
command to  set the  PYTHONPATH variable,  each time  you start  a new
session in Taito.

  [1]: https://research.csc.fi/ {#3.1.1}
  [quota]: https://research.csc.fi/ {#quota}
  [sort]: https://research.csc.fi/csc-guide-commands-for-data-processing#sort
  [2]: https://research.csc.fi/ {#3.1.2}
  [3]: https://research.csc.fi/ {#3.1.3}
  [chapter 3.2]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers
  [4]: https://research.csc.fi/ {#3.1.4}
  [5]: https://research.csc.fi/ {#3.1.5}
  [Example 1. Installing your own version of program MCL program]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex1
  [Example 2. Installing and using your own Perl module to Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex2
  [Example 3. Installing and using your own Python module at Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex3
  [6]: https://research.csc.fi/ {#ex1}
  [Taito]: https://research.csc.fi/taito-user-guide
  [wget]: http://www.csc.fi/english/pages/data-services/csc_disks/transport/wget_usage
  [tar-archive]: https://research.csc.fi/csc-guide-packing-and-compression-tools#tar
  [**gzip**]: https://research.csc.fi/csc-guide-packing-and-compression-tools#gzip
  [**make**]: https://research.csc.fi/ {#make}
  [CSC Service Desk]: https://research.csc.fi/support
  [7]: https://research.csc.fi/ {#ex2}
  [Bioperl]: http://www.csc.fi/english/research/sciences/bioscience/programs/bioperl/index_html
  [8]: https://research.csc.fi/ {#ex3}
  [virtual python environments]: http://www.virtualenv.org/en/latest/virtualenv.html
