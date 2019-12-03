#!/bin/bash

original_link_command="$@"

$original_link_command
guessed_exe=$(ls -tr | tail -n 1)
rpath_options=$(ldd $guessed_exe |
                    sed -nr 's|.*=> *(/.*)/.*|-Wl,-rpath=\1|p' |
                    sort -u | tr '\n' ' ')
$original_link_command $rpath_options
