#!/bin/sh

IMAGE=$(basename $(pwd))

podman build -t $IMAGE .
exec podman run -it --rm -v ./:/app:z -p 8000:8000 $IMAGE
