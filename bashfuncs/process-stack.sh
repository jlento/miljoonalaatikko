#!/bin/bash

psstack1 () {
    while [ -n "$1" ]
    do
        echo $1
        set -- $(ps -o ppid= $1)
    done | xargs ps -f -p | column -t
}

psstack2 () {
    test -n "$1" && ps -o user=,pid=,ppid=,comm= $1 && psstack2 $(ps -o ppid= $1)
} > >(column -t)
