#!/bin/bash
# create by c4fiber<qudcjf153@gmail.com>

CONTAINER_NAME=lets-practice-linux-cli
IMAGE_NAME=hayanbada/linux-cli-prac
VOLUME=linux-cli-prac_data

# create volume if it is not exist
docker volume inspect linux-cli-prac_data > /dev/null
if [ $? -eq 0 ]; then
  echo "volume: linux-cli-prac_data already exist"
else
  echo "create new volume: $VOLUME"
  docker volume create "$VOLUME" > /dev/null
fi

# Does container already exist?
EXISTING_CONTAINER=$(docker ps -a --filter "name=^${CONTAINER_NAME}$" --format "{{.Names}}")
if [ "$EXISTING_CONTAINER" = "$CONTAINER_NAME" ]; then
  echo "container: $CONTAINER_NAME already exists "
  docker start -ai "$CONTAINER_NAME"
else
  echo "create new container: $CONTAINER_NAME"
  docker run --name "$CONTAINER_NAME" -it -v $VOLUME:/home/myuser "$IMAGE_NAME" /bin/bash
fi
