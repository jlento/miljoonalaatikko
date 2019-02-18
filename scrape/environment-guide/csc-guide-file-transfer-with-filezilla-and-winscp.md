# 5.3 Graphical file transfer tools {#graphical-file-transfer-tools .western}

There  are plenty  of graphical  file  transport tools,  that you  can
install to  your loacal computer  to tarnsfer data between  your local
computer and CSC. Here we  shorty introduce two of them: **FileZilla**
that  is availvailable  for Windows,  Mac  OSX and  Linux macines  and
**WinSCP** that is available for windows.

## [][1]5.3.1 FileZilla - general file transfer tool

FileZilla is a  file transfer tool that you can  install to all common
operating  systems  (Windows,  Mac   OSX,  Linux).  You  can  download
FileZilla client from the FileZilla home page (server is not needed):

-   [FileZilla home]

When you start *FileZilla,* a  graphical file transfer interface opens
to your  screen. To open  a connection  to CSC, define  the connection
information  to  the *Quickconnect*  row  on  the  upper part  of  the
interface.  Alternatively you  can use  the *Site  Manager* button  to
define a connection.  You can re-use the connection  settings you have
made with *Site Manager* by right-clicking the *Site Manager* button. 

You can use following settings for connecting CSC:

-   Host (sisu.csc.fi, taito.csc.fi or taito-shell.csc.fi)
-   User / Username ( your CSC username)
-   Password (your CSC password)
-   Port (use value: 22)
-   Protocol: SFTP - SSH File Transfer Protocol
-   Logon type: Ask for password

Once the connection is opened,  *FileZilla* shows two interactive file
listings  side by  side. On  the left  side you  have your  local file
system and in right site the remote file system (e.g. files in Sisu or
Taito).  You  can change your  location by interactive browsing  or by
typing a directory path to the *local site* or *remote site* field.

Once you have the right directories  open in both local and the remote
site, you  can copy files or  directories between the sites  simply by
selecting a  file or folder  with mouse and  dragging it to  the other
site.  For other operations, try right-clicking a file or a folder.

![][2]  
Figure 5.6. FileZilla interface.

## [][3]5.3.2 File transfer in Windows with WinSCP

WinSCP is a free open source program for Windows. It provides a secure
file transfer  between a  local and  remote computer.  WinSCP supports
SFTP, FTP  and SCP transfer  protocols. WinSCP has many  features that
make operation with files simple. The installation document for WinSCP
is available at the site:

<http://winscp.net/eng/docs/installation>

There  are two  graphical user  interfaces in  WinSCP: *Explorer*  and
*Commander*. You select your default interface during the installation
of  WinSCP,  but  you  can   change  it  later  in  preferences  <span
lang="en-US">dialogue.</span> The  Explorer interface looks  and works
similarly  as  Windows Explorer.  If  you  are familiar  with  Windows
Explorer,  you   probably  had  better  start   with  WinSCP  Explorer
interface.

Start   WinSCP   and  enter   your   login   information  like   <span
lang="en-US">host  name</span>, username,  password  and the  server's
protocol.  In the  Explorer  interface  you can  drag  and drop  files
between WinSCP and  Windows Explorer to transfer them. In  order to do
other operations, right-click  any object in the  interface and select
the operation from the pop-up menu. It is also possible to right-click
a file or a directory, and drag it to another location.

There are many basic operations that you can do with WinSCP:

-   Navigating
-   Uploading files
-   Downloading files
-   Managing connections
-   Editing/opening files
-   Synchronizing local directory with remote one and vice versa
-      Changing    properties     (permissions,    ownership,    <span
    lang="en-US">etc.</span>) of remote files
-   Renaming files
-   Deleting files
-   Moving and duplicating remote files
-   Creating new object
-   Creating files
-   Creating directories
-   Creating links and short-cuts

### 5.3.2.1 Uploading files to CSC environment {#uploading-files-to-csc-environment .western}

Use can use different methods of WinSCP to upload files to CSC working
environment. The easiest methods are drag and drop with a mouse, using
copy and paste and using Windows Explorer's "*Send To*".

When using drag  and drop, select your local files  you want to upload
e.g. inside Windows Explorer. Then  drag selected files with mouse and
drop them to the remote panel of WinSCP interface.

When using copy and paste, select  your local files you want to upload
e.g. inside Windows Explorer and copy  them to clipboard. Then move to
WinSCP  interface and  select *File\|Paste*  from menu  (or *Ctrl+V*).
However,  if  your  clipboard  content  is  plain  text  string  only,
*File\|Paste* operation works  differently. In that case  it opens the
path stored in clipboard instead of pasting files.

You can use the Windows Explorer's "*Send To*" feature to upload files
to server.  To set this  feature on, use  the installer or  select the
feature   in  preferences   ("add   upload  <span   lang="en-US">short
cut</span> to Explorer's 'sent to' context menu").

![][4]  
**Figure 5.7**. Login window of WinSCP program  
 

### 5.3.2.2 Downloading files from CSC environment {#downloading-files-from-csc-environment .western}

The easiest  methods for downloading  files are  drag and drop  with a
mouse and using URL addresses. When using drag and drop, select remote
files  you   want  to   download  in  the   remote  panel   of  WinSCP
interface. Then  drag selected files with  mouse and drop them  to the
local directory <span
lang="en-US">e.g.</span> into Windows Explorer.  
 

You can register WinSCP to handle SFTP and SCP protocol URL addresses.
To register this  feature, use the installer or select  the feature in
preferences ("Register to handle  sftp:// and scp:// addresses"). Then
you can type URL in your web browser and WinSCP allows you to download
the file.

![][5]

**Figure 5.8.** WinSCP session

### 5.3.2.3 Further documentation {#further-documentation .western}

The extensive WinSCP documentation is available at:

<http://winscp.net/eng/docs/start>

 

 

  [1]: https://research.csc.fi/ {#5.3.1}
  [FileZilla home]: https://filezilla-project.org/
  [2]: https://research.csc.fi/documents/48467/84606/filezilla.jpg/529cbdbe-53ef-4b3f-a81f-2201ce3b9ba7?t=1457507487231
  [3]: https://research.csc.fi/ {#5.3.2}
  [4]: https://research.csc.fi/documents/48467/84606/Winscp1.jpg/d0e014e6-760c-4f34-b991-7ab5faca9c94?t=1383829218000
  [5]: https://research.csc.fi/documents/48467/84606/Winscp2.jpg/21b1cc12-c0a6-44a1-a176-a0719548273d?t=1383828740000
