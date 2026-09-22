`timescale 1ns/1ps

module tiny_cpu_tb;

    logic clk;
    logic reset;

    tiny_cpu test_tiny_cpu (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("build/tiny_cpu.vcd");
        $dumpvars(0, tiny_cpu_tb);

        clk = 0;
        reset = 1;

        #7;
        reset = 0;

        // Let the CPU run
        #40;

        $finish;
    end

endmodule