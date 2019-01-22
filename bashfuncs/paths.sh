#!/bin/bash

whereami () {
    pushd .
    cd $(dirname "${BASH_SOURCE[1]}")
    pwd
    popd
}
