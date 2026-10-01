`timescale 1ns/1ps

module alu_tb;

    reg [1:0] a;
    reg [1:0] b;
    reg       sel;

    wire [1:0] result;

    // Instantiate ALU
    alu dut (
        .a(a),
        .b(b),
        .sel(sel),
        .result(result)
    );

    initial begin

        // Waveform
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb);

        // -----------------------------------------
        // ADD: 1 + 2 = 3
        // -----------------------------------------
        a = 2'b01;
        b = 2'b10;
        sel = 1'b0;

        #10;

        $display("ADD");
        $display("Time=%0t | a=%b (%0d) | b=%b (%0d) | sel=%b | result=%b (%0d)",
                 $time, a, a, b, b, sel, result, result);

        // -----------------------------------------
        // ADD: 2 + 2 = 0 (2-bit overflow)
        // -----------------------------------------
        a = 2'b10;
        b = 2'b10;
        sel = 1'b0;

        #10;

        $display("ADD WITH 2-BIT WRAPAROUND");
        $display("Time=%0t | a=%b (%0d) | b=%b (%0d) | sel=%b | result=%b (%0d)",
                 $time, a, a, b, b, sel, result, result);

        // -----------------------------------------
        // SUB: 3 - 1 = 2
        // -----------------------------------------
        a = 2'b11;
        b = 2'b01;
        sel = 1'b1;

        #10;

        $display("SUB");
        $display("Time=%0t | a=%b (%0d) | b=%b (%0d) | sel=%b | result=%b (%0d)",
                 $time, a, a, b, b, sel, result, result);

        // -----------------------------------------
        // SUB: 1 - 2 = 3 (2-bit wraparound)
        // -----------------------------------------
        a = 2'b01;
        b = 2'b10;
        sel = 1'b1;

        #10;

        $display("SUB WITH 2-BIT WRAPAROUND");
        $display("Time=%0t | a=%b (%0d) | b=%b (%0d) | sel=%b | result=%b (%0d)",
                 $time, a, a, b, b, sel, result, result);

        // -----------------------------------------
        // Finish
        // -----------------------------------------
        $finish;

    end

endmodule
