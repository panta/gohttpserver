#!/bin/bash

: ${DIRECTORY:="$(pwd)/public"}
: ${CONTAINER_PORT:="8000"}
: ${PORT:="8000"}

mkdir -p ${DIRECTORY}
echo "Serving ${DIRECTORY} ..."

# --auth-type http --auth-http username:password
docker run --rm -it --name gohttpserver \
	-v "${DIRECTORY}":/app/public \
	-p ${PORT}:${CONTAINER_PORT} \
	panta/gohttpserver
