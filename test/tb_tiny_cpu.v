`timescale 1ns/1ps

module tiny_cpu_tb;

    logic clk;
    logic reset;

    tiny_cpu test_tiny_cpu (
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    always @(posedge clk) begin
        $display(
            "time=%0t | PC=%h | instr=%h | opcode=%b | rs1=%d | rs2=%d | rd=%d | A=%d | B=%d | imm=%d | imm_ext=%d | ALUop=%b | result=%d",
            $time,
            test_tiny_cpu.pc,
            test_tiny_cpu.instruction,
            test_tiny_cpu.opcode,
            test_tiny_cpu.rs1,
            test_tiny_cpu.rs2,
            test_tiny_cpu.rd,
            test_tiny_cpu.read_data_a,
            test_tiny_cpu.alu_b,
            test_tiny_cpu.immediate,
            test_tiny_cpu.immediate_extended,
            test_tiny_cpu.alu_op,
            test_tiny_cpu.alu_result
        );
    end

    initial begin
        $dumpfile("build/tiny_cpu.vcd");
        $dumpvars(0, tiny_cpu_tb);

        clk = 0;
        reset = 1;

        #7;
        reset = 0;

        // Let the CPU run
        #80;

        $finish;
    end

endmodule