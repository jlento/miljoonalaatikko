# 5.4 Using rsync for data transfer and <span lang="en-US">synchronization</span> {#using-rsync-for-data-transfer-and-synchronization .western align="JUSTIFY" style="page-break-before: always;"}

**Rsync** is  a data  transport tool  that can be  used much  like the
*scp* command. However, [][1]*rsync* has several features that make it
more versatile  and in many  cases more effective data  transport tool
that *scp*.  *Rsync* is a  command line  program that is  available in
most  Linux and  MacOSX  machines.  In Windows  machines  you can  use
*rsync* through the *cygwin* system.

The special feature in *rsync* is that can transport the data from one
site to  another in  small pieces. During  this process  *rsync* first
compares the  pieces, using checksums,  to possibly existing  files in
the target site,  and transports only those pieces that  are not found
from  the target  site. In  practice this  means that  if an  older or
partial version  of a file to  be copied already exists  in the target
site, *rsync* transports  only the missing parts of the  file. In many
cases this makes the data update  process much faster as all the files
are not copied each time the source and target site are synchronized.

This  feature makes  *rsync* very  suitable for  maintaining identical
copies of  a directory in two  places (for example between  your local
computer and  a server  at CSC). Another  situation, where  *rsync* is
frequently used is copying large files  to and from CSC. Rsync command
can be set so that if the data transport process is interrupted, a new
*rsync* based data  transport process does not need to  start the data
transport from the very beginning but  it can continue building up the
partially transported file.

The Basic command syntax of *rsync* is:

    rsync -options source target

 

If the data source or target location  is a remote site, it is defined
with syntax:

    userame@server:/path/in/server

 

However, both  the target and  source can  locate in the  same machine
too.  In  that case you  can just give  directory paths to  source and
target sites.

The table below lists the most commonly used *rsync* options:

  
**Table 5.1:** Rsync options

<table> <colgroup> <col style="width:  15%" /> <col style="width: 15%"
/> <col style="width: 70%"  /> </colgroup> <thead> <tr class="header">
<th>Option  </th>  <th>Argument     </th>  <th>Description</th>  </tr>
</thead>   <tbody>   <tr   class="odd">   <td><strong>-a</strong></td>
<td> </td>   <td>Use  archive   mode:  copy   files  and   directories
recursively  and preserve  access  permissions  and time  stamps.</td>
</tr>   <tr   class="even">  <td><strong>-v</strong></td>   <td> </td>
<td>Verbose       mode.</td>        </tr>       <tr       class="odd">
<td><strong>-z</strong></td>  <td> </td> <td>Compress.</td>  </tr> <tr
class="even">  <td><strong>-e</strong></td>  <td>ssh</td>  <td>Specify
the    remote   shell    to   use.</td>    </tr>   <tr    class="odd">
<td><strong>-n</strong></td> <td> </td>  <td>Show what files  would be
transferred.</td>           </tr>          <tr           class="even">
<td><strong>--partial</strong></td>   <td> </td>  <td>Keep   partially
transferred       files.</td>       </tr>       <tr       class="odd">
<td><strong>--progress</strong></td>   <td> </td>  <td>Show   progress
during       transfer.</td>        </tr>       <tr       class="even">
<td><strong>-P</strong></td>   <td> </td>    <td>same   as   --partial
--progress</td> </tr> </tbody> </table>

  
 

### [][2]Rsync example 1. copying a directory structure from local computer to CSC {#rsync-example-1.-copying-a-directory-structure-from-local-computer-to-csc style="margin-bottom: 0in;"}

Lets assume that  user *kkayttaj* has in his/her local  linux or Mac a
directory *my\_data* that  contains files *sample1.txt*, *sample2.txt*
and *sample3.txt*. User *kkayttaj* could use following *rsync* command
to copy the directory to the $WRKDIR of taito.csc.fi server.

    rsync -avz -e ssh my_data kkayttaj@taito.csc.fi:/wrk/kkayttaj

 

An identical command would be:

    rsync -avz -e ssh my_data kkayttaj@taito.csc.fi:'$WRKDIR'

 

Here the *data  source* is the *my\_data* directory  in local computer
and the  *target* location is  $WRKDIR directory in  taito.csc.fi. The
option **-a** means *archive mode*.  With this selection *rsync* works
*recursively* which means that all  the files and sub-folders from the
source  folder *my\_data*  are copied  to Taito.  The time  stamps and
access permission  of the  copied files will  be preserved.  The **v**
option means verbose mode, where *rsync* prints out information during
the  transport process.  The **z**  option  defines that  the data  is
transported in a compressed format. The option **-e ssh** defines that
*ssh* is used to encrypt the data during the transport.

Once the  command is executed it  asks for the password  for Taito and
then starts copying the files.

If the user now modifies file *sample2.txt* and runs again the *rsync*
command   above,  only   the  *sample2.txt*   file  gets   updated  at
Taito. **This automatic update process  is effective but it includes a
very potential danger for  accidentally over writing important data!**
*Rsync*  does  not compare  the  time  stamps  of  the files  it  will
modify. Thus,  if the target site  contains a newer version  of a file
than the source site  or if the file in the  source site is corrupted,
then the  file in  the target site  will be replaced  by the  older or
corrupted version when *rsync* command is executed.

You can test, which files would  be affected by the *rsync* command by
using option  **-n**. With this  option *rsync* just lists  the target
files that differ from  the files in the source site,  but it does not
modify the files in the target site.

    rsync -n my_data kkayttaj@taito.csc.fi:'$WRKDIR'

 

### [][3]Rsync example 2. Synchronizing directories within a one server {#rsync-example-2.-synchronizing-directories-within-a-one-server style="margin-bottom: 0in;"}

*Rsync* can  be used  to synchronize  two locations  in the  same file
system. For example say you have  a directory called *results* in both
$WRKDIR and  $HOME. In  the beginning both  directories have  the same
content,  but later  on new  and  modified files  appear to  *results*
directory in  $WRKDIR. If you  now want to  update the changes  to the
result directory in $HOME too, you can give command:

    rsync -avz $WRKDIR/results $HOME/results

Alternative way  would be to  remove the old *results*  directory from
the $HOME and then copy the newer directory to $HOME with commands:

    rm -rf $HOME/results
    cp -r $WRKDIR/results $HOME/

 

However,  that would  require copying  all the  files from  $WRKDIR to
$METAWRK and thus this process would  take much longer than the update
done by rsync

### [][4]Rsync example 3. Copying a large file from remote site to CSC {#rsync-example-3.-copying-a-large-file-from-remote-site-to-csc style="margin-bottom: 0in;"}

Copying files  larger than 100 GB  over the net can  be problematic as
often the network connection fails  before a copying process, that can
take hours,  is finished. In  these situations *rsync* is  a potential
tool as with  suitable options, an interrupted copying  process can be
later on continued with another *rsync* command.

Now let's assume  that user *kkayttaj* wants to copy  to Taito a large
file  called *nz\_project.tar.gz*  from  a  directory: */project1*  at
server *hpclogin1.canterbury.ac.nz*.  As the file locates  in a server
in New Zealand we anticipate that the copying process will take time.

The copying process can be started at Taito with command:

    rsync -P kkayttaj@hpclogin1.canterbury.ac.nz:/project1/nz_project.tar.gz  $WRKDIR

 

When the command is executed it  first asks for the users password for
hpclogin1.canterbury.ac.nz.  Note  that  in this  example  compression
(**-z**)  is not  used as  the file  to be  transported is  already in
compressed format.

In this case option **-P**, which equals to using options *--progress*
and *--partial*.  With the ***--progress*** option,  *rsync* shows how
much of  the data  is already  transferred and  what is  the transport
speed.  The  ***--partial*** selection keeps the  partially downloaded
files in the  target site. This option is useful  if the data transfer
process gets interrupted by some error or malfunction.

For example, if  the *rsync* command above would  terminate before all
the data is transported we could launch the same command again:

    rsync -P  kkayttaj@hpclogin1.canterbury.ac.nz:/project1/nz_project.tar.gz  $WRKDIR

 

Now *rsync* would use partial check  sums to test the validity of that
part of the file that was already transported previously and start the
actual   data  transport   only   for  the   missing   parts  of   the
*nz\_project.tar.gz* file.

 

  [1]: https://research.csc.fi/ {#rsync}
  [2]: https://research.csc.fi/ {#ex1}
  [3]: https://research.csc.fi/ {#ex2}
  [4]: https://research.csc.fi/ {#ex3}
