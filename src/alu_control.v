module alu_control (
    input  logic [3:0] opcode,
    output logic [1:0] alu_op,
    output logic       alu_src
);

    always_comb begin
        case (opcode)
            4'b0000: begin // ADD
                alu_op  = 2'b00;
                alu_src = 1'b0;
            end

            4'b0001: begin // SUB
                alu_op  = 2'b01;
                alu_src = 1'b0;
            end

            4'b0010: begin // AND
                alu_op  = 2'b10;
                alu_src = 1'b0;
            end

            4'b0011: begin // OR
                alu_op  = 2'b11;
                alu_src = 1'b0;
            end

            4'b0100: begin // ADDI
                alu_op  = 2'b00;
                alu_src = 1'b1;
            end

            default: begin
                alu_op  = 2'b00;
                alu_src = 1'b0;
            end
        endcase
    end

endmodule