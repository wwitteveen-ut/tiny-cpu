module decoder(
    input  logic [31:0] instruction,

    output logic [3:0]  opcode,
    output logic [2:0]  rd,
    output logic [2:0]  rs1,
    output logic [2:0]  rs2,
    output logic [21:0] immediate
);

    typedef enum logic [3:0] {
        OP_ADD  = 4'b0000,
        OP_SUB  = 4'b0001,
        OP_AND  = 4'b0010,
        OP_OR   = 4'b0011,
        OP_ADDI = 4'b0100,
        OP_SW   = 4'b0101
    } opcode_e;

    opcode_e opcode_cast;

    assign opcode     = instruction[31:28];
    assign opcode_cast = opcode_e'(opcode);

    always_comb begin
        rd        = 3'b000;
        rs1       = 3'b000;
        rs2       = 3'b000;
        immediate = 22'b0;

        case (opcode_cast)

            // R-type
            OP_ADD, OP_SUB, OP_AND, OP_OR: begin
                rd  = instruction[27:25];
                rs1 = instruction[24:22];
                rs2 = instruction[21:19];
            end

            // ADDI
            OP_ADDI: begin
                rd        = instruction[27:25];
                rs1       = instruction[24:22];
                immediate = instruction[21:0];
            end

            // SW
            OP_SW: begin
                rs1       = instruction[27:25];
                rs2       = instruction[24:22];
                immediate = instruction[21:0];
            end

            default: ;

        endcase
    end

endmodule