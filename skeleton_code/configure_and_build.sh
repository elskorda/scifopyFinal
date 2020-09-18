#!/bin/sh

export PATH=./bin:$PATH
export PYTHONPATH=./bin:$PYTHONPATH

python3 configure_and_build.py
