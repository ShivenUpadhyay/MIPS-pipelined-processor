`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 17:15:23
// Design Name: 
// Module Name: fetch_decode_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module inst_decode_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] inst;
    reg [31:0] PC;

    // Outputs
    wire [31:0] jmp_adr;
    wire [4:0] Rdst_out;
    wire [4:0] Rsrc1_out;
    wire [4:0] Rsrc2_out;
    wire [4:0] shamt_out;
    wire [5:0] func_out;
    wire [31:0] const_out;
    wire [5:0] op_code_out;
    wire jmp_src;
    wire alu_src_id;
    wire mem_write_id;
    wire reg_write_id;
    wire wb_src_id;

    // Instantiate the Unit Under Test (UUT)
    inst_decode uut (
        .inst(inst),
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .jmp_adr(jmp_adr),
        .Rdst_out(Rdst_out),
        .Rsrc1_out(Rsrc1_out),
        .Rsrc2_out(Rsrc2_out),
        .shamt_out(shamt_out),
        .func_out(func_out),
        .const_out(const_out),
        .op_code_out(op_code_out),
        .jmp_src(jmp_src),
        .alu_src_id(alu_src_id),
        .mem_write_id(mem_write_id),
        .reg_write_id(reg_write_id),
        .wb_src_id(wb_src_id)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        inst = 0;
        PC = 0;

        // Wait a little and then deassert reset
        #10;
        reset = 0;

        // Test instruction: lw $1, 0($0)
        inst = 32'b100011_00000_00001_0000000000000000;
        PC = 32'h00000000;
        #10;

        // Test instruction: lw $2, 4($0)
        inst = 32'b100011_00000_00010_0000000000000100;
        PC = 32'h00000004;
        #10;

        // Test instruction: add $3, $1, $2 (R-type)
        inst = 32'b000000_00001_00010_00011_00000_100000;
        PC = 32'h00000008;
        #10;

        // Test instruction: j 0x00400000
        inst = 32'b000010_00000000010000000000000000;
        PC = 32'h0000000C;
        #10;

        // Done
        $finish;
    end

endmodule
