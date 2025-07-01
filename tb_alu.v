// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg  [31:0] SrcA;
    reg  [31:0] RegData2;
    reg  [31:0] ImmExt;
    reg         ALUSrc;
    reg  [2:0]  ALUControl;

    // Outputs
    wire [31:0] ALUResult;
    wire        Zero;

    // Instantiate the ALU
    ALU uut (
        .SrcA(SrcA),
        .RegData2(RegData2),
        .ImmExt(ImmExt),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );

    // Task for displaying a test case
    task display_result;
        input [2:0] control;
        input [31:0] a, b;
        begin
            $display("ALUControl=%b, SrcA=%d, SrcB=%d => ALUResult=%d, Zero=%b", control, a, b, ALUResult, Zero);
        end
    endtask

    initial begin
        $display("Starting ALU Testbench...");

        // Test ADD with register (SrcB = RegData2)
        SrcA = 32'd10;
        RegData2 = 32'd5;
        ImmExt = 32'd100;    // Won't be used
        ALUSrc = 0;
        ALUControl = 3'b000; // ADD
        #10;
        display_result(ALUControl, SrcA, RegData2);

        // Test ADDI (SrcB = ImmExt)
        SrcA = 32'd20;
        ImmExt = 32'd7;
        ALUSrc = 1;
        ALUControl = 3'b000; // ADD
        #10;
        display_result(ALUControl, SrcA, ImmExt);

        // Test SUB
        SrcA = 32'd15;
        RegData2 = 32'd15;
        ALUSrc = 0;
        ALUControl = 3'b001; // SUB
        #10;
        display_result(ALUControl, SrcA, RegData2);

        // Test AND
        SrcA = 32'hFFFF0000;
        RegData2 = 32'h0F0F0F0F;
        ALUSrc = 0;
        ALUControl = 3'b010; // AND
        #10;
        display_result(ALUControl, SrcA, RegData2);

        // Test OR
        SrcA = 32'h0000FFFF;
        ImmExt = 32'h00FF00FF;
        ALUSrc = 1;
        ALUControl = 3'b011; // OR
        #10;
        display_result(ALUControl, SrcA, ImmExt);

        // Test SLT (SrcA < SrcB)
        SrcA = 32'd5;
        RegData2 = 32'd10;
        ALUSrc = 0;
        ALUControl = 3'b101; // SLT
        #10;
        display_result(ALUControl, SrcA, RegData2);

        // Test SLT false case (SrcA > SrcB)
        SrcA = 32'd30;
        ImmExt = 32'd10;
        ALUSrc = 1;
        ALUControl = 3'b101; // SLT
        #10;
        display_result(ALUControl, SrcA, ImmExt);

        // Test default case
        SrcA = 32'd10;
        RegData2 = 32'd20;
        ALUSrc = 0;
        ALUControl = 3'b111; // Undefined operation
        #10;
        display_result(ALUControl, SrcA, RegData2);

        $display("ALU Testbench completed.");
        $finish;
    end

endmodule
