`timescale 1ns/1ps

module mini_soc_tb;

    reg clk;
    reg rst;
    reg alu_sel;
    reg mux_sel;

    wire [1:0] soc_out;

    // DUT
    mini_soc dut (
        .clk     (clk),
        .rst     (rst),
        .alu_sel (alu_sel),
        .mux_sel (mux_sel),
        .soc_out (soc_out)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("mini_soc.vcd");
        $dumpvars(0, mini_soc_tb);

        clk     = 1'b0;
        rst     = 1'b1;
        alu_sel = 1'b0;
        mux_sel = 1'b0;

        $display("==============================================");
        $display(" MINI-SOC INTEGRATION LAB");
        $display(" Counter + ALU + MUX");
        $display("==============================================");

        // Reset
        #10;
        rst = 1'b0;

        $display("[%0t ns] Reset released", $time);

        // Counter selected by MUX
        #20;
        $display("[%0t ns] MUX selects COUNTER", $time);

        // ALU subtraction
        #10;
        alu_sel = 1'b1;
        $display("[%0t ns] ALU = SUBTRACT", $time);

        // Select ALU output
        #10;
        mux_sel = 1'b1;
        $display("[%0t ns] MUX selects ALU", $time);

        // ALU addition
        #20;
        alu_sel = 1'b0;
        $display("[%0t ns] ALU = ADD", $time);

        // Return to counter
        #20;
        mux_sel = 1'b0;
        $display("[%0t ns] MUX selects COUNTER", $time);

        #20;

        $display("==============================================");
        $display(" Final soc_out = %b", soc_out);
        $display(" Simulation completed");
        $display("==============================================");

        $finish;
    end

    // Explicit observation instead of $monitor
    // This avoids the SYNCASYNCNET warning we encountered earlier.
    always @(posedge clk) begin
        #1;
        $display(
            "[%0t ns] count=%b alu_out=%b alu_sel=%b mux_sel=%b soc_out=%b",
            $time,
            dut.count,
            dut.alu_out,
            alu_sel,
            mux_sel,
            soc_out
        );
    end

endmodule
