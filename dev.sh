#!/bin/sh

set -e

NAME=$(basename $(pwd))

podman build -t $NAME --target env .
exec podman run -it --rm -v ./cordova.config.xml:/app/config.xml:ro -v ./www/:/app/www:z -p 8000:8000 --hostname $NAME --name $NAME $NAME bash -c 'yarnpkg dev & bash'
