module alu_control(
    input logic [3:0] opcode,
    output logic [1:0] alu_op
);
    always_comb begin
        case (opcode)
            4'b0000, 4'b0100: alu_op = 2'b00; // ADD, ADDI
            4'b0001:          alu_op = 2'b01; // SUB
            4'b0010:          alu_op = 2'b10; // AND
            4'b0011:          alu_op = 2'b11; // OR
            default:          alu_op = 2'b00;
        endcase
    end

endmodule