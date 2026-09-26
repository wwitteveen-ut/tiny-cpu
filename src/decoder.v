module decoder(
    input logic [31:0] instruction,
    output logic [3:0] opcode,
    output logic [2:0] rd,
    output logic [2:0] rs1,
    output logic [2:0] rs2,
    output logic [21:0] immediate
);
    assign opcode = instruction[31:28];
    assign rd = instruction[27:25];
    assign rs1 = instruction[24:22];
    assign rs2 = instruction[21:19];
    assign immediate = instruction[21:0];

endmodule