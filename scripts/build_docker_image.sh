#! /bin/bash

RADICAL_DIR=$(realpath "$(dirname "$0")/..")

docker build "$RADICAL_DIR" -t radical 