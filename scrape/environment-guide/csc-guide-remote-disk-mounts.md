# 5.7 Remote disk mounts

With remote disk mounts you can use your CSC directories in a way that
resembles the  usage of an  external disk  or USB memory  stick. Using
this approach normally requires installing some extra software to your
local computer, but it also makes  the usage very fluent as no **scp**
or other data transfer programs are needed to move files between local
computer and CSC.

On Mac  OSX and linux  machines, [][1]**sshfs** can  be used  to mount
some disk areas at CSC to users own machine. With this tool the remote
disk  areas  at  the servers  of  CSC  can  be  used just  like  local
directories. To be able to  use *sshfs* you local *Linux* machine must
have   *FUSE*   (   <http://fuse.sourceforge.net/>)  and   *sshfs*   (
<https://github.com/libfuse/sshfs>) installed. In the case of *MacOS*X
the     required     packages     are    *OSXFUSE*     and     *SSHFS*
(<https://osxfuse.github.io>)

For Windows machines similar functionality  is provided with the Dokan
software (<https://dokan-dev.github.io/>).

**Using sshfs in Linux**

Once *sshfs* is installed in your  Linux machine you can create remote
disk mount with command syntax:

    sshfs username@hostname: mountpoint

For example, to make you home  directory of user *kkaytta*j visible to
a local Linux computer, execute command:

    mkdir csc_home
    sshfs kkayttaj@taito.csc.fi: ./csc_home

 

The first command creates an empty  directory that will be used as the
mount  point  in  the  second   command.  When  the  remote  mount  is
established, you can use the directory  as any directory in your Linux
system. For example,  to see the content of the  CSC home directory of
*kkayttaj*, you could now give a command:

    ls csc_home

By default,  the remote  directory to  be mounted  is the  users *home
directory*.  You  can  mount  other  directories  too  by  adding  the
directory  path after  the **:**  character. Following  commands would
mount the  $WRKDIR directory user  *kkayttaj* in Taito to  a directory
*taito\_wrk* on the local machine:

    mkdir taito_wrk
    sshfs kkayttaj@taito.csc.fi:/wrk/kkayttaj ./taito_wrk

Note that  the remote directory  to be mounted,  must be owned  by the
user.  Further,  the response times  of the remote directories  are of
cause often much longer than in the case of real local directories.

To ***unmount***; the file system, give a command:

    fusermount -u mountpoint

For example the remote mounts, created in the examples above, would be
removed with commands:

    fusermount -u csc_home
    fusermount -u taito_wrk

 

*** ***

*** ***

*** ***

  [1]: https://research.csc.fi/ {#sshfs}
