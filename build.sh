#!/bin/bash

ninja -C build

# Copy sprites to build directory
cp -r data/sprites build/

cd build

./virgil