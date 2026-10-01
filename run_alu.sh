#!/bin/bash

echo "=============================================="
echo " MINI-SOC LAB 2 - 2-BIT ALU"
echo " VERILATOR SIMULATION"
echo "=============================================="

echo "[1] Cleaning previous ALU build..."
rm -rf obj_dir_alu alu.vcd

echo "[2] Compiling ALU and Testbench..."

verilator --binary -j 0 -Wall \
    alu.v \
    alu_tb.v \
    --top-module alu_tb \
    --Mdir obj_dir_alu \
    --timing \
    -CFLAGS "-std=c++20" \
    --trace

if [ $? -ne 0 ]; then
    echo "Compilation failed"
    exit 1
fi

echo "[3] Running simulation..."

cd obj_dir_alu || {
    echo "obj_dir_alu not found"
    exit 1
}

./Valu_tb

if [ $? -ne 0 ]; then
    echo "Simulation failed"
    exit 1
fi

cd ..

if [ -f obj_dir_alu/alu.vcd ]; then
    cp obj_dir_alu/alu.vcd alu.vcd
fi

echo "[4] Simulation completed."
echo "[5] Waveform: alu.vcd"

if [ -f alu.vcd ]; then
    echo "[6] Opening GTKWave..."
    gtkwave alu.vcd
else
    echo "ERROR: alu.vcd was not generated."
    exit 1
fi
