#!/bin/bash

# NOTE: For when I move away from meson

echo "!!! PLEASE DO NOT USE !!!"
exit 1

# Build virgil runtime
valac src/*.vala src/*/*.vala --directory=build-aux --vapidir=vapi --pkg=raylib --pkg=gmodule-2.0 --vapi=virgil.vapi --ccode --header=build-aux/virgil.h
cc -Ibuild-aux/ -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include -I/usr/include/sysprof-4 -w -O3 -fPIC -pthread build-aux/src/*.c build-aux/src/*/*.c -lm -lraylib -lgmodule-2.0 -lgobject-2.0 -lglib-2.0 -o build-aux/virgil

rm -r build-aux/src

cd build-aux

./virgil

# FIXME: undefined symbol: virgil_component_ref
