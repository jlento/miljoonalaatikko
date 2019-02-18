## Illumina BaseSpace

### Description

Illumina  BaseSpace  command  line  client, **bs**,  can  be  used  to
retrievie data from the Illumina BaseSpace environment to Taito.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Illumina BaseSpace command line client is available in Taito

------------------------------------------------------------------------

### Usage

The Illumina BaseSpace command line client starts with command:

    bs

To  be able  to use  this  service you  must  have an  account in  the
[Illumina Base Space service].

As the first step you must set  up your authentication so that you can
access  your data  in  Illumina  BaseSpace. This  is  done by  running
command:

    bs auth

The authentication information is stored to your home directory in
Taito  
($HOME/.basespace/default.cfg).  Thus the  authentication needs  to be
done
only  
once. [][1]

After that you can start working with your Illumina data. For example,
available datasets can be listed with command:

    bs list datasets

Single dataset can be downloaded to Taito with command:

    bs download dataset -i dataset_id -o local_download_dir

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

More detailed information about using Illumne BaseSpace client can be
found form the links below :  
  
<span
class="clickylink"><https://developer.basespace.illumina.com/docs/content/documentation/cli/cli-examples></span>  
<span
class="clickylink"><https://developer.basespace.illumina.com/docs/content/documentation/cli/cli-overview></span>

------------------------------------------------------------------------

  [Illumina Base Space service]: https://emea.illumina.com/products/by-type/informatics-products/basespace-sequence-hub.html
  [1]: https://research.csc.fi/group/control_panel/manage?p_p_auth=jxdW5bWl&p_p_id=15&p_p_lifecycle=0&p_p_state=maximized&p_p_mode=view&doAsGroupId=48467&refererPlid=131822&controlPanelCategory=current_site.content&_15_struts_action=%2Fjournal%2Fedit_article&_15_redirect=https%3A%2F%2Fresearch.csc.fi%2Fgroup%2Fcontrol_panel%2Fmanage%3Fp_p_auth%3DjxdW5bWl%26p_p_id%3D15%26p_p_lifecycle%3D0%26p_p_state%3Dmaximized%26p_p_mode%3Dview%26doAsGroupId%3D48467%26refererPlid%3D131822%26controlPanelCategory%3Dcurrent_site.content&_15_groupId=48467&_15_folderId=0&_15_articleId=370359&_15_status=0&_15_selPlid=133786#_15_schedule {#_15_scheduleLink .tab-label .tab-content}
