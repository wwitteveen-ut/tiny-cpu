module control_unit (
    input  logic [3:0] opcode,
    output logic       reg_write,
    output logic       alu_src,
    output logic       mem_write
);

    always_comb begin
        case (opcode)
            4'b0000: begin // ADD
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_write   = 1'b0;
            end

            4'b0001: begin // SUB
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_write   = 1'b0;
            end

            4'b0010: begin // AND
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_write   = 1'b0;
            end

            4'b0011: begin // OR
                reg_write = 1'b1;
                alu_src   = 1'b0;
                mem_write   = 1'b0;
            end

            4'b0100: begin // ADDI
                reg_write = 1'b1;
                alu_src   = 1'b1;
                mem_write   = 1'b0;
            end

            4'b0101: begin // LW
                reg_write = 1'b0;
                alu_src   = 1'b1;
                mem_write   = 1'b1;
            end

            default: begin
                reg_write = 1'b0;
                alu_src   = 1'b0;
                mem_write   = 1'b0;
            end
        endcase
    end

endmodule