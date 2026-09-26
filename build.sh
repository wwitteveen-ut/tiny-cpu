#!/bin/bash

set -e

echo "Compiling tiny CPU..."

iverilog -g2012 -o build/tiny_cpu_sim \
    src/*.v \
    test/tiny_cpu_tb.v

echo "Build successful!"
echo "Running simulation..."

vvp build/tiny_cpu_sim

echo "Done!"