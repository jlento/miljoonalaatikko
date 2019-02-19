# 3 Directories and data storage at CSC {#directories-and-data-storage-at-csc .western style="page-break-before: always"}

The CSC supercomputing environment allows researchers to analyse and
manage large datasets. Even with a normal CSC user account the
researchers can work with datasets that contain several terabytes of
data. Each CSC user has access to four personal disk areas that can be
used for processing data.  For long term data storage, customers of CSC
can use *HPC archive* server or *IDA* service. 

Knowing the basic features of different disk storage areas is essential,
if you wish to use the CSC computing services effectively.

**Table 3.1:** Standard user directories at CSC. The  *HPC Archive* is
used through iRODS commands, and it is not mounted to CSC computing
environment as a directory. Directories that can be accessed via
Scientist's User Interface web portal are marked with an asterisk (\*).

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 45%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 10%" />
</colgroup>
<thead>
<tr class="header">
<th>Directory or storage area</th>
<th>Intended use</th>
<th>Default quota/user</th>
<th>Storage time</th>
<th>Backup</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>$HOME *</td>
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
<td>$WRKDIR *</td>
<td>Temporary data storage.</td>
<td>5 TB</td>
<td><span lang="en">90 days</span></td>
<td>No</td>
</tr>
<tr class="even">
<td>$TMPDIR</td>
<td>Temporary users' files.</td>
<td> </td>
<td>2 days</td>
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
<td>HPC Archive *</td>
<td>Long term storage.</td>
<td>2,5 TB</td>
<td>Permanent</td>
<td>Two copies maintained</td>
</tr>
<tr class="odd">
<td>IDA</td>
<td>Long term storage.</td>
<td>On request</td>
<td>Permanent</td>
<td>Part of the Open Science and Research services.</td>
</tr>
<tr class="even">
<td>Pouta Object Stoirage</td>
<td>Storage and sharing</td>
<td>1 TB</td>
<td>Permanent</td>
<td> </td>
</tr>
</tbody>
</table>

 

The directories listed in the table above can be accessed through linux
command line usage.  $HOME, $WRKDIR and HPC Archive can also be accessed
through the Scientist's User Interface web portal
(<https://sui.csc.fi>). When you are working on command line, you can
utilize automatically defined environment variables that contain the
directory paths to different disk areas (excluding project disk for
which there is no environment variable). So, if you would like to move
to your *work directory* you could do that with command:

    cd $WRKDIR

similarly, copying a file *data.txt* to your *work director*y could be
done with command:

    cp data.txt $WRKDIR/

In the following chapters you can find more detailed introductions to
the usage and features of different user specific disk areas.

 

## [3.1 User specific directories at the servers of CSC] {#user-specific-directories-at-the-servers-of-csc .western}

[3.1.1 Monitoring disk usage][]  
[3.1.2 Home directory, $HOME][]  
[3.1.3 Work directory, $WRKDIR][]  
[3.1.4 Temporary directory, $TMPDIR][]  
[3.1.5 Software installation directory $USERAPPL][]  
[  Example 1. Installing your own version of program MCL program][]  
[  Example 2. Installing and using your own Perl module to Taito][]  
[  Example 3. Installing and using your own Python module to Taito]

## [3.2. Archiving data to the HPC archive and IDA storage services] {#archiving-data-to-the-hpc-archive-and-ida-storage-services .western}

[3.2.1 Using HPC archive][]  
[  Example 1. Storing data to the HPC archive server][]  
[  Example 2. Retrieving data from the archive server][]  
[3.2.2 Configuring the connection to IDA][]  
[  Example 3. Storing data to the IDA server][]  
[3.2.3 Using HPC Archive and Ida with Scientist's User Interface]  
 

## [3.3 Using Object Storage in CSC computing environment]

[3.3.1 Configuring s3cmd tool in Taito][]  
[3.2 Using Object Storage with s3cmd]

 

  [3.1 User specific directories at the servers of CSC]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc
  [3.1.1 Monitoring disk usage]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#3.1.1
  [3.1.2 Home directory, $HOME]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#3.1.2
  [3.1.3 Work directory, $WRKDIR]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#3.1.3
  [3.1.4 Temporary directory, $TMPDIR]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#3.1.4
  [3.1.5 Software installation directory $USERAPPL]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#3.1.5
  [  Example 1. Installing your own version of program MCL program]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex1
  [  Example 2. Installing and using your own Perl module to Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex2
  [  Example 3. Installing and using your own Python module to Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex3
  [3.2. Archiving data to the HPC archive and IDA storage services]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers
  [3.2.1 Using HPC archive]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#3.2.1
  [  Example 1. Storing data to the HPC archive server]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#ex1
  [  Example 2. Retrieving data from the archive server]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#ex2
  [3.2.2 Configuring the connection to IDA]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#3.2.2
  [  Example 3. Storing data to the IDA server]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#ex3
  [3.2.3 Using HPC Archive and Ida with Scientist's User Interface]: https://research.csc.fi/csc-guide-archiving-data-to-the-archive-servers#3.2.3
  [3.3 Using Object Storage in CSC computing environment]: https://research.csc.fi/csc-guide-object-storage
  [3.3.1 Configuring s3cmd tool in Taito]: https://research.csc.fi/csc-guide-object-storage#3.3.1
  [3.2 Using Object Storage with s3cmd]: https://research.csc.fi/csc-guide-object-storage#3.3.2
