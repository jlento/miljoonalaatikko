#!/bin/bash
#
# % Wasted
# % juha.lento@csc.fi
# % 2015-06-22

# Remove leading and trailing white space characters
# --------------------------------------------------
#
# ~~~ {.bash} 
strip () {
  [[ "$1" =~ ^[[:space:]]*(.*[^[:space:]]) ]]
  echo "${BASH_REMATCH}"
}
# ~~~
#
#

# Almost like awk split
# ---------------------
#
# Usage: `split <string> <array name> [<field separator>]`
#
# Split a string and return the result in an array.
#
# Optional field separator is Extended Regular Expression (ERE). The default
# is `[:space:]`.
#
# ~~~ {.bash} 
split () {
  local i=0
  eval unset $2
  if [ $# -lt 3 ]; then
    sep=$'[[:space:]]+'
  else
    sep="$3"
  fi
  if [[ "" =~ $sep ]]; then
    if [ "$1" == "" ]; then
      eval $2[0]='""'
    else
      while : ; do
        eval $2[${i}]='"${1:'"$i"':1}"'
        [[ $((++i)) -lt ${#1} ]] || break
      done
    fi
  else
    __split_recursive "$1" "$2"
  fi
}

__split_recursive () {
  if [[ "$1" =~ (${sep})(.*$) ]]; then
    eval $2[$((i++))]='"${1%${BASH_REMATCH[1]}${BASH_REMATCH[2]}}"'
    __split_recursive "${BASH_REMATCH[2]}" "$2"
  else
    eval $2[$((i++))]='"$1"'
  fi
}
# ~~~

read_fixed_width_fields () {
    local w
    eval $2='()'
    for w in $1 ; do
	read -r -N $w value || return 1
	eval $2[\${#$2[@]}]='"$(strip "$value")"'
    done
    read -r value
}
