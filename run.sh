#!/bin/sh

cd app/obj
./icfp "$@" || echo "run error code: $?"
