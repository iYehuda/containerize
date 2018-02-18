#!/bin/sh

set -e

PATH='/bin:/usr/bin:/usr/local/bin'
CONTAINER_NAME=$(cat /dev/urandom | tr -dc 'a-f0-9' | fold -w64 | head -n 1)

# check whether TIMEOUT is an integer
if [[ $TIMEOUT =~ ^[0-9]+$ ]]; then
  echo "You got $TIMEOUT seconds. GO!"
  (sleep $TIMEOUT && echo -e "${TIMEOUT_MESSAGE}\r" && docker rm -fv ${CONTAINER_NAME} > /dev/null) &
fi
docker run --name $CONTAINER_NAME "$@"
