#!/bin/bash
#
# Created by c4fiber<qudcjf153@gmail.com>
# Shell script for build docker image and push to docker hub easily
#
# Usage: ./build.sh <tag_or_version>

if [ $# -lt 1 ]; then
	echo "usage: ./build.sh <version> [user_id:user_password]"
	exit 1
fi

if ! [[ $1 =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
	echo "Error: Argument must be a demical number"
	exit 1
fi

if [ ! -f ./Dockerfile ]; then
	echo "Error: Dockerfile is not exist"
	exit 1
fi

# variables for build docker image
IMAGE_NAME=hayanbada/linux-cli-prac
TAG=$1

# check if same docker image:tag already exists
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
