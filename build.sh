#!/bin/bash

# more than 1 arguments
if [ $# -lt 1 ]; then
	echo "usage: ./build.sh <version> [user_id:user_password]"
	exit 1
fi

# Is it demical number?
if ! [[ $1 =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
	echo "Error: Argument must be a demical number"
	exit 1
fi

# Is Dockerfile exist?
if [ ! -f ./Dockerfile ]; then
	echo "Error: Dockerfile is not exist"
	exit 1
fi

# Variables
IMAGE_NAME=hayanbada/linux-cli-prac
TAG=$1

# Check if version is already exist
docker image ls -a | grep $IMAGE_NAME | awk '{print $2}' | grep $TAG > /dev/null
if [ $? -eq 0 ]; then
	echo "Error: version already exist"
	exit 1
fi

# NOTE: temporary code for checking if conditions
#echo "start build (fake)"
#exit 0

# Build image and replace latest image
echo "====== start build ======"
docker buildx build --progress=plain \
  --platform linux/amd64,linux/arm64 \
  -t $IMAGE_NAME:$TAG \
  -t $IMAGE_NAME:latest \
  --push .