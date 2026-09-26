module decoder(
    input logic [31:0] instruction,
    output logic [3:0] opcode,
    output logic [2:0] rd,
    output logic [2:0] rs1,
    output logic [2:0] rs2
);
    assign opcode = instruction[31:28];
    assign rd = instruction[27:25];
    assign rs1 = instruction[24:22];
    assign rs2 = instruction[21:19];

endmodule