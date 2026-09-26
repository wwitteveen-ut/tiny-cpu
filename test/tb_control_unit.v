`timescale 1ns/1ps

module tb_control_unit;

    logic [3:0] opcode;
    logic       reg_write;
    logic       alu_src;
    logic       mem_write;

    int pass_count = 0;
    int fail_count = 0;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_write(mem_write)
    );

    initial begin
        $dumpfile("build/control_unit.vcd");
        $dumpvars(0, tb_control_unit);

        opcode = 4'b0000;
        check("ADD", 1'b1, 1'b0, 1'b0);

        opcode = 4'b0001;
        check("SUB", 1'b1, 1'b0, 1'b0);

        opcode = 4'b0010;
        check("AND", 1'b1, 1'b0, 1'b0);

        opcode = 4'b0011;
        check("OR", 1'b1, 1'b0, 1'b0);

        opcode = 4'b0100;
        check("ADDI", 1'b1, 1'b1, 1'b0);

        opcode = 4'b0101;
        check("SW", 1'b0, 1'b1, 1'b1);

        opcode = 4'b1111;
        check("INVALID", 1'b0, 1'b0, 1'b0);

        $finish;
    end

    task automatic check(
        input string      test_name,
        input logic       exp_reg_write,
        input logic       exp_alu_src,
        input logic       exp_mem_write
    );
        #1;

        if (reg_write === exp_reg_write &&
            alu_src   === exp_alu_src   &&
            mem_write === exp_mem_write) begin

            $display("PASS: %-20s  reg_write=%b alu_src=%b mem_write=%b",
                    test_name, reg_write, alu_src, mem_write);

            pass_count++;

        end else begin

            $display("FAIL: %-20s", test_name);
            $display("      got      reg_write=%b alu_src=%b mem_write=%b",
                    reg_write, alu_src, mem_write);

            $display("      expected reg_write=%b alu_src=%b mem_write=%b",
                    exp_reg_write, exp_alu_src, exp_mem_write);

            fail_count++;
        end
    endtask



endmodule