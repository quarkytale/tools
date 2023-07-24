#!/usr/bin/env bash
#
# Typical usage: ./join.bash <image_name>
#

IMG=$(basename $1)
# Use quotes if image name contains symbols like a forward slash /, but then
# cannot use `basename`.

xhost +
containerid=$(docker ps -aqf "ancestor=${IMG}")
docker exec --privileged -e DISPLAY=${DISPLAY} -e LINES=`tput lines` -it ${containerid} bash
xhost -
