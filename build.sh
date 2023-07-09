#!/bin/bash

CLEAN_BUILD=${1:-"null"}
BUILD_OUTPUT=""

if [ "$CLEAN_BUILD" = "clean" ]; then
    if [ -d "build" ]; then
        rm -r build
    fi

    BUILD_OUTPUT=$(meson setup build)

    if [ $? != 0 ]; then
        echo "$BUILD_OUTPUT"
    fi
fi

BUILD_OUTPUT=$(meson compile -C build)

if [ $? = 0 ]; then
    # Clean up build
    rm build/game.h build/game.vapi

    build/virgil --build-info

    build/virgil --directory=build --show-fps
else
    echo "$BUILD_OUTPUT"
fi
