#!/bin/bash

# https://stackoverflow.com/questions/356100/how-to-wait-in-bash-for-several-subprocesses-to-finish-and-return-exit-code-0

set -o monitor

sleep 2 &
sleep 4 && exit 1 &
sleep 6 &

pids=`jobs -p`

checkpids() {
    for pid in $pids; do
        if kill -0 $pid 2>/dev/null; then
            echo $pid is still alive.
        elif wait $pid; then
            echo $pid exited with zero exit status.
        else
            echo $pid exited with non-zero exit status.
        fi
    done
    echo
}

trap checkpids CHLD

wait
