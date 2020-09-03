#!/bin/bash

# Check Finnish social security number

check_leap_year () {
    [[ "$1" =~ ^[0-9]+$ ]] && (( (($1 % 4) == 0) && ((($1 % 100) != 0) || (($1 % 400) == 0)) ))
}

check_ddmmyy () {
    (( ${1:1,2} < 31 ))
}
