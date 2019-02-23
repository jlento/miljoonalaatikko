#!/bin/bash

# The directory where this script and other utils are
cdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

d=$(dirname "$1")

urls=${1##*/}
: ${1:?Give a file containing a list of urls}


# Fetch, clean and convert

while read url; do
    echo "Processing ${url##*/}"
    node utils/content.js '.journal-content-article' "$url" | pandoc --reference-links --atx-headers -f html -t markdown_phpextra-auto_identifiers-markdown_attribute-header_attributes-link_attributes+shortcut_reference_links -o ${d}/${url##*/}.md
done < "$1"


# Justify paragraphs

# bash utils/fmt.sh ${d}/*.md
