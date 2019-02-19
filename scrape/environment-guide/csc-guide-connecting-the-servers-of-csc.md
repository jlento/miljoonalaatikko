# 1.3 Connecting to the servers of CSC {#connecting-to-the-servers-of-csc .western align="JUSTIFY" style="page-break-before: always;"}

You can connect the servers of CSC either by using the web based
*Scientist's User Interface* extranet service or through linux terminal
connections. While the Scientist's User Interface provides an easy and
intuitive way to connect to CSC, it allows you to use only a very
limited set tools for working with your data. Terminal connections and
<span lang="en-US">Linux</span> command line usage still provides the
most versatile and efficient tools to manage and <span
lang="en-US">analyze</span> data in the servers of CSC. If you want to
work with graphical user interfaces we recommend using the *NoMachine
remote desktop*, which is described below.

## [][1]1.3.1 Scientist's User Interface {#scientists-user-interface .western align="JUSTIFY"}

Scientist's User Interface is an extranet service that allows the
customers of CSC to access the CSC computing environment through a
normal web browser.  The URL of the Scientist's User Interface (SUI) is
[https://sui.csc.fi] and it can be used for following tasks

-   monitoring and managing you user account at CSC
-   managing files in the servers of CSC
-   managing files in the IDA storage service
-   Launch SSH console sessions
-   Use **[Lemmie]** language bank corpora interface and **[DMA -Digital
    Morphology Archive]**
-   Use [**PaITuli**] Geospatial Data Service
-   Download software and data sets provided by CSC
-   Create and execute batch job scripts for the computing servers of
    CSC.
-   Manage and store grid certificates

You can use either your HAKA account (local university account) or CSC
user account to log into *Scientist's User Interface*. The *My Files*
file manager is discussed more in detail in chapter [5.1] of this guide.

![][2]

**Figure 1.2:** Scientist's User Interface extranet service.  
 

## [][3]1.3.2 Terminal connections {#terminal-connections .western align="JUSTIFY"}

A terminal connection to CSC should be opened using a secure terminal
program that encrypts the data traffic between the user and CSC. In
Linux and Mac OSX systems you can use [][4]**ssh** program to connect to
CSC. In Windows machines you can use for example the [PuTTY] open source
program to open the connection to CSC. If you don't want install a local
ssh terminal program, you can use the SSH console tool in Scientist's
User Interface (more details in chapter 5.1.2).  
  
For example to log into Taito, open a new terminal screen and give
command:

    ssh taito.csc.fi -l csc_username

If you wish to use also X11 based graphical tools give command:

    ssh taito.csc.fi -X -l csc_username

or in some cases, if the command above does not work, try:

    ssh taito.csc.fi -Y -l csc_username

When you stop working at the servers of CSC, you should first close the
connections to CSC with command:

    exit

In addition to the plain text based terminal connections you may need be
able to use also X-term connections. X-term connection can be used to
enable viewing image files or launching a graphical interface on the
servers of CSC. To be able to use X-term based tools your local computer
must have an X11 server (often called as X window server program)
installed and running. In linux machines X11 is normally installed and
running automatically. In Mac OSX machines the X11 software is not
installed by default, but it can be installed from the Mac OSX
installation disks. In Windows machines, an X server program must be
installed to the users local machine. In addition to several commercial
[][5]**xterm** programs there are also some free ones like [Xming], but
CSC recommends using the NoMachine remote desktop, see below.

Once your X server program is running, open a terminal connection to CSC
( remember to use the -X or -Y option or Tunnel X11 setting), and test
by running command:

    xterm &

This should open a new xterm connection to your screen.

![][6]

**Figure 1.3** Linux terminal window

## [][7]1.3.3 NoMachine Remote Desktop {#nomachine-remote-desktop .western}

*NoMachine Remote Desktop* provides an alternative way to use remotely
graphical interfaces at the servers of CSC. The service works with a
*NoMachine* client which is installed on the researcher's computer. No
X-term software is needed in the local computer.

We recommend <span lang="en-US">NoMachine</span> for remote usage of
graphical interfaces instead of X11 connections. It often speeds up the
graphical response even 10 fold with respect to the normal X11
connections. Further, the NoMachine client is often easier to install to
a Windows machine, than an X-emulator. The NoMachine remote desktop can
also be suspended, so that while you close your connection or reboot
your computer, you can continue from where you left off without the
connections from the NoMachine server to CSC servers being closed or the
running processes stopped.

![][8]

**Figure 1.4** The NoMachine server setup at CSC. The blue line means
the connection established from the NoMachine client installed on your
computer, which gives good performance even with slow connection. The
solid red line is an ssh connection from the NoMachine server to a CSC
compute server. Connections within a location are fast (within Kajaani).

When you open a connection to CSC, the NoMachine client first connects
to a NoMachine server **nxkajaani.csc.fi**, which is located in Kajaani.
After the login, a remote desktop opens to your screen. From this remote
desktop you need to further connect to the actual computing servers (by
right clicking the desktop) and then start the applications with normal
terminal commands. You can also start some applications directly from
the right-click menu.

To start *e.g.* Mercury in Taito (taito-shell), right click with the
mouse in the Desktop area, choose taito-shell from the pull down menu,
add your password, and you are logged in Taito. Then go to your working
directory with *cd $WRKDIR*, initialize the CSD package with *module
load ccdc* and then start the GUI with *mercury*.

To exit from NX close the Desktop. Point the top right corner with your
mouse to access the peel menu and left-click. Click the small "power"
button at the right lower corner of the options. Then choose terminate.
If you want to close the connection to the remote desktop, but want to
leave the connections from the desktop to the servers alive, choose
*'Disconnect'* or *'Suspend'*.

![][9]  
**Figure 1.5** Matlab opened in the NoMachine remote desktop.

### [][10]1.3.3.1 Installation of NoMachine client version 6 (recommended)

First download the NoMachine Enterprise **client (***not* the Desktop,
which is first on the list) for your operating system from here:

<https://www.nomachine.com/download-enterprise>

![][11]

Installing the client requires admin privileges. For Windows start the
installer, accept the agreement and default installation location. For
Linux see the instructions on the download page and continue here for
the configuration.

You may need to grant some nx\* applications to access to the internet
for your anti-virus/firewall software.

Open NoMachine Enterprise Client. (In windows from Start menu). If this
is the first time you open the Client, your screen will look a bit
different. If it does, choose the "Create a new connection" icon.

![][12]

... or click "new" at the top menu.

![][13]

Choose NX as the protocol and click continue.

![][14]

Fill in "nxkajaani.csc.fi" as the Host. The default port is ok. Click
continue.

![][15]

Choose "Password" and click continue.

![][16]

In most cases you don't want the proxy. If the connection fails, consult
your IT-support in case you need to connect via proxy.

![][17]

Give your configuration some name. If you want a Desktop shortcut, click
that too. Click done.

![][18]

Double click the new connection icon (or the shortcut on your Desktop).

![][19]

Give your CSC username and CSC password (which you use to log in e.g.
Taito) and click OK. If this is the first time you connect to
*nxkajaani.csc.fi* you will be asked if you trust the server identity.
Click *yes*.

Now there are few options. If you didn't have a session open, you'll be
taken to remote desktop, which is blank. Right click to proceed.
Alterntively, you (may) now see a number of other connections on the
NX-server. If you have a previous session open (suspended) on nxkajaani,
search for it in the search box at the top with your username and double
click it. If you don't have a session to choose, create a new one by
choosing the "new Desktop" and then choose "Create new GNOME desktop".

The first time you connect to nxkajaani, you'll be introduced to the
icons and menus of the NxClient. Take a moment to learn them and click
"Don't show again" to speed up getting access next time.

### [][20]1.3.3.2 Known issues with NoMachine connection

The version 6 does not support the "No Machine Login" that was
previously used. Please change the connection settings as above.

In **Windows7**, if you have problems in the installation, try disabling
"direct draw" from the advanced settings.

If you get an **error in logging** into nxkajaani, that is likely due to
corrupted ssh-key (extra line breaks or spaces). Redo the ssh-key
determination step above, but use the key from the plain text file
available in SUI. See below for keyboard layout, to fix logging in from
nxkajaani to Sisu/Taito.

If **copy/paste** does not work with the middle mouse button, try
ctrl-alt-c / ctrl-alt-v.

If right-click does not bring up the server/application menu on the
remote desktop, you can try to exit from the session and create a new
desktop (in the last screen capture shown above) instead of reconnecting
to the old desktop.

If Mathematica stalls after the "splash" screen, kill your terminal and
start Mathematica again with "--nosplash" on the command line.

If your keyboard becomes unresponsive after using the AltGr key in the
NXClient version 4, disable the "alt + ctrl + 0" special meaning from
the configuration menu (section input -&gt; uncheck the "alt + ctrl +
0". More details on [this page].

The **key mappings** for Macs are not perfect. If you don't get a dollar
sign "$" with alt-4 in the x-terminal, try using the *right side* alt
key. That has worked on all Macs we have tested…

The default **keyboard layout** may be wrong, and may change between
logins. See [FAQ]. You can change that by right clicking in the
background, Choose "fluxbox menu" -&gt; "keyboard layout" and your
keyboard. If yours is not listed, contact <servicedesk@csc.fi>. This
affects connections from nxkajaani to compute servers. Don't try too
many times because that will cause your username/IP to be banned.

If you get **garbled fonts** in some (old) applications, it could be due
to the old binary not being able to utilize server side fonts, but needs
those fonts installed on the client side. This has happened at least
with the old emacs version in vuori. To fix this, install additional
fonts to the client. The instructions and fonts can be found in here:
<http://www.nomachine.com/download-package.php?Prod_Id=3565>

**Small screen size** by default the remote desktop screen is quite
small. If you want to have a full screen desktop, you may need to change
settings in two steps. First open the peel menu (top right corner),
choose display, and activate either "full screen" or "resize remote
display". Click "done", open the peel menu and choose display again, and
select the other option. You may need additional steps, but the options
you need are in this menu.

**Terminal window handle bar outside desktop**. If you open the
NoMachine remote connection on a smaller screen than you used last time,
some terminal window handle bars (that you can use to drag them) may be
outside the screen. You can drag the window my pressing "alt" on your
keyboard and dragging with left mouse button directly from the terminal
window. Mouse pointer turns to a "hand" symbol when the terminal can be
dragged.

**Frozen session** Sometimes your remote desktop session may "freeze"
e.g. due to insufficient memory on the gateway machine. It may then
happen, that when you try to make a new session, the client will default
to the old frozen session. You may try the following workaround. In the
opening dialog click "configure" and change the desktop from e.g. gnome
to KDE. Save, and connect. You should now get an option to kill the old
session and start a new one. Instead of the KDE desktop you'll get the
same fluxbox that is started with the gnome –choice.

**Ubuntu 12.10 and 14.10** versions have problems with the Desktop
system (Unity). Work is in progress but in the mean time you can try
these workarounds: <https://www.nomachine.com/AR07K00676> and
<https://www.nomachine.com/AR0500591>

**Connection to nxkajaani fails** after some tens of seconds with a
message "Oops, The connection with the server was lost.  Error is 108:
Connection reset by peer." Try deleting the cache on your local client
machine: <https://www.nomachine.com/TR12K04112>

 

 

  [1]: https://research.csc.fi/ {#1.3.1}
  [https://sui.csc.fi]: https://sui.csc.fi/
  [Lemmie]: https://sui.csc.fi/group/sui/lemmie
  [DMA -Digital Morphology Archive]: https://sui.csc.fi/group/sui/dma
  [**PaITuli**]: https://sui.csc.fi/group/sui/paituli
  [5.1]: https://research.csc.fi/csc-guide-data-transport-with-scientist-s-user-interface
  [2]: https://research.csc.fi/documents/48467/84606/sui-home-2014_b.jpg/591ca2b5-fb60-427b-94e3-a53c83756535?t=1414588150346
  [3]: https://research.csc.fi/ {#1.3.2}
  [4]: https://research.csc.fi/ {#ssh}
  [PuTTY]: http://www.chiark.greenend.org.uk/%7Esgtatham/putty/
  [5]: https://research.csc.fi/ {#xterm}
  [Xming]: http://sourceforge.net/projects/xming/
  [6]: https://research.csc.fi/documents/48467/84606/Terminal.jpg/dbd7f654-c83c-4f79-92b7-d13a17e58ba3?t=1383828956000
  [7]: https://research.csc.fi/ {#1.3.3}
  [8]: https://research.csc.fi/documents/48467/51198/freenx-sketch.png/7a680da1-ef7a-4c00-9d60-a3fa673b1448?t=1379577395000
  [9]: https://research.csc.fi/documents/48467/84606/freenx.jpeg/ba3780c4-e683-4957-b340-1f55fd023713?t=1383891758308
  [10]: https://research.csc.fi/ {#1.3.3.1}
  [11]: https://research.csc.fi/documents/48467/51198/nx4-1.png/19c5f844-e4fe-4c9c-8f1f-e09c4213f928?t=1413541340357
  [12]: https://research.csc.fi/documents/48467/51198/nx4-2.png/6c17986f-8db2-4e63-ba45-1451c51ac243?t=1413542077416
  [13]:  {width="688" height="304"}
  [14]:  {width="684" height="306"}
  [15]:  {width="680" height="395"}
  [16]:  {width="671" height="317"}
  [17]:  {width="664" height="262"}
  [18]:  {width="659" height="193"}
  [19]: https://research.csc.fi/documents/48467/51198/nx4-10.png/4c953d81-24e9-42af-924e-ab14d2784c9d?t=1413542148159
  [20]: https://research.csc.fi/ {#1.3.3.2}
  [this page]: http://www-flc.desy.de/flc/flcwiki/J%C3%B6rgenSamson/NXClientUsermode#Known_Problems_and_Issues
  [FAQ]: https://research.csc.fi/-/i-can-login-to-nxkajaani-but-i-can-t-login-to-sisu-taito-from-there-
