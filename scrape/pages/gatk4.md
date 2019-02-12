## GATK4

### Description

GATK4 toolkit offers a wide variety of tools with a primary focus on variant discovery and genotyping.

GATK is open source from version 4 onwards. Please note we cannot provide older (3.x) versions. You can, however, license older version yourself, and install it to your $USERAPPL. Installation is fast and easy. You just need to uncompress the distribution package.

* * *

### Available

##### Version on CSC's Servers

Taito: 4.0.12.0

* * *

### Usage

To load GATK4 analysis environmet:

    module load gatk-env
    

Please note this will remove all loaded modules.

It will load GATK4 and some related programs:

*   R (3.2.5) and Rstudio
*   Picard Tools (2.13.2)
*   Samtools (1.4)
*   RTG (3.8.4)
*   IGV (3.8.4)

## GATK

The general format for GATK commands is:

    gatk ToolName \[tool args\]

To see the list of available tools use:

    gatk --list

To pass arguments to java (e.g. memory requirements), use --java-options parameter:

    gatk \[--java-options "-Xmx4G"\] ToolName \[GATK args\]

Please note that in the 4.beta versions the basic command was "**gatk-launch**" instead of "**gatk**".

## Related tools

R and Rstudio start simply with command:

    R
    rstudio

Similarily for the other programs:

    samtools
    rtg
    igv

For picard we supply a wrapper script, so you can simply use

    picard <command>

If you need to pass some java arguments (e.g. for memory) you can use $PICARD system variable:

    java <java options> -jar  $PICARD <picard options>

Please note that for some of the tools you will need a graphical connection. NoMachine remote desktop is recommended. Please see [CSC Computing Environment User Guide](https://research.csc.fi/csc-guide-connecting-the-servers-of-csc) for details.

* * *

### Discipline

Biosciences  

* * *

### References

*   **The Genome Analysis Toolkit: a MapReduce framework for analyzing next-generation DNA sequencing data** McKenna A, Hanna M, Banks E, Sivachenko A, Cibulskis K, Kernytsky A, Garimella K, Altshuler D, Gabriel S, Daly M, DePristo MA, 2010 _GENOME RESEARCH 20:1297-303_
*   **A framework for variation discovery and genotyping using next-generation DNA sequencing data** DePristo M, Banks E, Poplin R, Garimella K, Maguire J, Hartl C, Philippakis A, del Angel G, Rivas MA, Hanna M, McKenna A, Fennell T, Kernytsky A, Sivachenko A, Cibulskis K, Gabriel S, Altshuler D, Daly M, 2011 _NATURE GENETICS 43:491-498_
*   **From FastQ Data to High-Confidence Variant Calls: The Genome Analysis Toolkit Best Practices Pipeline** Van der Auwera GA, Carneiro M, Hartl C, Poplin R, del Angel G, Levy-Moonshine A, Jordan T, Shakir K, Roazen D, Thibault J, Banks E, Garimella K, Altshuler D, Gabriel S, DePristo M, 2013 _CURRENT PROTOCOLS IN BIOINFORMATICS 43:11.10.1-11.10.33_

For more detailed instructions on citing GATK, please refer the [Frequently Asked Questions](https://software.broadinstitute.org/gatk/documentation/topic?name=faqs) sectionon GATK web pages.

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

Detailed usege instruction can be found in

*   [GATK home page](https://software.broadinstitute.org/gatk/documentation/)

* * *