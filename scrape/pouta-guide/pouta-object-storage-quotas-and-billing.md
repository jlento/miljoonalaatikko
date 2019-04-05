## 4.4.4 Quotas and Billing

The default quotas for every project are:

|                        | |
|------------------------|:---------:|
| **Resource**           | **Limit** |
| Storage Amount         |    1TiB   |
| Containers per project |    1000   |
| Objects per container  |  100000   |
|  Object Size\*         |    5 GB   |

<span style="color:  rgb(0, 0,  0);">\* See  </span>[chapter 4.4.5.5.3
for about storing larger objects]

If you  are using  s3cmd client,  you can  check you  project's Object
Storage usage with command:

    s3cmd du -H

In the case of swift client, you check this with command:

    swift stat

To see how much space a bucket has used

    swift stat $bucketname

It's currently not possible to view  the current quota limits for your
project. Please contact servicedesk@csc.fi if you have questions.

Object  Storage   consumes  billing  units.  Accounting   and  billing
information can be found under [Accounting principles and quotas.]

Unlike most other object storage providers, CSC does not charge for
object storage network transfers or API calls.  
 

|                    | | | | |
|--------------------|-----|----------------|-----|--------------------------------------------------------------------|
| [Previous chapter] |     | [One level up] |     | [Next chapter][chapter 4.4.5.5.3 for about storing larger objects] |

  [chapter 4.4.5.5.3 for about storing larger objects]: https://research.csc.fi/pouta-using-object-storage
  [Accounting principles and quotas.]: https://research.csc.fi/pouta-accounting
  [Previous chapter]: https://research.csc.fi/pouta-object-storage-common-use-cases
  [One level up]: https://research.csc.fi/pouta-object-storage
