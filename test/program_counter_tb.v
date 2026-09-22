`timescale 1ns/1ps

module program_counter_tb;

    logic clk;

    logic [31:0] next_pc;
    logic [31:0] pc;

    program_counter test_program_counter (
        .clk(clk),
        .next_pc(next_pc),
        .pc(pc)
    );

    initial begin
        $dumpfile("build/program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        next_pc = 0;

        #2;
        next_pc = 4;

        #10;
        next_pc = 8;

        #10;
        next_pc = 12;

        #10;
        next_pc = 16;

        #10;

        $finish;
    end
    
    always #5 clk = ~clk;

endmodule

