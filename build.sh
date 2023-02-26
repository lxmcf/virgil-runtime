#!/bin/bash

meson setup build
meson compile -C build

# Clean up build
rm build/game.h build/game.vapi

build/virgil --test-build
