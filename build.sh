#!/bin/bash

# Only 1 arguments: version number
if [ $# -ne 1 ]; then
	echo "usage: ./build.sh <version>"
	exit 1
fi

# Is it demical number?
if ! [[ $1 =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
	echo "Error: Argument must be a demical number"
	exit 1
fi

# Is Dockerfile exist?
if [ ! -f $DOCKERFILE ]; then
        echo "Error: Dockerfile is not exist"
        exit 1
fi

# Variables
REPOSITORY=hayanbada/linux-cli-prac
TAG=$1
DOCKERFILE=./Dockerfile

# Check if version is already exist
DOES_EXIST=$(docker image ls -a | grep $REPOSITORY | awk '{print $2}' | grep $TAG | wc -l)
if [ $DOES_EXIST -gt 0 ]; then
	echo "Error: version already exist"
	exit 1
fi

# NOTE
# For if condition test
#echo "start build (fake)"
#exit 0

# Build image and replace latest image
echo "====== start build ======"

if [ $(docker image ls $REPOSITORY:latest | wc -l) -ne 0 ]; then
	docker image rm $REPOSITORY:latest
fi

docker buildx build --progress=plain --platform linux/amd64,linux/arm64 -t $REPOSITORY:$TAG -t $REPOSITORY:latest --push .
