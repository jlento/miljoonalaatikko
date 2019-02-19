## Mega2

### Description

Mega2 is a utility program that can be used to convert data files from
one format to another. Typically the program can be used to convert
Linkage-format files to file-formats used by other programs such as
SimWalk2.

It also incorporates analysis functionality, such as test for
Hardy-Weinberg equilibrium.

For many of the program options, Mega2 sets up a C-shell script that
then can automatically run the appropriate analyses.

Mega2 is structured so that the user proceeds through a series of menus,
making choices in each one (or accepting the default values), until the
desired output files are created. After the desired output files are
created, Mega2 exits.

------------------------------------------------------------------------

### Available

##### Version on CSC's Servers

  
Taito: 4.9.1

------------------------------------------------------------------------

### Usage

Mega2 is an interactive program and best run in Taito-shell. To
initialize the program type:

    module load biokit

Start the program by typing:

    mega2

Mega2 is quite simple to use because of its menu-driven interface.

------------------------------------------------------------------------

### Discipline

Biosciences  

------------------------------------------------------------------------

### References

If you use Mega2 as part of a published work, please remember to
reference Mega2. You may reference it by citing the following:

> Baron RV, Kollar C, Mukhopadhyay N, Weeks DE (2014) Mega2: validated
> data-reformatting for linkage and association analyses. Source Code
> for Biology and Medicine 9:26. PubMed PMID: 25687422; PubMed Central
> PMCID: [PMC4269913] DOI: [10.1186/s13029-014-0026-y]

as well as citing the web site and the version that you used. For
example, the web site citation for version 4.9.2 should be:

> Baron RV, Kollar CP, Mukhopadhyay N, Almasy L, Schroeder M, Mulvihill
> WP, Weeks DE (2015) Mega2 (Version 4.9.2).
> <https://watson.hgen.pitt.edu/mega2.html>

Use of Mega2 to convert VCF or BCF input files makes use of a built-in
copy of VCFtools; you should cite the following paper:

> [The Variant Call Format and VCFtools], Petr Danecek, Adam Auton,
> Goncalo Abecasis, Cornelis A. Albers, Eric Banks, Mark A. DePristo,
> Robert Handsaker, Gerton Lunter, Gabor Marth, Stephen T. Sherry,
> Gilean McVean, Richard Durbin and 1000 Genomes Project Analysis Group,
> Bioinformatics (2011) 27 (15): 2156-2158.

Use of Mega2 to convert IMPUTE2 GEN or binary IMPUTE2 BGEN format input
files makes use of a built-in copy of bgen; you should also cite the
following work:

> The BGEN format: A compressed binary format for typed and imputed
> genotype data,
> [http://www.well.ox.ac.uk/~gav/bgen\_format/bgen\_format\_v1.2.html],
> Gavin Band and Jonathan Marchini

------------------------------------------------------------------------

### Support

servicedesk@csc.fi

------------------------------------------------------------------------

### Manual

-   [Mega2 home page]

------------------------------------------------------------------------

  [PMC4269913]: http://www.ncbi.nlm.nih.gov/pmc/articles/PMC4269913/?report=reader
  {.URL}
  [10.1186/s13029-014-0026-y]: http://doi.org/10.1186/s13029-014-0026-y
  {.URL}
  [The Variant Call Format and VCFtools]: http://dx.doi.org/10.1093/bioinformatics/btr330
  {.URL}
  [http://www.well.ox.ac.uk/~gav/bgen\_format/bgen\_format\_v1.2.html]: http://www.well.ox.ac.uk/%7Egav/bgen_format/bgen_format_v1.2.html
  {.FlexURL}
  [Mega2 home page]: http://watson.hgen.pitt.edu/docs/mega2_html/mega2.html
