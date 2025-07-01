module ALU (
    input  wire [31:0] SrcA,         // Operand A
    input  wire [31:0] RegData2,     // Register data (RD2)
    input  wire [31:0] ImmExt,       // Extended immediate value
    input  wire        ALUSrc,       // Selects between RegData2 and ImmExt
    input  wire [2:0]  ALUControl,   // ALU control signal
    output reg  [31:0] ALUResult,    // Result
    output wire        Zero          // Zero flag
);

    wire [31:0] SrcB = (ALUSrc) ? ImmExt : RegData2; // Mux logic inside ALU

    always @(*) begin
        case (ALUControl)
            3'b000: ALUResult = SrcA + SrcB;          // ADD (add, addi, lw, sw)
            3'b001: ALUResult = SrcA - SrcB;          // SUB (beq, sub)
            3'b010: ALUResult = SrcA & SrcB;          // AND
            3'b011: ALUResult = SrcA | SrcB;          // OR
            3'b100: ALUResult = SrcA ^ SrcB;          // XOR (newly added)
            default: ALUResult = 32'h00000000;        // Default fallback
        endcase
    end

    assign Zero = (ALUResult == 32'b0) ? 1'b1 : 1'b0;  // Used for branch comparison

endmodule
