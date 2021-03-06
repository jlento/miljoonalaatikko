## 4.4.7 Common Error Messages

HTTP status code **409** - There is already a bucket with that name

    Conflict

HTTP status code **404** - Bucket does not exist:

    NoSuchBucket

HTTP status  code **403** - Your  credentials are not allowed  to view
bucket

    AccessDenied

HTTP status  code **403** -  You have  reached a quota  limit. Contact
servicedesk@csc.fi and  ask to have  the quota increased.  Include the
project, bucket and size of the file.

    QuotaExceeded

HTTP  status  code  **400**  -  Your  file  is  much  too  large.  See
"[4.4.5.5.3 Files larger than 5 GB]"

    EntityTooLarge

|                    | | | | |
|--------------------|-----|----------------|-----|----------------|
| [Previous chapter] |     | [One level up] |     | [Next chapter] |

  [4.4.5.5.3 Files larger than 5 GB]: https://research.csc.fi/pouta-using-object-storage
  [Previous chapter]: https://research.csc.fi/accessing-the-pouta-object-storage-from-taito
  [One level up]: https://research.csc.fi/pouta-object-storage
  [Next chapter]: https://research.csc.fi/pouta-adding-images
