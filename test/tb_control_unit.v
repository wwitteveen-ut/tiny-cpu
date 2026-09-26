`timescale 1ns/1ps

module tb_control_unit;

    logic [3:0] opcode;
    logic       reg_write;
    logic       alu_src;

    control_unit uut (
        .opcode(opcode),
        .reg_write(reg_write),
        .alu_src(alu_src)
    );

    initial begin
        $dumpfile("build/control_unit.vcd");
        $dumpvars(0, tb_control_unit);

        $display("opcode  | reg_write | alu_src");

        opcode = 4'b0000; #10;
        $display("%b    |     %b     |    %b    (expect 1, 0 ADD)",
                 opcode, reg_write, alu_src);

        opcode = 4'b0001; #10;
        $display("%b    |     %b     |    %b    (expect 1, 0 SUB)",
                 opcode, reg_write, alu_src);

        opcode = 4'b0010; #10;
        $display("%b    |     %b     |    %b    (expect 1, 0 AND)",
                 opcode, reg_write, alu_src);

        opcode = 4'b0011; #10;
        $display("%b    |     %b     |    %b    (expect 1, 0 OR)",
                 opcode, reg_write, alu_src);

        opcode = 4'b0100; #10;
        $display("%b    |     %b     |    %b    (expect 1, 1 ADDI)",
                 opcode, reg_write, alu_src);

        opcode = 4'b1111; #10;
        $display("%b    |     %b     |    %b    (expect 0, 0 default)",
                 opcode, reg_write, alu_src);

        $finish;
    end

endmodule