# 5.1 Data transport with Scientist's User Interface {#data-transport-with-scientists-user-interface .western}

*Scientist's User Interface* (SUI) is a CSC's extranet service that can
be used for running applications and managing files in the servers of
CSC. The direct address of Scientist's Interface is:

-   [https://sui.csc.fi].

You can log in to the *Scientist's User Interface* either by using you
CSC user account and password or by using *Haka* authentication. If you
use the Haka authentication, you must first pick your home organization.
After this you can log in by using the user account and password of you
own organization ( typically Haka uses the windows user name and
password of your home institute). Note that even though you would use
Haka authentication with your university user name and password, you
still need to register as a CSC customer before you can use *My Files*
tool ( see [chapter 1.2] for registration). Once you have successfully
logged in, you can find the tools and functions of Scientist's User
Interface from the **Services** menu in the top of the screen.  
 

## [][1]5.1.1 Managing files with My Files tool {#managing-files-with-my-files-tool .western}

The file management tools are started by selecting "**My** **Files**"
from the service list. This selection opens the file management
interface, that provides an easy way to transport data between CSC and
your local computer. You can also use it to view, edit, compress and
remove your files at CSC or submit batch jobs. Note that some browsers
have limitations with file sizes and may not be able to upload larger (
more than few gigabytes) files.

  
The figure 5.1 shows the structure of the file manager. On the My Places
field on left side you can see the servers and directories that you can
use with the interface. The directory names in the list ($HOME, $WRKDIR)
refer to the user directory structure of CSC, explained in [chapter 3].
Note that some of servers share directories. For example the $HOME and
$WRKDIR directories of Taito and Sisu refer to the same directory.

**![][2]  
Figure 5.1:** My Files in Scientist's User Interface.

  
You can open a directory by double-clicking it. The contents of the
directory is shown in the field on the right side. By default the
directories are listed alphabetically but you can change ordering
criteria by clicking the column names. The files and directories are
selected by clicking the corresponding row in the file list.

  
A context menu containing actions opens, when you click the file list
with *right mouse button*. If no no files or directories are selected in
the file list, the context menu (figure 5.2.) includes **Upload**
command that you can use to move files from your local computer to CSC.

**![][3]**  
**Figure 5.2:** Context menu of My Files when no files are selected.  
  
If you first select a file from the file list, and then press the right
mouse button then a different context menu, shown in figure 5.3. From
this menu you can choose **Download** command to copy the file to your
local computer.  
**![][4]**  
**Figure 5.3:** Context menu of My Files when a file is selected.

Note that the list of operations in the context menu vary depending on
the file type and access permissions. The **Open** operation sends the
content of the file to your browser. This operation is useful when you
wish to study e.g. text, image, html and pdf files**. Edit** operation
opens a text file in a simple editor screen. The **Pack** operation
compresses your file or directory using the [Zip] compression tool. The
**Properties** command opens a window that you can use to check the
basic properties of the file and to modify the [access permissions] of a
file.

## [][5]5.1.2 Transporting files using the SSH Console tool {#transporting-files-using-the-ssh-console-tool .western}

In addition to *MyFiles* Scientist's User Interface provides you
another, a bit more complicated tool, that you can use for data
transport. That is: using *GSI SSH console* and *SFTP session*.

To use this file transport method, Launch the SSH Console by clicking
the icon in the Services Desktop or by selecting the tool from the
Services Menu. When the console is launched, it asks for your user
account and the name of the server you want to connect. The password
will be asked only later on. If you would like to copy data to Taito,
you should define:

Username: *csc\_username*

Remote Host: **taito.csc.fi**

And then launch the SSH console.

When the Java based console program starts you may need to accept
launching the process in you local machine and allow the process connect
CSC. When the console is running it will ask you to choose the
authentication method to be used. Select: **password** and press
**Proceed**.

![][6]  
**Figure 5.4:** Selecting authentication for SSH Console.

After this a Password Authentication window opens. Type in you password
and press OK.  
![][7]  
**Figure 5.5:** Password authentication for SSH Console.

You can use the console to use the CSC servers, but it contains also
other tools than just the command line client. You can use it for
example for file transport or secure tunneling of server ports. In the
case of file transport you can utilize the SFTP file transport tool. Go
to the "Tools" menu of the client window and select:

**Tools \| SFTP session**

![][8]  
**Figure 5.6:** The tools menu of the SSH console

This launches a file transport terminal to your screen. By default the
file transport terminal shows the content of your CSC home directory. To
move data to some other location, for example $WRKDIR directory at CSC,
change the directory path in the *Address* filed. Note that you must use
the real path of your directory in stead of the environment variable. (
For example: */wrk/username* in stead of $WRKDIR ). To upload your file,
go to the *File* menu and select

**File \| Upload Files**

Select the file to be uploaded using the file selection window that
opens to your screen and start the upload process. Downloading files is
done in the same fashion.

![][9]  
**Figure 5.7:** File transport tool of GSI-SSH console

 

  [https://sui.csc.fi]: https://sui.csc.fi/
  [chapter 1.2]: https://research.csc.fi/csc-guide-getting-access-to-cscs-resources
  [1]: https://research.csc.fi/ {#5.1.1}
  [chapter 3]: https://research.csc.fi/csc-guide-directories-and-data-storage-at-csc
  [2]: https://research.csc.fi/documents/48467/84606/sui-myfiles-2014.jpg/6fbe2872-38c1-42e0-9b79-6d1e603d84fa?t=1414588641333
  [3]: https://research.csc.fi/documents/48467/84606/SUI_my_files_2.jpg/1b0ccad1-6050-4bc2-8f94-80516bc00e67?t=1383905265000
  [4]: https://research.csc.fi/documents/48467/84606/SUI_my_files_3.jpg/62875dd8-e168-4a4a-b257-63ae84862881?t=1383836446000
  [Zip]: https://research.csc.fi/csc-guide-packing-and-compression-tools
  [access permissions]: https://research.csc.fi/csc-guide-more-commands-for-managing-files#2.4.8
  [5]: https://research.csc.fi/ {#5.1.2}
  [6]: https://research.csc.fi/documents/48467/84606/SUI-select_authentication.jpg/1cace15c-f6ef-46d0-820b-02cb37b97354?t=1383898208267
  [7]: https://research.csc.fi/documents/48467/84606/SUI_authentication.jpg/5d6ba82a-c937-41fd-9309-5eb85c24b055?t=1383898270284
  [8]: https://research.csc.fi/documents/48467/84606/SUI_console.jpg/92fab02e-9002-47e4-9867-1ea42eb2eb2a?t=1383898346959
  [9]: https://research.csc.fi/documents/48467/84606/SUI-SFTP-term.jpg/3d9ec0b5-5894-4970-b173-0d8de2a68a9a?t=1383898425240
