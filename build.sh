#!/bin/bash

# more than 1 arguments
if [ $# -lt 1 ]; then
	echo "usage: ./build.sh <version> [user_id:user_password]"
	exit 1
elif [ ! -z $2 ]; then
	USER_ID=$(echo $2 | cut -d':' -f1)
	USER_PASSWORD=$(echo $2 | cut -d':' -f2)
	echo "id: $USER_ID, pw: $USER_PASSWORD"
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


# load secret file
if [ -f secret.txt ]; then
	source secret.txt
fi
# set variables
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
  ${USER_ID:+--build-arg USER_ID=$USER_ID} \
  ${USER_PASSWORD:+--build-arg USER_PASSWORD=$USER_PASSWORD} \
  -t $IMAGE_NAME:$TAG \
  -t $IMAGE_NAME:latest \
  --push .