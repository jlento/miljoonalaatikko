#!/bin/bash

# Two functions to "parse" and edit config-build.xml in EC-Earth3 (humor)
#
# Usage:
#   sed -n '/name="voima-intel"/,/\/Platform/p' < config-build.xml | pp | less
#   ECEARTH_SRC_DIR=XXXXXXXXXXXXXXXX modify < config-build.xml | less

# Read XML elements
#
read_dom () {
    local IFS=\>
    read -d \< ENTITY CONTENT
}

# Extract parameter-value pairs from XML and print them in bash-friendly format
#     PARAMETER=VALUE
#
pp () {
    while read_dom; do
	[[ -z "$ENTITY" ]] && continue
	local parameter_regex='Parameter.* name *= *"(.*)".*'
	[[ "$ENTITY" =~ $parameter_regex ]] && local p="${BASH_REMATCH[1]}"
	[[ "$ENTITY" = "Value" ]] && echo "$p=$(printf %q "$CONTENT")"
    done
}

# Modify <Value>CONTENT</Value>, where CONTENT is taken from the environment
# variable that has the same name as the enclosing Parameter tag. If environment
# variable is unset, leave CONTENT as is.
#
modify () {
    while read_dom; do
	[[ -z "$ENTITY" ]] && continue
	local parameter_regex='Parameter.* name *= *"(.*)".*'
	[[ "$ENTITY" =~ $parameter_regex ]] && local p="${BASH_REMATCH[1]}"
	[[ "$ENTITY" = "Value" ]] && CONTENT="${!p-$CONTENT}"
	printf "%s" "<$ENTITY>$CONTENT"
    done
}

read_tag () {
    local IFS=\> entity ret
    read -d \< entity CONTENT
    ret=$?
    [[ "$entity" =~ ^(/?)([^ ]+)\ *(.*) ]]
    [ -z "${BASH_REMATCH[1]}" ] && CLOSING=false || CLOSING=true
    TAG=${BASH_REMATCH[2]}
    ATTR=${BASH_REMATCH[3]}
    return $ret
}

pt () {
    unset TAGS ATTRIBUTES CONTENTS CHILDREN PARENT
    local -i i free=0 current=0
    local tag attributes
    printf "%5s" {1..7} ; printf "\n"
    while read_tag; do
        [ -z "$TAG" ] && continue
        if $CLOSING; then
            current=${PARENT[$current]}
        else
            CHILDREN[$current]+=" $free"
            PARENT[$free]=$current
            current=$free
            free=$(( ++free ))
            TAGS[$current]="$TAG"
            ATTRIBUTES[$current]="$ATTR"
        fi
        if [ -n "$CONTENT" ]; then
            CHILDREN[$current]+=" $free"
            PARENT[$free]=$current
            CONTENTS[$free]="$CONTENT"
            free=$(( ++free ))
        fi
    done
    for (( i = 0; i < free; i++ )); do
        echo $i:${TAGS[$i]}:${ATTRIBUTES[$i]}:${CONTENTS[$i]}:${PARENT[$i]}:${CHILDREN[$i]}
    done
}
