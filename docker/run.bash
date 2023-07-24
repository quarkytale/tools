#!/usr/bin/env bash

# Runs a docker container with the image created by build.bash
ROCKER_ARGS="--devices /dev/dri/ --dev-helpers --x11 --user --git --home"

IMG_NAME=$1

# Replace `:` with `_` to comply with docker container naming
# And append `_runtime`
CONTAINER_NAME="$(tr ':' '_' <<< "$IMG_NAME")_runtime"
ROCKER_ARGS="${ROCKER_ARGS} --name $CONTAINER_NAME"
echo "Using image <$IMG_NAME> to start container <$CONTAINER_NAME>"

rocker ${ROCKER_ARGS} $IMG_NAME 
