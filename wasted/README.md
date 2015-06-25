wasted
======

This program, `wasted`, finds out jobs that possible waste CPU resources.

The program works in Cray XT5, `sisu.csc.fi`, by comparing squeue resource
reservation info and apstat runtime info.

I have tried to follow good programming and program development
practices in the implementation of the project. I hope that this
project could be used as course material in teaching.

Below is a list of program development process issues that I have
frequently encountered:

1. Source code version control, backup, development collaboration (git
   and github)
2. Documentation (annotated source, pandoc, markdown)
3. Build process, i.e. configuration, compilation, linking, testing (make)

Fortunately, there exist simple and powerful tools that help with the
above issues. My favorites tools are listed within the parenthesis above.

Many of the issues in the actual implementation of the
application are solved with good design and disciplined programming:

1. Modularity (factoring, interfaces, data structures and formats)
2. Generality (interfaces, data structures and formats)
3. Reducing dependencies and conditional compilation (discipline)
4. Gradual corruption of the code (discipline, continous development model)

Note, good design and disciplined programming are goals. They can be
achieved with prototyping and agile development process, too.

Above all, and in all stages, there are two program development
principles that I think will make the life more joyful:

KISS
:   Keep It Simple, Stupid!

DRY
:   Don't Repeat Yourself!
