## bioconda

### Description

[Conda] is  a package management tool  that is used to  distribute and
install software tools together with their dependencies. In Taito, the
**bioconda module**  takes in use  a CSC maintained  Conda environment
(Python2 based miniconda2) together  with channel settings that enable
easy usage of the [Bioconda repository.]

The Bioconda environment is used for two purposes in Taito:

1.  Some software tools, maintained by  CSC, are installed and used as
    conda environments.
2.  Taito users  can use bioconda module to  install [tools, available
    in Bioconda repository], to their own personal Conda environments.

There is two versions of  Bioconda installation available in taito:

-   **Python2.7 and miniconda2**  based installation (2, default) that
    is taken in use with command:

~~~~
module load bioconda
~~~~

-   **Python3.6 and miniconda3** based  installation (3) that is taken
    in use with command:

~~~~
module load bioconda/3
~~~~

 

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

Conda/Bioconda versions 2 and 3 are available in Taito supercluster.

------------------------------------------------------------------------

### Usage

**1. Using tools installed with bioconda**

To use software  environments that are installed to  Taito using Conda
(either by CSC or yourself),  first load bioconda module:

    module load bioconda

or if you wish to use the miniconda3 based version:

    module load bioconda/3

Then list the available Conda environments

    conda env list

Next activate a Conda environment

    source activate env_name

Later on you can deactivate the environment with command:

    source deactivate

 

**2. Installing software for your own use with bioconda**

You can use the bioconda module to install software packages available
in the Bioconda repository to your personal conda environments. In the
example below  a new conda environment,  containing **bedops** package
is cerated:

    module load bioconda
    conda create -n my_biotools bedops
    source activate my_biotools

After  this, commands  included in  *bedops*  tools can  be used.  For
example:

    vcf2bed

To deactivate the current conda environment, run command:

    source deactivate

Next time  you need  to use  vcf2bed, it  is enough  that you  run the
set-up commands:

    module load bioconda
    source activate my_biotools
    vcf2bed

Not  that  the  miniconda2   and  miniconda3  based  environments  are
independent.  If you  have installed  your application  using Bioconda
version 3 the environment is not available when the default bioconda 2
module is loaded (and *vice versa*).

 

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

------------------------------------------------------------------------

### Support

------------------------------------------------------------------------

### Manual

-   [Conda home page][Conda]
-   [Bioconda home page][Bioconda repository.]

------------------------------------------------------------------------

  [Conda]: https://conda.io/docs/
  [Bioconda repository.]: https://bioconda.github.io/
  [tools, available in Bioconda repository]: https://bioconda.github.io/recipes.html
