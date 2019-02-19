# 5.5 Using wget to download data from web sites to CSC {#using-wget-to-download-data-from-web-sites-to-csc .western}

**Wget** is a handy command for downloading files from the WWW-sites and
FTP servers. Once you have resolved the URL of the file, just give it as
an argument for [][1]*wget* command to download the file to your current
working directory.

`wget ftp://path/to/the/file`

 

For example you could download the nucleotide sequence of human
chromosome Y from the ftp-site of UCSC
(<ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/>) with
command:

    wget ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chrY.fa.gz

 

The command above would produce a file called *chrY.fa.gz* to your
working directory at CSC ( a [gzip compressed] fasta file). You can also
retrieve a group of files by using asterisk (\*) sign. For example all
human chromosome files could be downloaded with command:

    wget "ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr*.fa.gz"

 

Note that quotation marks around the file name are obligatory when
asterisk (or any other special character) is used . This command would
retrieve all the files, whose name start with *chr* and end with
*.fa.gz.* i.e. the sequence files for all chromosomes.

You can fine tune the behaviour of *wget* command with several options.
You can see the full list of available command options with command:

    man wget

 

Below is listed some of the most commonly used *wget* options.

**Table 5.2** Wget command options

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 60%" />
</colgroup>
<thead>
<tr class="header">
<th>Option</th>
<th>Argument  </th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>-i</td>
<td>URL</td>
<td>Read a file containing the URL:s to retrieve.</td>
</tr>
<tr class="even">
<td>-O</td>
<td>file name</td>
<td>Name of the output file.</td>
</tr>
<tr class="odd">
<td>-o</td>
<td>file name</td>
<td>Name of the download log file.</td>
</tr>
<tr class="even">
<td>-p</td>
<td>directory</td>
<td>Defines the directory where the downloaded data will be saved to. The default is . (the current directory).</td>
</tr>
<tr class="odd">
<td>-c</td>
<td> </td>
<td>Continue getting a partially-downloaded file.</td>
</tr>
<tr class="even">
<td>--user=</td>
<td>username</td>
<td>Specify the user name for file retrieval</td>
</tr>
<tr class="odd">
<td>--password=</td>
<td>password</td>
<td>Specify the password for file retrieval.</td>
</tr>
<tr class="even">
<td>-N</td>
<td> </td>
<td>Use time-stamping. Download the file only if it is newer that the file in the target directory.</td>
</tr>
<tr class="odd">
<td>-m</td>
<td> </td>
<td>Turn on options suitable for mirroring. This option turns on recursion and time-stamping, sets infinite recursion depth and keeps FTP directory listings.</td>
</tr>
</tbody>
</table>

For example if you would like to retrieve just chromosomes 2,3,7, you
could first collect the addresses of the chromosome file to a single
text file:

    ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr2.fa.gz
    ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr3.fa.gz
    ftp://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr7.fa.gz

 

If the name of the file is *chr\_2.3.7.list* the chromosomes could now
be retrieved with command:

    wget -i chr_2.3.7.list

 

We could also modify the command a bit more. For example command:

    wget -i chr_2.3.7.list -P $WRKDIR -O chr_2.3.7.fa.gz

 

Would retrieve the same files, but instead for producing three separate
files, all the files would be concatenated to file *chr\_2.3.7.fa.gz*
that would be created to the work directory.

 

 

  [1]: https://research.csc.fi/ {#wget}
  [gzip compressed]: https://research.csc.fi/csc-guide-packing-and-compression-tools#2.6.2
