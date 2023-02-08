#!/bin/bash

# NOTE: For when I move away from meson

# Build virgil runtime
valac src/*.vala src/*/*.vala --directory=build-aux --vapidir=vapi --pkg=raylib --pkg=gmodule-2.0 --vapi=virgil.vapi --ccode --header=build-aux/virgil.h
cc -Ibuild-aux/ -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -w -O3 -fPIC -pthread build-aux/src/*.c build-aux/src/*/*.c -lm -lraylib -lgmodule-2.0 -lgobject-2.0 -lglib-2.0 -o build-aux/virgil

rm -r build-aux/src

valac sandbox/*.vala --directory=build-aux --vapidir=build-aux --pkg=virgil --pkg=gmodule-2.0 --ccode --header=build-aux/sandbox.h
cc -shared -Ibuild-aux/ -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -w -O3 -fPIC -pthread build-aux/sandbox/*.c -lm -lgmodule-2.0 -lglib-2.0 -o build-aux/game.so

rm -r build-aux/sandbox

rm build-aux/sandbox.h build-aux/virgil.h build-aux/virgil.vapi

cd build-aux

./virgil

# FIXME: undefined symbol: virgil_component_ref
