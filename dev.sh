#!/bin/sh

set -e

NAME=$(basename $(pwd))

podman build -t $NAME --target cordova-app .
exec podman run -it --rm \
    -v ./package.json:/app/package.json \
    -v ./package-lock.json:/app/package-lock.json \
    -v ./config.xml:/app/config.xml \
    -v ./www:/app/www \
    -p 8000:8000 \
    --hostname $NAME --name $NAME $NAME bash -c 'npm run dev & bash'
