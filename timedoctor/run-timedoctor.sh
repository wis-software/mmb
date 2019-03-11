#!/bin/bash

docker run --rm -it --net=host -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix timedoctor
