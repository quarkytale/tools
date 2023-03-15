#!/usr/bin/env bash

echo "enter command to run "
read command

for directory in */; do
    echo "$directory"
    cd $directory
    $command
    echo " "
    cd ../
done


