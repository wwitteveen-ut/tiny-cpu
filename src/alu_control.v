module alu_control(
    input logic [3:0] opcode,
    output logic [1:0] alu_op
);
    always @(*) begin
        case (opcode)
            4'b0000: alu_op = 2'b00; 
            4'b0001: alu_op = 2'b01;
            4'b0010: alu_op = 2'b10; 
            4'b0011: alu_op = 2'b11;
            default: alu_op = 0;
        endcase
    end

endmodule