#!/bin/bash

meson build
ninja -C build

rm build/game.so

valac sandbox/*.vala --directory=build --vapidir=build --pkg=virgil --pkg=gmodule-2.0 --ccode --header=build/sandbox.h
cc -shared -Ibuild/ -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -w -O3 -fPIC -pthread build/sandbox/*.c -lm -lgmodule-2.0 -lglib-2.0 -o build/game.so

rm build/sandbox.h

build/virgil --test-build
