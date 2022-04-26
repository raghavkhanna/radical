#! /bin/bash

RADICAL_DIR=$(realpath "$(dirname "$0")/..")
xhost +local:docker
docker run -it --rm --privileged \
-v /dev:/dev \
-v "/run/user/1000/gdm/Xauthority:$HOME/.Xauthority:rw" \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY="${DISPLAY}" \
-v "$RADICAL_DIR":/home/radical \
-v /dev:/dev \
--device-cgroup-rule "c 81:* rmw" \
--device-cgroup-rule "c 189:* rmw" \
radical bash