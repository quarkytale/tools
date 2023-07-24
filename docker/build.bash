#!/usr/bin/env bash

# Builds a Docker image.
username=$(echo $USER)
image_name=$(basename $1)

if [ $# -lt 1 ]
then
    echo "Usage: $0 <name of Dockerfile>"
    exit 1
fi

image_plus_tag=$image_name:$(export LC_ALL=C; date +%Y_%m_%d_%H%M)
docker build --rm -t $image_plus_tag --build-arg username=$username -f "${1}" ../docker/ && \
docker tag $image_plus_tag $image_name && \
echo "Built $image_plus_tag and tagged as $image_name"
echo "To run:"
echo "./run.bash $image_name"
