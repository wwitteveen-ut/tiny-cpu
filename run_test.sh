#!/bin/bash
# Usage:
#   ./run_test.sh alu              -> compiles test/alu_tb.v + all of src/
#   ./run_test.sh tiny_cpu         -> compiles test/tiny_cpu_tb.v + all of src/
#
# Run from the tiny-cpu/ project root. Output binary lands in build/,
# and only the waveform(s) actually written by this run are reported.

set -e

if [ -z "$1" ]; then
    echo "Usage: $0 <module_name>"
    echo "Example: $0 alu"
    exit 1
fi

MODULE="$1"
TB="test/tb_${MODULE}"

if [ ! -f "$TB" ]; then
    echo "Testbench not found: $TB"
    exit 1
fi

mkdir -p build

OUT="build/${MODULE}_sim"
MARKER="build/.run_marker"

echo "Compiling: src/*.v $TB"
iverilog -g2012 -o "$OUT" src/*.v "$TB"

touch "$MARKER"

echo "Running simulation..."
vvp "$OUT"

echo "Done. Binary: $OUT"

VCDS=$(find build -name '*.vcd' -newer "$MARKER" 2>/dev/null)
rm -f "$MARKER"

if [ -n "$VCDS" ]; then
    echo "Waveform(s) from this run:"
    echo "$VCDS"
    FIRST=$(echo "$VCDS" | head -1)
    echo "Open with: gtkwave $FIRST"
fi