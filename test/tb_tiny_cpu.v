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
            "time=%0t | PC=%h | opcode=%b | rs1=%d | rs2=%d | rd=%d | A=%d | ALUB=%d | imm=%d | ALUop=%b | result=%d | mem_write=%b | write_data=%d",
            $time,
            test_tiny_cpu.pc,
            test_tiny_cpu.opcode,
            test_tiny_cpu.rs1,
            test_tiny_cpu.rs2,
            test_tiny_cpu.rd,
            test_tiny_cpu.read_data_a,
            test_tiny_cpu.alu_b,
            test_tiny_cpu.immediate,
            test_tiny_cpu.alu_op,
            test_tiny_cpu.alu_result,
            test_tiny_cpu.mem_write,
            test_tiny_cpu.read_data_b
        );
    end

    initial begin
        $dumpfile("build/tiny_cpu.vcd");
        $dumpvars(0, tiny_cpu_tb);

        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        // Let the CPU run
        #70;

        #7;

        if (test_tiny_cpu.data_memory_module.memory[3] === 32'd5) begin
            $display("PASS: SW wrote 5 to memory[3]");
        end else begin
            $display("FAIL: SW did not write correctly");
            $display("      got      %d", test_tiny_cpu.data_memory_module.memory[3]);
            $display("      expected 5");
        end

        $finish;
    end

endmodule