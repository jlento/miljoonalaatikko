# 1.5 Disk environment

The CSC supercomputing environment allows researchers to analyse and
manage large datasets. Supercluster taito.csc.fi and supercomputer
sisu.csc.fi have a common disk environment and directory structure where
on CSC you can work with datasets that contain several terabytes of
data. In Taito (and Sisu) you can store data in several personal disk
areas. The disk areas available in Taito are listed in Table 1.2 and
Figure 1.2 below. Knowing the basic features of different disk areas is
essential if you wish to use the CSC computing and storage services
effectively. Note that in Taito all directories use the same
Lustre-based file server (except $TMPDIR which is local to each node).
Thus all directories are visible to both the front-end nodes and the
computing nodes of Taito.

In addition to the local directories in Taito, users have access to the
CSC archive server, *HPC archive*, which is intended for long term data
storage. HPC archive server is used through the iRODS software. Projects
that have applied cPouta access can also use the CSC Object Storage
service that can be be used as common storage area for CSC computing
environment, Virtual Machines in cPouta and local computing environment.
( See CSC Computing environment user's guide [Chapter 3.2] and [Chapter
3.3] for more information

 

<table>
<thead>
<tr class="header">
<th>Directory or storage area</th>
<th> Intended use</th>
<th> Default  quota/user</th>
<th> Storage time</th>
<th> Backup </th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>$HOME</td>
<td>Initialization scripts, source codes, small data files.<br />
Not for running programs or research data.</td>
<td>50 GB</td>
<td>Data will be deleted 90 days after closing the account</td>
<td>Yes</td>
</tr>
<tr class="even">
<td>$USERAPPL</td>
<td>Users' own application software.</td>
<td>50 GB</td>
<td>Data will be deleted 90 days after closing the account</td>
<td>Yes</td>
</tr>
<tr class="odd">
<td>$WRKDIR</td>
<td>Temporary data storage.</td>
<td>5 TB</td>
<td><span lang="en">90 days</span></td>
<td>No</td>
</tr>
<tr class="even">
<td>$TMPDIR</td>
<td>Temporary users' files, scratch, compiling.</td>
<td> </td>
<td>2 days**</td>
<td>No</td>
</tr>
<tr class="odd">
<td>project</td>
<td>Common storage for project members. A project can consist of one or more user accounts.</td>
<td>On request.</td>
<td>Data will be deleted 90 days after closing the project</td>
<td>No</td>
</tr>
<tr class="even">
<td><a href="https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers">HPC archive*</a></td>
<td>Long term storage.</td>
<td>2,5 TB</td>
<td>Permanent</td>
<td>Yes</td>
</tr>
<tr class="odd">
<td><a href="https://research.csc.fi/csc-guide-object-storage">Object Storage</a></td>
<td>Platform independed data stotrage</td>
<td>1 TB/ project</td>
<td>Yes</td>
<td>No</td>
</tr>
</tbody>
</table>

\*The HPC-archive server is used through iRODS commands, and it is not
mounted to Taito as a directory.  
\*\* This applies to the files on the login node $TMPDIR. The files in
compute node $TMPDIR are kept for the duration of the batch job and
deleted immediately after it.  
  
The directories listed in the table above can be accessed by normal
linux commands, excluding the archive server, which is used through the
*iRODS* software. The $HOME and $WRKDIR directories as well as the HPC
archive service can also be accessed through the [*MyFiles*] tool of the
Scientist's User Interface WWW service. The $USERAPPL is a subdirectory
of $HOME.  
  
When you are working on command line, you can utilize automatically
defined environment variables that contain the directory paths to
different disk areas (excluding project disk for which there is no
environment variable). So, if you would like to move to your work
directory you could do that by writing:

    cd $WRKDIR

Similarly, copying a file *data.txt* to your work directory could be
done with command:

     cp data.txt $WRKDIR/

In the following chapters you can find more detailed introductions to
the usage and features of different user specific disk areas.

 

##  [][1]1.5.1 Home directory {#home-directory style="text-align: justify;"}

When you log in to CSC, your current directory will first be your home
directory. Home directory should be used for initialization and
configuration files and frequently accessed small programs and files.
The size of the home directory is rather limited, by default it is only
50 GB, since this directory is not intended for large datasets.  
  
The files stored in the home directory will be preserved as long as the
corresponding user account is valid. This directory is also backed up
regularly so that the data can be recovered in the case of disk
failures. Taito and Sisu servers share the same home directory. Thus if
you modify settings files like *.bashrc*, the modifications will affect
both servers.  
  
Inside linux commands, the home directory can be indicated by the
*tilde* character (~) or by using the environment variable, *$HOME*.
Also the command ***cd*** without any argument will return the user to
his/her home directory.  
 

## [][2]1.5.2 Work directory {#work-directory style="text-align: justify;"}

The work directory is a place where you can temporarily store large
datasets that are actively used. By default, you can have up to 5
terabytes of data in it. This user-specific directory is indicated by
the environment variable, $WRKDIR. The Taito and Sisu servers share the
same $WRKDIR directory.  
  
The $WRKDIR is NOT intended for long term data storage. Files that have
not been used for 90 days will be automatically removed. If you want to
keep some data in $WRKDIR for longer time periods you can copy it to
directory $WRKDIR/DONOTREMOVE. The files under this sub directory will
not be removed by the automatic cleaning process. Please note that the
DONOTREMOVE directory is not intended for storing data but to keep
available ONLY such important data that is frequently needed. Backup
copies are not taken of the contents of the work directory (including
DONOTREMOVE directory). Thus, if some files are accidentally removed by
the user or lost due to physical breaking of the disk, the data is
irreversibly lost.

Please do not use *touch* command particularly if you have lot of files
because it is metadata heavy operation and will impact $WRKDIR
performance for all users.

**$WRKDIR F.A.Q.**

-   <span id="yui_patched_v3_11_0_1_1484306829524_594">**Q:** Can I
    check what files the cleaning process is about to remove from my
    $WRKDIR directory?  
    **A:** You can use command *show\_old\_wrkdir\_files* to check the
    files that are in danger to be removed. For example the commands
    below lists the files that are are older than 83 days and thus will
    be removed after the next seven days.</span>

    ~~~~
    show_old_wrkdir_files 83 > files_to_be_removed
    less files_to_be_removed
    ~~~~

    <span lang="en-US">The</span><span lang="en-US"> first command
    produces the list and writes it into a file. Please bear in mind
    that producing the </span><span
    id="yui_patched_v3_11_0_1_1484306829524_593" lang="en-US">list is a
    heavy operation so do it only when needed and refer to the file
    instead.</span>  
     

-   **Q:** I've a zip/tar which I've extracted and file dates are old,
    are those files removed immediately?  
    **A:** No, extracted files will have 90 days grace time.  
     
-   **Q:** I've old reference data which I need for verification often.
    Are those removed?  
    **A:** All files which have been accessed within 90 days are safe
    (read, open, write, append, etc.). Command: *stat filename* will
    show timestamps.  
     
-   <span id="yui_patched_v3_11_0_1_1484306829524_608">**Q:** How do I
    preserve an important dataset I have in $WRKIR?  
    **A:** Make a compressed *tar* file of your data and copy it to HPC
    archive (see [chapter 3.2]  of the CSC  Computing environment user
    guide).</span>

 

 

## [][3]1.5.3 Software installation directory {#software-installation-directory style="text-align: justify;"}

Users of CSC servers are free to install their own application software
on CSC's computing servers. The software may be developed locally or
downloaded from the internet. The main limitation for the software
installation is that  user must be able to do the installation without
using the *root* user account. Further, the software must be installed
on user's own private disk areas instead of the common application
directories like */usr/bin*.  
  
The *user application directory* ***$USERAPPL*** is a directory intended
for installing user's own software. This directory is visible also to
the computing nodes of the server, so software installed there can be
used in batch jobs. Unlike the work directory, $USERAPPL is regularly
backed up.

Sisu and Taito servers have separate $USERAPPL directories. This is
reasonable: if you wish to use the same software in both machines you
normally you need to compile separate versions of the software in each
machine. The $USERAPPL directories reside in your home directory and are
called: *appl\_sisu* and *appl\_taito*. These directories are actually
visible to both Sisu and Taito servers. However, in Taito the $USERAPPL
variable points to $HOME/appl\_taito, and in Sisu to  $HOME/appl\_sisu.

![][4]  
**Figure 1.2** Storage environment in Sisu and Taito computers.

## [][5]1.5.4 Monitoring disk usage {#monitoring-disk-usage style="text-align: justify;"}

  
The amount of data that can be stored to different disk areas is limited
either by user specific quotas or by the amount of available free disk
space. You can check your disk usage and quotas with the command:

    quota

The *quota* command shows also your disk quotas on different areas. If
the disk quota is exceeded, you cannot add more data to the directory.
In some directories, the quota can be slightly exceeded temporarily, but
after a so-called *grace period*, the disk usage must be returned to the
accepted level.  
  
When a disk area fills up, you should remove unnecessary files, compress
existing files and/or move them to the archive server. If you have
well-justified reasons to use more disk space than what your quotas
allow, you should send a request to the CSC resource manager
(resource\_at\_csc.fi).  
  
When one of your directories is approaching the quota limit, it is
reasonable to check which files or folders take up most space. To list
the files in your current directory ordered by size, give command:

    ls -lSrh

Note however, that this command does not tell how much disk space the
files in the subdirectories use. Thus it is often more useful to use the
command **du** (disk usage) instead. You can, for example, try command:

    du -sh ./*

This command returns the size of each file or the total disk usage of
each subdirectory in your current directory. You can also combine *du*
with ***sort*** to see what file or directory is the largest item in
your current directory:

    du -s ./* | sort -n

Note that as the *du* command checks all the files in your current
directory and running the command may in some cases take several
minutes.

 

 

  [Chapter 3.2]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers
  [Chapter 3.3]: https://research.csc.fi/csc-guide-object-storage
  [*MyFiles*]: https://research.csc.fi/%20csc-guide-data-transport-with-scientist-s-user-interface
  [1]: https://research.csc.fi/ {#1.5.1}
  [2]: https://research.csc.fi/ {#1.5.2}
  [3]: https://research.csc.fi/ {#1.5.3}
  [4]: https://research.csc.fi/documents/48467/84606/Disk_environment_2.jpg/5916ea28-3cfe-49a9-8fbe-bb16d47fd136?t=1383829085000
  [5]: https://research.csc.fi/ {#1.5.4}
