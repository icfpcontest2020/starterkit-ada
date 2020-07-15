#!/bin/sh

cd app
mkdir -p obj
gprbuild -P icfp.gpr
