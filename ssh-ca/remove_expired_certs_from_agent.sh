#!/bin/bash

cert_is_valid() {
    test -s $1 || return 1
    local expiration_date=$(ssh-keygen -L -f $1 | awk '/^ *Valid:/{print $NF}')
    (( $(date -jf "%Y-%m-%dT%H:%M:%S" "${expiration_date}" +%s) > $(date +%s) ))
}

tmp=$(mktemp) || exit 1
trap 'rm -rf "$tmp"; exit' ERR EXIT HUP INT TERM

ssh-add -L | grep "^ssh-ed25519-cert-v01@openssh.com" |
    while read
    do
        echo "$REPLY" > $tmp
        cert_is_valid $tmp || ssh-add -d $tmp
    done


