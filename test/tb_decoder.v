`timescale 1ns/1ps

module decoder_tb;

    logic [31:0] instruction;

    logic [3:0]  opcode;
    logic [2:0]  rd;
    logic [2:0]  rs1;
    logic [2:0]  rs2;
    logic [21:0] immediate;

    int pass_count = 0;
    int fail_count = 0;

    decoder dut (
        .instruction (instruction),
        .opcode      (opcode),
        .rd          (rd),
        .rs1         (rs1),
        .rs2         (rs2),
        .immediate   (immediate)
    );

    initial begin
        // ---- R-type: ADD (opcode 0000) ----
        // rd=3'b010, rs1=3'b011, rs2=3'b100, rest of bits don't matter (unused for R-type)
        instruction = {4'b0000, 3'b010, 3'b011, 3'b100, 19'b0};
        check("ADD", 4'b0000, 3'b010, 3'b011, 3'b100, 22'b0);

        // ---- R-type: SUB (opcode 0001) ----
        instruction = {4'b0001, 3'b001, 3'b010, 3'b011, 19'b0};
        check("SUB", 4'b0001, 3'b001, 3'b010, 3'b011, 22'b0);

        // ---- R-type: AND (opcode 0010) ----
        instruction = {4'b0010, 3'b111, 3'b110, 3'b101, 19'b0};
        check("AND", 4'b0010, 3'b111, 3'b110, 3'b101, 22'b0);

        // ---- R-type: OR (opcode 0011) ----
        instruction = {4'b0011, 3'b100, 3'b101, 3'b110, 19'b0};
        check("OR", 4'b0011, 3'b100, 3'b101, 3'b110, 22'b0);

        // ---- ADDI (opcode 0100) ----
        // rd=3'b101, rs1=3'b010, immediate=22'h1FFFFF (all ones)
        instruction = {4'b0100, 3'b101, 3'b010, 22'h1FFFFF};
        check("ADDI (max imm)", 4'b0100, 3'b101, 3'b010, 3'b000, 22'h1FFFFF);

        // ---- ADDI with a distinct, non-trivial immediate ----
        instruction = {4'b0100, 3'b001, 3'b011, 22'h0AAAAA};
        check("ADDI (pattern imm)", 4'b0100, 3'b001, 3'b011, 3'b000, 22'h0AAAAA);

        // ---- SW (opcode 0101) ----
        // rs1=3'b110, rs2=3'b011, immediate=22'h155555
        instruction = {4'b0101, 3'b110, 3'b011, 22'h155555};
        check("SW", 4'b0101, 3'b000, 3'b110, 3'b011, 22'h155555);

        // ---- Zero immediate edge case (ADDI) ----
        instruction = {4'b0100, 3'b111, 3'b000, 22'h000000};
        check("ADDI (zero imm)", 4'b0100, 3'b111, 3'b000, 3'b000, 22'h000000);

        // ---- Unrecognized opcode: expect all outputs to default to 0 ----
        instruction = {4'b1111, 28'hFFF_FFFF};
        check("Unrecognized opcode", 4'b1111, 3'b000, 3'b000, 3'b000, 22'b0);

        // ---- Summary ----
        $display("--------------------------------------------------");
        $display("Total: %0d passed, %0d failed", pass_count, fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED");
        $display("--------------------------------------------------");

        $finish;
    end

    // Checks all fields against expected values, reports pass/fail
    task automatic check(
        input string        test_name,
        input logic [3:0]   exp_opcode,
        input logic [2:0]   exp_rd,
        input logic [2:0]   exp_rs1,
        input logic [2:0]   exp_rs2,
        input logic [21:0]  exp_immediate
    );
        #1; // allow combinational logic to settle
        if (opcode    === exp_opcode &&
            rd        === exp_rd    &&
            rs1       === exp_rs1   &&
            rs2       === exp_rs2   &&
            immediate === exp_immediate) begin
            $display("PASS: %-20s  opcode=%b rd=%b rs1=%b rs2=%b imm=%h",
                       test_name, opcode, rd, rs1, rs2, immediate);
            pass_count++;
        end else begin
            $display("FAIL: %-20s", test_name);
            $display("      got      opcode=%b rd=%b rs1=%b rs2=%b imm=%h",
                       opcode, rd, rs1, rs2, immediate);
            $display("      expected opcode=%b rd=%b rs1=%b rs2=%b imm=%h",
                       exp_opcode, exp_rd, exp_rs1, exp_rs2, exp_immediate);
            fail_count++;
        end
    endtask

endmodule