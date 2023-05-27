#!/usr/bin/env bash

echo "enter command to run "
read command

echo "enter all directories to run $command in"
echo "relative paths separated by [space] or * for all "
read line
if [ "$line" != "*" ] 
then
  list=(${line})
  for directory in ${list[@]}; do
    echo "$directory"
    cd $directory
    $command
    echo " "
    cd ../
  done
else
  for directory in */; do
    echo "$directory"
    cd $directory
    $command
    echo " "
    cd ../
  done
fi
