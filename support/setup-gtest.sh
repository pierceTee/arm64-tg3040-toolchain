#!/bin/sh
cd /usr/src/gtest
cmake -DCMAKE_C_COMPILER="${CROSS_COMPILE}gcc" -DCMAKE_CXX_COMPILER="${CROSS_COMPILE}g++" CMakeLists.txt
make
cp /usr/src/gtest/lib/*.a /usr/lib
ln -s /usr/lib/libgtest.a /usr/local/lib/libgtest.a
ln -s /usr/lib/libgtest_main.a /usr/local/lib/libgtest_main.a