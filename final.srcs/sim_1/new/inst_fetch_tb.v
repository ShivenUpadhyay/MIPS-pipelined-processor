`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 16:57:09
// Design Name: 
// Module Name: inst_fetch_tb
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


module inst_fetch_tb(

    );
    reg clk,reset,jmp_src;
    reg [31:0] PC_jmp;
    
    initial begin
        clk<=0;
        jmp_src<=0;
        reset<=1;
        #20 reset<=0;
        #50 jmp_src<=1;
        PC_jmp<=32'd8;
        #5 jmp_src<=0;        
    end
    
    initial begin
    forever #5 clk<=~clk;
    end
    
    
    instruction_fetch fetch1(
    .clk(clk),
    .reset(reset),
    .jmp_src(jmp_src),
    .PC_j(PC_jmp),
    .PC_curr(),
    .inst_curr()
    );
endmodule
