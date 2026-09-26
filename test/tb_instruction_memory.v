`timescale 1ns/1ps

module instruction_memory_tb;

    logic [31:0] pc;
    logic [31:0] instruction;

    instruction_memory test_instruction_memory (
        .pc(pc),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("build/instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        pc = 0;

        #10;
        pc = 4;

        #10;
        pc = 8;

        #10;
        pc = 12;

        #10;

        $finish;
    end

endmodule
