`timescale 1ns/1ps

module counter_tb;

    reg clk;
    reg rst;
    wire [3:0] count;

    // Instantiate counter
    counter dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initial values
        clk = 0;
        rst = 1;

        // Waveform generation
        $dumpfile("counter.vcd");
        $dumpvars(0, counter_tb);

        // -----------------------------------------
        // Reset active
        // -----------------------------------------
        #2;

        $display("RESET ACTIVE");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // Wait for a clock edge while reset is active
        #8;

        $display("AFTER RESET CLOCK EDGE");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // -----------------------------------------
        // Release reset
        // -----------------------------------------
        rst = 0;

        $display("RESET RELEASED");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // -----------------------------------------
        // Count for 100 ns
        // -----------------------------------------
        #100;

        $display("COUNTER AFTER COUNTING");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // -----------------------------------------
        // Assert reset again
        // -----------------------------------------
        rst = 1;

        $display("RESET ASSERTED AGAIN");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // Reset takes effect at next rising edge
        #10;

        $display("AFTER SECOND RESET CLOCK EDGE");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        // -----------------------------------------
        // Release reset again
        // -----------------------------------------
        rst = 0;

        #20;

        $display("FINAL COUNT");
        $display("Time=%0t | clk=%b | rst=%b | count=%b (%0d)",
                 $time, clk, rst, count, count);

        $finish;

    end

endmodule
