#!/bin/bash

echo "=============================================="
echo " MINI-SOC INTEGRATION LAB"
echo " COUNTER + ALU + MUX"
echo "=============================================="

echo "[1] Cleaning previous build..."

rm -rf obj_dir_mini_soc
rm -f mini_soc.vcd

echo "[2] Compiling..."

verilator --binary \
    -j 0 \
    -Wall \
    -Wno-DECLFILENAME \
    --timing \
    --trace \
    --Mdir obj_dir_mini_soc \
    counter.v \
    alu.v \
    mux2x1.v \
    mini_soc.v \
    mini_soc_tb.v \
    --top-module mini_soc_tb \
    -CFLAGS "-std=c++20"

if [ $? -ne 0 ]; then
    echo "Compilation FAILED."
    exit 1
fi

echo "[3] Running simulation..."

./obj_dir_mini_soc/Vmini_soc_tb

if [ $? -ne 0 ]; then
    echo "Simulation FAILED."
    exit 1
fi

echo "[4] Checking VCD..."

if [ -f mini_soc.vcd ]; then
    echo "VCD created successfully: mini_soc.vcd"
else
    echo "ERROR: mini_soc.vcd was not created."
    exit 1
fi

echo "[5] Opening GTKWave..."

gtkwave mini_soc.vcd
