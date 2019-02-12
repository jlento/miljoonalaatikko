## SOAPdenovo

### Description

SOAPdenovo is a short-read assembly method specially designed to assemble Illumina GA short reads. SOAPdenovo designed for  for large plant and animal genome assembly tasks, although it can also be used for bacteria and fungi genomes.

* * *

### Available

##### Version on CSC's Servers

Taito: 240

* * *

### Usage

In Taito there are two versions of SOAPdenovo2 program available:

*   SOAPdenovo-63mer
*   SOAPdenovo-127mer

You do not need to load any module to use these.

Once you have created a configuration file (soap.config) for your assembly task, you can launch the assembly job with the command _SOAPdenovo-63mer_ or _SOAPdenovo-127mer_ .  
  
For example

    SOAPdenovo-63mer all -s soap.config -K 63 -d 2 -o results -p 2

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

More information about SOAPdenovo can be found form the [SOAPdenovo home page](http://soap.genomics.org.cn/soapdenovo.html).

* * *