## Stacks

### Description

Stacks is a software pipeline for building loci from short-read sequences, such as those generated on the Illumina platform. Stacks was developed to work with restriction enzyme-based data, such as RAD-seq, for the purpose of building genetic maps and conducting population genomics and phylogeography.

* * *

### Available

##### Version on CSC's Servers

Taito: 1.46, 1.48, 2.0b, 2.3

* * *

### Usage

The command line tools of the Stacks pagage are installed in Taito. To set up the most recent stacks environment in Taito, run commands:

    module load gcc/5.4.0
    module load stacks

To load a specific version of Stacks use e.g.:

    module load biokit/4.9.3
    module load stacks/2.0

After that you can launch Stacks commands like denovo\_map.pl. for example:

    denovo\_map.pl  -m 3 -M 2 -n 3 -T 4 -S -b 1 -t -a 2010-11-30 -o ./stacks  -p ./samples/male.fa  -p ./samples/female.fa -r ./samples/progeny\_1.fa  -r ./samples/progeny\_2.fa  -r ./samples/progeny\_3.fa

As stacks jobs can be rather heavy they should be executed in [taito-shell.csc.fi](/taito-shell-user-guide) or as batch jobs. Note that in Taito-shell the maximum number of threads to be used is 4 (-T 4) while in batch jobs you can use larger values (up to 24 ). The Stacks installation in Taito is not linked to a stacks result database and web interface. Because of that you should use option -S ( and not options -B and -D) in denovo\_map.pl runs.

It is howerver possible to set up your own Stacks database and WWW interface to a virtual machine running in the cPouta cloud environment of CSC. (Link to instrctions to set up a Stacks server in cPouta can be found form the end of this page.)

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

[Stacks manual](http://catchenlab.life.illinois.edu/stacks/manual/)

* * *