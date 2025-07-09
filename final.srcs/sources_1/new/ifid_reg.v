`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:25:45
// Design Name: 
// Module Name: ifid_reg
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


module ifid_reg(
    input [31:0] PC,
    input [31:0] inst,
    input clk,
    input reset,
    output [31:0] PC_out,
    output reg [31:0] inst_out
    );
    
    assign PC_out = PC;
    always@(posedge clk or posedge reset) begin
    if(reset) begin        
        inst_out<=0;
    end
    else begin       
        inst_out<=inst;
    end
    end
endmodule
