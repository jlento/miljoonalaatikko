#!/bin/sh

# Justify markdown using emacs

usage="
Usage: bash fmt.sh file.md [file.md] ...

Requires that you have emacs and markdown-mode.el installed.
"

# The directory where this script and elisp code are
cdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Try to find the emacs markdown-mode package from the usual place
: ${md:=$(find ~/.emacs.d -name 'markdown-mode.el' -or -name 'markdown-mode.elc' | tail -1)}
: ${md:?Did not find markdown-mode.el}

# Main
for file in "$@"; do
    emacs -batch -L $(dirname $md) -l ${cdir}/fmt.el "$file" \
          -f markdown-justify-buffer \
          -f save-buffer
done
