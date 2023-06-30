#!/usr/bin/env bash

set -v
set -x
set -e

#build
TMPDIR=$(mktemp --directory)
docker buildx build -o $TMPDIR .

# deploy
cd $TMPDIR && tar cz alo.lv2 | base64 | curl -F 'package=@-' http://192.168.51.1/sdk/install
