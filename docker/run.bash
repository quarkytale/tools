#!/usr/bin/env bash

# Runs a docker container with the image created by build.bash
# Requires:
#   docker
#   nvidia-docker
#   an X server
#   rocker
# Recommended:
#   A joystick mounted to /dev/input/js0 or /dev/input/js1
############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Runs a docker container with the image created by build.bash."
   echo
   echo "Syntax: scriptTemplate [-c|s|t|h]"
   echo "options:"
   echo "c     Add cuda library support."
   echo "s     Create an image with novnc for use with cloudsim."
   echo "t     Create a test image for use with CI pipelines."
   echo "v     With host system home folder mounted."
   echo "h     Print this help message and exit."
   echo
}


CUDA=""
ROCKER_ARGS="--devices /dev/dri/ --dev-helpers --x11 --user --git"

while getopts ":cstvh" option; do
  case $option in
    c) # enable cuda library support 
      CUDA="--cuda";;
    s) # Build cloudsim image
      ROCKER_ARGS="${ROCKER_ARGS} --novnc --turbovnc --user-override-name=developer";;
    t) # Build test image for Continuous Integration 
      echo "Building CI image"
      ROCKER_ARGS="${ROCKER_ARGS} --user-override-name=developer";;
    v) # Build test image with host system home folder mount 
      echo "Building image with home mount"
      ROCKER_ARGS="${ROCKER_ARGS} --home";;
    h) # print this help message and exit
      Help
      exit;; 
  esac
done

IMG_NAME=${@:$OPTIND:1}

# Replace `:` with `_` to comply with docker container naming
# And append `_runtime`
CONTAINER_NAME="$(tr ':' '_' <<< "$IMG_NAME")_runtime"
ROCKER_ARGS="${ROCKER_ARGS} --name $CONTAINER_NAME"
echo "Using image <$IMG_NAME> to start container <$CONTAINER_NAME>"

rocker ${CUDA} ${ROCKER_ARGS} $IMG_NAME 
