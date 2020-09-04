#!/bin/bash

is_leap_year () {
    [[ "$1" =~ ^[0-9]+$ ]] && (( (($1 % 4) == 0) && ((($1 % 100) != 0) || (($1 % 400) == 0)) ))
}

is_ddmmyyyy () {
    local dd="${1:0:2}" mm="${1:2:2}" yyyy="${1:4:4}"
    local ds=(31 28 31 30 31 30 31 31 30 31 30 31)
    is_leap_year $yyyy && ds[1]=29
    [[ "$1" =~ [0123][0-9][01][0-9][0-9]{4} ]] || return 1
    (( mm < 1 || mm > 12 || dd < 1 || dd > ds[mm - 1] )) && return 1
    return 0
}

is_finnish_social_security_number () {
    local ddmm=${1:0:4} yy=${1:4:2} a=${1:6:1} n=${1:7:3} c=${1:10:1} yyyy
    local s='0123456789ABCDEFHJKLMNPRSTUVWXYZ'
    [[ "$a$n$c" =~ [-+A][0-9]{3}[0-9ABCDEFHJLKMNPRSTUVWXY] ]] || return 1
    case "$a" in '+') yyyy="18$yy";; '-') yyyy="19$yy";; 'A') yyyy="20$yy";; esac
    is_ddmmyyyy $ddmm$yyyy && [[ "$c" = ${s:$(( $ddmm$yy$n % 31)):1} ]]
}


