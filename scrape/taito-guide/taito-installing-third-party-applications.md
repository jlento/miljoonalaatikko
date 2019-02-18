# 5. User's own software installations

The users of CSC servers are free to install their own application
software to Taito. The software to be installed may be developed locally
or downloaded from the internet. The main limitation for the software
installation is that the user must be able to do the installation
without using *root* user account or *sudo* command. Further, the
software must be installed to users own private disk areas instead of
the common application directories like */appl/bin* or */usr/bin*.<span
style="color: rgb(0,0,0);"> </span>If root access is needed, e.g. in the
case of repository installations, you an consider using the [Pouta could
computing service] in stead  of Taito.

In Taito, *user application directory* **$USERAPPL** is a directory that
is intended for installing users own software tools. Taito and Sisu
severs have separate $USERAPPL directories. Like the work directory,
this directory is visible to the computing nodes of the server too so
software installed there can be used in batch jobs. Unlike the work
directory $USERAPPL is permanent and backuped directory. Thus you do not
need worry about preserving you software installation. It will stay
available for you, until you remove the executables.

Below are three examples of using the $USERAPPL directory.

### [Example 1. Installing your own version of MCL program]

### [Example 2. Installing and using your own Perl module in Taito] {#Installingthirdpartyapplications-softwareinstallationdirectoryUSERAPPL-Example2InstallingandusingyourownPerlmoduletoTaito .western}

### [Example 3. Installing and using your own Python module in Taito] {#Installingthirdpartyapplications-softwareinstallationdirectoryUSERAPPL-Example3InstallingandusingyourownPythonmoduleatTaito .western}

 

 

  [Pouta could computing service]: https://research.csc.fi/pouta-user-guide
  [Example 1. Installing your own version of MCL program]: https://research.csc.fi/taito-example-1.
  [Example 2. Installing and using your own Perl module in Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex2
  [Example 3. Installing and using your own Python module in Taito]: https://research.csc.fi/csc-guide-user-specific-directories-at-the-servers-of-csc#ex3
