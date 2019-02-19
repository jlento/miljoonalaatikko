# 5.6 Using Funet FileSender to share and transport files {#using-funet-filesender-to-share-and-transport-files .western}

*Funet FileSender* is a browser based service for sending large files to
colleagues. It provides as an alternative to e-mail attachments but it
can be used for moving files to CSC environment too. The *Funet
FileSender* allows you to upload and send files up to 300 GB size. The
service is not intended for long-term storage, but the files are deleted
automatically after the preservation time is exceeded. The maximum
preservation time is 21 days.

The *Funet FileSender* service is available for all Haka-enabled
organisations without any additional measures. For example CSC user
account is not needed to use this service. Both sending and receiving
are possible without installing any additional programs.

You can use *Funet FileSender* to share your files with anybody. The
<span lang="en-US">receiver</span> doesn't need any authentication for
downloading the file from <span lang="en-US">*FileSender*</span><span
lang="en-US">.</span> If you don't belong to Haka, you need a colleague
who can send you an *upload vouche*r. The voucher is a one-time permit
to use the service for sending a file.

## [][1]5.6.1. Uploading data to FileSender {#uploading-data-to-filesender .western}

First login to the service with your web browser in URL:
[https://filesender.funet.fi]. You should login to the system with your
Haka credentials: first select your home organization and use your local
user name and password to long in (not CSC user name and password).

After this you can specify the email address of the recipient and use
the *Browse* button to select the file you want to send. After the
temporary storage time is defined (*Expiry date:*) and the usage terms
are accepted press the **Send** button to upload the file. Once the file
is uploaded the recipient will get an e-mail notification.

It is possible to administer your files while they are waiting for the
pick-up. Click the *My Files* button to do this.

Figure 5.8 Funet FileSender file upload page
(https://filesender.funet.fi/).

![][2]

**Figure 5.8** Funet FileSender file upload page
(<https://filesender.funet.fi/>).

 

## [][3]5.6.2 Download data from FileSender {#download-data-from-filesender .western}

The recipient will get an email that contains an URL to the download
page of the submitted file. You can start the download by pressing the
"*Start Download*" button. This button is linked to the URL containing
the actual file and it can be used to download the file to your local
computer  
. ![][4]  
**Figure 5.9** Funet FileSender Download page.

However, the URL pointing to the uploaded file, can be used also from
other applications, not only through the FileSender interface. Thus, if
you copy the URL that the *Start Download* button points to, you can use
it with the [*wget*] command to download the file directly to the CSC
servers. The syntax of the *wget* command in this case would be

~~~~ western
wget "file_sender_url" -O output_file_name
~~~~

For example, if the uploaded file "*tophat\_test.tgz*" has URL:

`https://filesender.funet.fi/download.php?vid=697d15b6-6190-37a9-9b8f-00005fa28192`

It can be downloaded to Taito with command:

    wget "https://filesender.funet.fi/download.php?vid=697d15b6-6190-37a9-9b8f-00005fa28192" -O tophat_test.tgz

 

 

  [1]: https://research.csc.fi/ {#5.6.1}
  [https://filesender.funet.fi]: https://filesender.funet.fi/
  [2]: https://research.csc.fi/documents/48467/84606/FileSender1.jpg/ef2f2879-d856-4ad8-bbd1-be110a3e07b0?t=1383829134000
  [3]: https://research.csc.fi/ {#5.6.2}
  [4]: https://research.csc.fi/documents/48467/84606/FileSender2.jpg/e0eeae9f-2dbe-4cef-9191-edb1eaa81c91?t=1383829204000
  [*wget*]: https://research.csc.fi/csc-guide-using-wget-to-download-data-from-web-sites-to-csc
