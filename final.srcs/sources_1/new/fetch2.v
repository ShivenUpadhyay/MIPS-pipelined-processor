`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:56:40
// Design Name: 
// Module Name: fetch2
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


module fetch2(

     input clk,
    input reset,
    input jmp_src,
    input stall,
    input [31:0] PC_j,
    output [31:0] PC_curr,
    output [31:0] inst_curr,
    input flush
    );
    wire [31:0] PC;
    wire [31:0] inst;
   
    inst_mem inst_mem1(   
    .PC(PC),
    .reset(reset),
    .inst(inst)
    );
    
    prog_counter2 pc1(
    .clk(clk),
    .reset(reset),
    .PC_j(PC_j),    
    .PC(PC),
    .stall(stall),
    .jmp_src(jmp_src)
    );
    
    ifid_reg2 ifid_reg1(
    .PC(PC),
    .inst(inst),
    .clk(clk),
    .reset(reset),
    .PC_out(PC_curr),
    .inst_out(inst_curr),
    .stall(stall),
    .flush(flush)
    );
endmodule
