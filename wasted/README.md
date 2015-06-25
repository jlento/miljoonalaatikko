wasted
======

Find out jobs that possible waste CPU resources.

Works in Cray XT5, sisu.csc.fi, by comparing squeue resource
reservation info and apstat runtime info.

I have tried to follow good programming development practices in the
implementation of the project. I hope that this project could be used as
course material in teaching good programming and program development
practices.

My list of points to consider in the program development process is:

1. Source code version control, backup, development collaboration (git
   and github)
2. Documentation (annotated source, pandoc, markdown)
3. Build process, i.e. configuration, compilation, linking, testing (make)

My list of points to consider in the implementation of the application is:

1. Modularity (factoring, interfaces, data structures and formats)
2. Generality (interfaces, data structures and formats)
3. Reducing dependencies and conditional compilation

Above all, and in all stages, there are two principles that I think
everybody should follow:

KISS
:   Keep It Simple, Stupid!

DRY
:   Don't Repeat Yourself!
