#!/bin/bash


# List files in given url recursively
wfind () {
    local foo href
    while IFS='"' read foo href
    do
        case "$href" in
            '..') :; ;;
            */)   wfind "${1%/}/$href"; ;;
            *)    echo "${1%/}/$href"; ;;
        esac
    done < <(xmllint --html --xpath '//td/a/@href' <(curl -s ${1%/}/))
}


# Download files in given url recursively into sub-folders. Basically, a
# poor man's replacement for `wget -r` in Mac OS using curl :)

rwget () {
    local protocol foo host path
    while IFS='/' read protocol foo host path
    do
        curl --create-dirs -s -o "$path" "${protocol}//${host}/$path"
    done < <(wfind "$1")
}
