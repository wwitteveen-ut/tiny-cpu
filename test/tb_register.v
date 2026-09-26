`timescale 1ns/1ps

module register_tb;

    logic   clk;
    logic [31:0] d;
    logic [31:0] q;

    register test_register (
        .clk(clk),
        .d(d),
        .q(q)
    );

    initial begin
        $dumpfile("build/register.vcd");
        $dumpvars(0, register_tb);

        clk = 0;
        d = 10;

        #10;
        d = 20;

        #10;
        d = 30;

        #10;
        $finish;
    end

    always #5 clk = ~clk;

endmodule