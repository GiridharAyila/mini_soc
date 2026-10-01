#!/bin/bash

echo "=============================================="
echo " MINI-SOC LAB 1 - 4-BIT COUNTER IP"
echo " VERILATOR SIMULATION"
echo "=============================================="

echo "[1] Cleaning previous build..."
rm -rf obj_dir counter.vcd

echo "[2] Compiling RTL and Testbench..."

verilator --binary -j 0 -Wall \
    counter.v \
    counter_tb.v \
    --top-module counter_tb \
    --timing \
    -CFLAGS "-std=c++20" \
    --trace

if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

echo "[3] Running simulation..."

cd obj_dir || {
    echo "obj_dir not found"
    exit 1
}

./Vcounter_tb

if [ $? -ne 0 ]; then
    echo "Simulation failed"
    exit 1
fi

cd ..

# Simulator creates the VCD inside obj_dir
if [ -f obj_dir/counter.vcd ]; then
    cp obj_dir/counter.vcd counter.vcd
fi

echo "[4] Simulation completed."
echo "[5] Waveform: counter.vcd"

if [ -f counter.vcd ]; then
    echo "[6] Opening GTKWave..."
    gtkwave counter.vcd
else
    echo "ERROR: counter.vcd was not generated."
    exit 1
fi
