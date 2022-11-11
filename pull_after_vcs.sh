#!/usr/bin/env bash

for directory in */ ; do
    echo "$directory"
    cd $directory && git pull
    cd ../
done
