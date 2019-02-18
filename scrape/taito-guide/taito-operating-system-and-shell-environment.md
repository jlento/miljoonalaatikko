# 1.2 Operating system and shell environment

Taito is a Linux cluster. The login nodes are based on the *RedHat
Enterprise Linux 6 (RHEL6*) distribution, while the computing nodes use
*CentOS 6*, which is a free distribution entirely derived from RHEL6.
During the lifetime of the cluster, we aim to keep the software packages
up to date following the minor releases of the operating system, as long
as this preserves the necessary compatibility with the previous
versions. The computing nodes have identical software configuration. The
same applies to the login nodes. The system software set installed on
the login and computing nodes is relatively minimal but it offers a wide
selection of libraries and development packages to compile your own
software. In general, all the libraries available on the computing nodes
are also available on the login nodes. You can inspect what packages are
installed on Redhat based servers using the following command:

`rpm -qa`

This command is also useful to find out what is the version of an
installed package. Other options can be given to the ***rpm*** command
to inspect the system configuration. Alternatively, ***locate*** and
***find*** are also good tools for inspecting the software configuration
of a system. Note that users can't use *rpm* command to install software
to Taito.

The system packages will be updated during the lifetime of the system
without any previous notification. Therefore, we suggest using the
module system to load specific library versions and software supported
by CSC, or install your own version in *$USERAPPL* directory. In this
way your software dependencies will be safely preserved.

As a general rule, x86-64 binaries should be used for software installed
on Taito. "x86-64" is the 64-bit extension of the x86 instruction set.

The default and <span style="line-height: 1.4;">recommended </span><span
style="line-height: 1.4; text-align: left;">command shell in Taito is
</span>**bash**<span style="line-height: 1.4; text-align: left;">.
Previously CSC has been using </span>*tcsh*<span
style="line-height: 1.4; text-align: left;"> as the default command
shell and you can still continue to use </span>*tcsh*<span
style="line-height: 1.4; text-align: left;"> shell in Taito too</span>.
If you want to change your default shell in Taito, please contact
<servicedesk@csc.fi>.

When a user logs into Taito, the *bash* start-up script defines a set of
CSC specific variables defining the location of the user specific
directories: *$WRKDIR, $HOME, $TMPDIR* and *$USERAPPL*. Further, *rm*,
*cp* and *mv* commands are aliased so that by default they ask for
permission before removing or overwriting and existing files. Also the
*clobber options* are set up so that output forwarding does not
overwrite an existing file.

If you wish to add more settings or aliases that are automatically
set-up when you log in, you should add the corresponding linux commands
to the end of the *bash* set-up file .*bashrc* that is located in your
home directory.

The Taito system supports UTF-8 character encoding, which makes it
possible to represent every character in the Unicode character set.
UTF-8 was not supported on older CSC systems, so care should be taken
when sharing files with other systems.

Compiling programs should be done in the *$TMPDIR*, which is login node
specific instead of *$WRKDIR* or *$HOME* which reside on Lustre file
system. Using *$TMPDIR* is much faster for compilation purposes than
Lustre and avoids performance degradation for computing jobs.

 

 

 
