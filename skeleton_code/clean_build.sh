#!/bin/sh

BUILD_DIR=./build
BIN_DIR=./bin

if [ -d "$BUILD_DIR" ]; then
    printf '%s\n' "Removing ($BUILD_DIR)"
    rm -rf "$BUILD_DIR"
fi

if [ -d "$BIN_DIR" ]; then
    printf '%s\n' "Removing ($BIN_DIR)"
    rm -rf "$BIN_DIR"
fi