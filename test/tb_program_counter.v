`timescale 1ns/1ps

module program_counter_tb;

    logic clk;
    logic reset;

    logic [31:0] next_pc;
    logic [31:0] pc;

    program_counter test_program_counter (
        .clk(clk),
        .reset(reset),
        .next_pc(next_pc),
        .pc(pc)
    );

    initial begin
        $dumpfile("build/program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        clk = 0;
        reset = 1;
        #10;
        reset = 0;


        #50;

        $finish;
    end
    
    always #5 clk = ~clk;

    always_comb begin
        next_pc = pc + 4;
    end

endmodule

