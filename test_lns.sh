#!/usr/bin/env bash

for directory in */ ; do
    ln -s ~/gazebo/fortress_ws/$directory/ ~/plug_n_play/src/
done
