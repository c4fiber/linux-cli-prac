#!/bin/bash
# create by c4fiber<qudcjf153@gmail.com>

CONTAINER_NAME=lets-practice-linux-cli
IMAGE_NAME=hayanbada/linux-cli-prac

# Does container already exist?
EXISTING_CONTAINER=$(docker ps -a --filter "name=^${CONTAINER_NAME}$" --format "{{.Names}}")

if [ "$EXISTING_CONTAINER" = "$CONTAINER_NAME" ]; then
  echo "Container \"$CONTAINER_NAME\" already Exists "
  docker start -ai "$CONTAINER_NAME"
else
  echo "Create new Container: $CONTAINER_NAME"
  docker run --name "$CONTAINER_NAME" -it "$IMAGE_NAME" /
fi
