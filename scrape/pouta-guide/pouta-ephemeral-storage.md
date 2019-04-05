### 4.1 Ephemeral storage

Some  Pouta  virtual machine  [flavors]  have  *ephemeral storage*  in
addition to  a root  disk. This  works as  additional storage  for the
duration of the instance. This storage is not saved with the instance.
This storage **does  not** get saved when you create  a snapshot of an
image.   It is  not copied  along with  resizes or  migrations. It  is
especially  important to  note regarding  the io.\*  flavors that  the
storage is based on RAID0  arrays optimized for performance, providing
no redundancy whatsoever.

For a  detailed explanation  of ephemeral  storage (and  other storage
options), you can see [the  storage concepts] section in the OpenStack
user guide.

The ephemeral storage is visible as  an additional disk to the virtual
machine (usually  /dev/vdb). <span style="line-height:  1.5;">You will
need to format and mount it first before you can use it:</span>

    sudo mkfs.ext4 /dev/vdb
    sudo mount /dev/vdb /mnt

You will  also need  to add  an entry  to the  /etc/fstab file  on the
machine to make sure the disk gets mounted after a reboot:

    sudo umount /mnt/
    sudo e2label /dev/vdb EPHEMERAL
    sudo echo "LABEL=EPHEMERAL   /mnt   ext4  defaults,nofail 0 2 " >> /etc/fstab
    sudo mount /mnt

Some legacy flavors (tiny, mini,  small, medium, large, fullnode) also
contained  an  ephemeral  disk,  which was  preformatted  and  mounted
automatically.

|                    | | | | |
|--------------------|-----|----------------------------------|-----|----------------|
| [Previous chapter] |     | [One level up][Previous chapter] |     | [Next chapter] |

 

 

  [flavors]: https://research.csc.fi/pouta-flavours
  [the storage concepts]: https://docs.openstack.org/arch-design/design-storage/design-storage-concepts.html
  [Previous chapter]: https://research.csc.fi/pouta-storage
  [Next chapter]: https://research.csc.fi/pouta-persistent-volumes
