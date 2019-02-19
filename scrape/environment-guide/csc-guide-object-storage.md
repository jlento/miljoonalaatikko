# 3.3  Using Pouta Object Storage in CSC computing environment

Computing projects, that have access to cPouta cloud resources, can use
the Pouta Object Storage service provided by CSC. This data storage
service can be used to store and share up to 1 TB of datasets so that
the data can be accessed from anywhere: from a virtual machine in
cPouta, Sisu and Taito servers, your local computer or a third party web
server elsewhere. The service resembles HPC-archive and IDA in that
sense that you can only upload or download data to the service.
Modifying a dataset will require replacing the whole dataset with an
updated version.

This chapter describes how you can use the CSC Object Storage service
from the CSC computing environment. We focus here in configuring and
using *s3cmd* Object Stoirage client.  More detailed description of the
Object Storage service can be found for the [Pouta User Guide].

## [][1]3.3.1 Configuring s3cmd tool in Sisu and Taito

In Sisu and Taito you can access Pouta Object Śtorage using two command
line tools: **swift** and **s3cmd**. Both provide easy to use way to
access you Object Storage area. However in the case of **swift** you
allways need to have you CSC password stored in an environment variable
in human readable format  when you use the Object Storage service.

In the case of **[][2]s3cmd**, you need to give your CSC password only
once,  when you configure the connection. After this you will
automatically use separate Object Storage specific key pair for
authentication.

In Taito the *s3cmd* configuration process can be done by executing
commands:

    module load bioconda/3
    poutaos_configure

 

The *poutaos\_configure* command asks first your CSC password. Then it
lists your cPouta projects and asks you to define the name of the cPouta
project to be used. During the proceeding configuration steps, the
system asks  you about the values that will be used for the Pouta Object
Storage connection. In most cases you can just accept the proposed
default values, but there is two exceptions:

1.  It is recommended that you define a password that is used to encrypt
    the data traffic to and from Object Storage server. This password is
    not connected to any other passwords in the CSC environment so you
    can freely define it. Note however, that this password is stored to
    the s3cmd configuration file in human readable format so you should
    not use this password elsewhere. 
2.  As the last question the configuration process asks if the
    configuration is saved. The default is "*no*" but you should answer
    *y (yes)* so that configuration information is stored to file
    *$HOME/.s3cfg*.

This configuration needs to be defined only once. In the future *s3cmd*
will use this Object Storage connection described in the *.s3cfg* file
automatically. However, if you wish to change the Object Storage project
that *s3cmd* uses, you have to rerun the *poutaos\_configure* command.

###  

## [][3]3.2 Using Object Storage with s3cmd

The syntax of the s3cmd command is:

    s3cmd -options command parameters

Table 3.2 below lists the most essential s3cmd commands. For more
complete list, visit the  [s3cmd manual page] or execute command:

    s3cmd -h

**Table 3.2**. Most commonly used *s3cmd* commands

| **s3cmd command** | **Function**                                    |
|-------------------|-------------------------------------------------|
|  mb               |  Make a new bucket                              |
|  rb               |  Remove a bucket                                |
|  ls               |  List objects or bukets                         |
|  la               |  List all objects in all buckets                |
|  du               |  Show the disk usage of buckets                 |
|  put              |  Put file into a bucket                         |
|  get              |  Get file from a bucket                         |
|  setacl           |  Modify Access control list for Bucket or Files |

In Object Storage the files are stored as *object*s that locate in
*buckets*. The buckets resemble folders in normal file systems. There
are however big differences compared to folders. Firstly, the file
structure on Object Storage is flat: you can't create a bucket that is
inside a bucket. Secondly, all bucket names must be unique throughout
the Object Storage system. You can't use a bucket name that is already
used by you or some other Object Storage user.

In the example below we store a simple dataset to the Object Storage.

First we create a new bucket. The ***ls*** command shows that in the
beginning we don't have any data in the object storage. After that, we
use ***mb*** command to create a new bucket called "*fish-bucket*".

    [kkayttaj@c306:~]$ s3cmd ls
    ls

    [kkayttaj@c306:~]$ s3cmd mb s3://fish-bucket
    mb s3://fish-bucket/
    Bucket 's3://fish-bucket/' created
    [kkayttaj@c306:~]$ s3cmd ls
    ls
    2018-03-12 13:01  s3://fish-bucket

Just like in the case of HPC arvchive, it is recommended to collect the
data to be stored into larger units and compress the data before
uploading it to the system.

In this example we will store the Bowtie2 indexes and genome of the
Zebrafish (*Danio rerio*) to the *fish-bucket*. Running *ls -lh* shows
that we have the index files available in the current directory

    [kkayttaj@c306:~]$ ls -lh
    total 3.2G
    -rw------- 1 kkayttaj csc 440M Mar 12 13:41 Danio_rerio.1.bt2
    -rw------- 1 kkayttaj csc 327M Mar 12 13:41 Danio_rerio.2.bt2
    -rw------- 1 kkayttaj csc 217K Mar 12 13:20 Danio_rerio.3.bt2
    -rw------- 1 kkayttaj csc 327M Mar 12 13:20 Danio_rerio.4.bt2
    -rw------- 1 kkayttaj csc 1.3G Mar 12 13:13 Danio_rerio.GRCz10.dna.toplevel.fa
    -rw------- 1 kkayttaj csc 440M Mar 12 14:03 Danio_rerio.rev.1.bt2
    -rw------- 1 kkayttaj csc 327M Mar 12 14:03 Danio_rerio.rev.2.bt2
    -rw------- 1 kkayttaj csc 599K Mar 12 13:13 log

The data is collected and compressed to a single file with *[tar]*
command:

    tar zcf zebrafish.tgz Danio_rerio*

The size of the resulting file is about 2 GB. Now the compressed file
can be uploaded to the the *fish-bucke*t with command *s3cmd put*:

    [kkayttaj@c306:~]$ ls -lh zebrafish.tgz
    -rw------- 1 kkayttaj csc 2.0G Mar 12 15:23 zebrafish.tgz

    [kkayttaj@c306:~]$ s3cmd put zebrafish.tgz s3://fish-bucket
    put zebrafish.tgz s3://fish-bucket
    upload: 'zebrafish.tgz' -> 's3://fish-bucket/zebrafish.tgz'  [part 1 of 136, 15MB] [1 of 1]
     15728640 of 15728640   100% in    0s    22.49 MB/s  done
    upload: 'zebrafish.tgz' -> 's3://fish-bucket/zebrafish.tgz'  [part 2 of 136, 15MB] [1 of 1]
     15728640 of 15728640   100% in    0s    23.17 MB/s  done
    ...
    upload: 'zebrafish.tgz' -> 's3://fish-bucket/zebrafish.tgz'  [part 135 of 136, 15MB] [1 of 1]
     15728640 of 15728640   100% in    0s    24.13 MB/s  done
    upload: 'zebrafish.tgz' -> 's3://fish-bucket/zebrafish.tgz'  [part 136 of 136, 3MB] [1 of 1]
     4002097 of 4002097   100% in    0s     8.96 MB/s  done

    [kkayttaj@c306:~]$ s3cmd ls s3://fish-bucket
    ls s3://fish-bucket
    2018-03-12 13:29 2127368497   s3://fish-bucket/zebrafish.tgz

Uploading 2 GB of data takes few minutes. The uploaded file could be
retrieved with command:

    s3cmd get s3://fish-bucket/zebrafish.tgz

By default this bucket can be accessed only by the project members.
However, with *s3cmd setacl* you can make the file publicly available:

First make the *fish-bucket* public

    s3cmd setacl --acl-public s3://fish-bucket

And then make the zebrafish genome file public:

    s3cmd setacl --acl-public s3://fish-bucket/zebrafish.tgz

The syntax of URL of the file is:

https://*bucket-name*.object.pouta.csc.fi/*object\_name*

So in this case the file would be accessible through link:

<https://fish-bucket.object.pouta.csc.fi/zebrafish.tgz>

 

  [Pouta User Guide]: https://research.csc.fi/pouta-object-storage
  [1]: https://research.csc.fi/ {#3.3.1}
  [2]: https://research.csc.fi/ {#s3cmd}
  [3]: https://research.csc.fi/ {#3.3.2}
  [s3cmd manual page]: http://s3tools.org/usage
  [tar]: https://research.csc.fi/csc-guide-packing-and-compression-tools#tar
