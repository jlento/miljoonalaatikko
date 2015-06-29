wasted
======

This program, `wasted`, finds out jobs that possible waste CPU resources.

The program works in Cray XT5, `sisu.csc.fi`, by comparing squeue
resource reservation info and apstat runtime info. Try
`make install; ./bin/wasted`
in some temporary directory in `sisu`.

Running `make test` uses cached example input data from files, and can be
executed on any linux box.


Project goal
------------

I have tried to follow good programming and program development
practices in the implementation of the project. I hope that this
project could be used as course material in teaching general
programming and program development process.

Below is a list of program development process tasks that often have
weaknesses in scientific software development projects:

1. Source code version control, backup, development collaboration (git
   and github)
2. Documentation (annotated source, pandoc, markdown)
3. Build process, i.e. configuration, compilation, linking, testing (make)
4. Continous development (unit tests, bug tracking)

Fortunately, there exist simple and powerful tools that help with the
above tasks. My favorites tools are listed within the parenthesis above.

Many of the issues in the actual implementation of the
application are solved with good design and disciplined programming:

1. Modularity (factoring, interfaces, data structures and formats)
2. Generality (interfaces, data structures and formats)
3. Reducing dependencies and conditional compilation (discipline)

Note, good design and disciplined programming are goals. They can be,
and often are, achieved with prototyping and agile development
process.

Above all, and in all stages, there are two program development
principles that I think will make the life more joyful:

KISS
:   Keep It Simple, Stupid!

DRY
:   Don't Repeat Yourself!
