`timescale 1ns/1ps

// Simple 2-bit ALU
// sel = 0 -> ADD
// sel = 1 -> SUB

module alu (
    input  [1:0] a,
    input  [1:0] b,
    input        sel,
    output reg [1:0] result
);

    always @(*) begin
        case (sel)
            1'b0: result = a + b;
            1'b1: result = a - b;
            default: result = 2'b00;
        endcase
    end

endmodule
