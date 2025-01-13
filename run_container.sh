#!/bin/bash
# create by c4fiber<qudcjf153@gmail.com>

# load secret file
if [ -f secret.txt ]; then
	source secret.txt
fi

# Does container already exist?
EXISTING_CONTAINER=$(docker ps -a --filter "name=^${CONTAINER_NAME}$" --format "{{.Names}}")

if [ "$EXISTING_CONTAINER" = "$CONTAINER_NAME" ]; then
  echo "Container \"lets-practice-linux-cli\" already Exists "
  docker start -ai "$CONTAINER_NAME"
else
  echo "Create new Container: $CONTAINER_NAME"
  docker run --name "$CONTAINER_NAME" -it "$IMAGE_NAME" /
fi
