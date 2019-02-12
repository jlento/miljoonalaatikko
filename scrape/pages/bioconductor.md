## Bioconductor

### Description

Bioconductor provides tools for the analysis and comprehension of high-throughput genomic data: sequencing (NGS), microarray and proteomics data. Most Bioconductor components are distributed as R packages.

* * *

### Available

##### Version on CSC's Servers

Taito: 3.4 with R-3.3.2

* * *

### Usage

Many Bioconductor packages are pre-installed in R in Taito. 

In Taito, load the R-module with the command:

    module load r-env

For interactive use in Taito-shell you can either use R in the command line or via RStudio. You can also request an interactive job in a computing node in Taito. For jobs requiring more than 4 cores or over 120GB of memory, you can run your R-script in batch mode. See the the [R documentation](https://research.csc.fi/-/r) for more details, required commands and example batch job file.

To install possibly missing packages, type (in an R session):

    source("http://bioconductor.org/biocLite.R")
    biocLite("PackageName")

or request the installation by contacting [servicedesk@csc.fi](mailto:servicedesk@csc.fi).

* * *

### Discipline

Biosciences  

* * *

### References

When you use **R**, please cite. Please note that corresponding citation is available at R by typing _citation()_.

R Development Core Team (2008). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http://www.R-project.org.

R Core Team (2013). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. ISBN 3-900051-07-0, URL http://www.R-project.org/.

When you use **Bionconductor**, please cite:

Gentleman RC, Carey VJ, Bates DM, Bolstad B, Dettling M, Dudoit S, Ellis B, Gautier L, Ge Y, Gentry J, Hornik K, Hothorn T, Huber W, Iacus S, Irizarry R, Leisch F, Li C, Maechler M, Rossini AJ, Sawitzki G, Smith C, Smyth G, Tierney L, Yang JY, Zhang J. Bioconductor: open software development for computational biology and bioinformatics. Genome biology 5.10 (2004): R80.

* * *

### Support

servicedesk@csc.fi

* * *

### Manual

More information about R and Bionconductor can be found from the [R](http://cran.r-project.org/) and [Bionconductor ](http://www.bioconductor.org/)home page.

* * *