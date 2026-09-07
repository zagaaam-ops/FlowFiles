#!/bin/bash

export CC=/usr/bin/clang-18
export CXX=/usr/bin/clang++-18

export CXXFLAGS="-I/usr/include/c++/13 -I/usr/include/x86_64-linux-gnu/c++/13 -I/usr/include/c++/13/backward"

export LDFLAGS="-L/usr/lib/gcc/x86_64-linux-gnu/13"
