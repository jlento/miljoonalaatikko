## GUIDANCE

### Description

GUIDANCE is a powerful and user-friendly tool for assigning a confidence score for each residue, column, and sequence in an alignment and for projecting these scores onto the MSA.  
The result file points to columns and sequences that are unreliably aligned and enables their automatic removal from the MSA, in preparation for downstream analyses.

Three algorithms for quantifying MSA uncertainties are implemented:

*   GUIDANCE score is based on the robustness of the MSA to guide-tree uncertainty and relies on the bootstrap approach.
*   The Heads-or-Tails (HoT) score measures alignment uncertainty due to co-optimal solutions.
*   GUIDANCE2 is an integrative methodology that accounts for:

1.  uncertainty in the process of indel formation
2.  uncertainty in the assumed guide tree (as GUIDANCE)
3.  co-optimal solutions in the pair-wise alignments, used as building blocks in progressive alignment algorithms (as HoT).

* * *

### Available

##### Version on CSC's Servers

Taito: 2.01

* * *

### Usage

To load GUIDANCE:

    module load biokit
    module load guidance
    

To see available options, give command:

    guidance.pl
    

Typical usage:

    guidance.pl --seqFile SEQFILE --msaProgram \[MAFFT|PRANK|CLUSTALW|MUSCLE\] --seqType \[aa|nuc|codon\] --outDir FULL\_PATH\_OUTDIR
    

Example using 4 computing cores:

    guidance.pl --seqFile ART3.fas --msaProgram PRANK --seqType aa --outDir /wrk/example/guidance\_test/art3 --proc\_num 4
    

Please note that you will need to provide the full path to the output directory. You can check the path to the current directory with command:

    pwd
    

The biokit module loads MAFFT, PRANK, ClustalW and Muscle, so they can be used directly, eg:

    \--msaProgram PRANK
    

PAGAN is available in Taito, but is not part of the biokit module, so to use it, include option:

    \--pagan /appl/bio/pagan/pagan-20150723/bin/pagan
    

* * *

### Discipline

Biosciences  

* * *

### References

*   [GUIDANCE citing & credits](http://guidance.tau.ac.il/ver2/credits.php)

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

*   [Home page](http://guidance.tau.ac.il/ver2/overview.php)
*   [Usage overview](http://guidance.tau.ac.il/ver2/source.php)

* * *