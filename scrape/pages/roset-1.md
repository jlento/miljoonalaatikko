## Rosetta

### Description

ROSETTA is a software suite for predicting and designing protein structures, protein folding mechanisms, and protein-protein interactions. The Rosetta suite can be used for example for following tasks:

*   Perform sequence based de novo protein structure prediction.
*   Predict the structure of a protein-protein complex from the individual structures of the monomer components.
*   Predict structures of protein-peptide complexes with flexible peptide models
*   For small molecule - protein docking
*   Predict antibody Fv region structures and perform antibody-antigen docking.
*    For the design of proteins that interact with specified DNA sequences.
*   Comparative homology modeling
*   predict  the structure of homooligomeric protein assemblies starting from the structure of a single subunit.

* * *

### Available

##### Version on CSC's Servers

Rosetta 2018.19 is available in Taito.

* * *

### Usage

At CSC, Rosetta is available only for academic non-profit researchers.

Please register your self as Rosetta user in the Rosetta home page before starting to use Rosetta.  
[Rosetta registration](https://els.comotion.uw.edu/express_license_technologies/rosetta)  
To set up Rosetta commands in Taito give commands:

    module load gcc/4.9.1
    module load rosetta

After that you can start using use Rosetta commands.  
   
Examples of Rosetta 2018.19 commands can be found from the demos directory of Rosetta. In Taito the location of this directory is:

    /appl/bio/rosetta/2018.19/demos
    Note that not all the Rosetta help tools are not fully installed. Further, in the tutorials the commands have different suffix (_linuxclangrelease)_ that in Taito should be replaced with: _linuxgccrelease._

Sample tutorial run (use Taito-shell for running tutorials):

    cd $WRKDIR
    module load gcc/4.9.1
    module load rosetta
    cp /appl/bio/rosetta/2018.19/demos/tutorials/denovo\_structure\_prediction ./
    cd denovo\_structure\_prediction
    AbinitioRelax.default.linuxgccrelease @input\_files/options
    

* * *

### Discipline

Biosciences  

* * *

### References

* * *

### Support

* * *

### Manual

*   [Rosetta user guide](https://www.rosettacommons.org/docs/latest/Home)

* * *