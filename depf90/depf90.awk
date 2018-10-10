#!/bin/awk

# Simple AWK script to extract module dependencies from fortran source files
# for makefiles
#
# Usage: awk -f depf90.awk SOURCE [SOURCE] ...

# Pretty printing
function print_target (target) {
    gsub(".*/", "", target)
    gsub("\.[fF](|pp|PP|or|OR|tn|TN|90|95|03)?$", ".o", target)
    printf "%s :", target
    pos = length(target) + 3
    indent = pos
}

# Pretty printing
function print_prereq (prereq) {
    gsub(".*/", "", prereq)
    gsub("\.[fF](|pp|PP|or|OR|tn|TN|90|95|03)?$", ".o", prereq)
    if (pos > indent) {
        printf " \\\n"
        printf "%" indent "s%s", "", prereq
        pos = indent + length(prereq)
    } else {
        printf " %s", prereq
        pos = pos + length(prereq) + 1
    }

}

tolower($1) == "module" || tolower($1) == "program" {
    modules[tolower($2)] = FILENAME
}

tolower($1) == "use" {
    uses[FILENAME]= uses[FILENAME] FS tolower($2)
}

END {
    for (target in uses) {
        delete prereqs
        n = split(uses[target], deps)
        for (i in deps) {
            if (modules[deps[i]] != target) {
                prereqs[modules[deps[i]]]++
            }
        }
        if (n > 0) {
            print_target(target)
            for (prereq in prereqs) {
                print_prereq(prereq)
            }
            printf "\n\n"
        }
    }
}
