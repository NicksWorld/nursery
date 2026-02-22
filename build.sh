#!/bin/sh

if [ ! -f ./haunt/pre-inst-env ]; then
    cd haunt
    ./bootstrap
    ./configure
    make
    cd ..
fi

# Build site
./haunt/pre-inst-env haunt build
