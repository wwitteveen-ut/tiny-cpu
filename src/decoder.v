module decoder(
    input logic [31:0] instruction,
    output logic [3:0] opcode,
    output logic [3:0] rd,
    output logic [3:0] rs1,
    output logic [3:0] rs2
);
    assign opcode = instruction[31:28];
    assign rd = instruction[27:24];
    assign rs1 = instruction[23:20];
    assign rs2 = instruction[19:16];

endmodule