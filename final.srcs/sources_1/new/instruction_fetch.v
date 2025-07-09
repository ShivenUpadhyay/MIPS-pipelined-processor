`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:11:25
// Design Name: 
// Module Name: instruction_fetch
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


module instruction_fetch(
    input clk,
    input reset,
    input jmp_src,
    input [31:0] PC_j,
    output [31:0] PC_curr,
    output [31:0] inst_curr
    );
    wire [31:0] PC;
    wire [31:0] inst;
    
    inst_mem inst_mem1(   
    .PC(PC),
    .reset(reset),
    .inst(inst)
    );
    
    prog_counter pc1(
    .clk(clk),
    .reset(reset),
    .PC_j(PC_j),    
    .PC(PC),
    .jmp_src(jmp_src)
    );
    
    ifid_reg ifid_reg1(
    .PC(PC),
    .inst(inst),
    .clk(clk),
    .reset(reset),
    .PC_out(PC_curr),
    .inst_out(inst_curr)
    );
endmodule
