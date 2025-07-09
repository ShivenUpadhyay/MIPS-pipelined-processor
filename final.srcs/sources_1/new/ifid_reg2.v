`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:14:47
// Design Name: 
// Module Name: ifid_reg2
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


module ifid_reg2(

    input [31:0] PC,
    input [31:0] inst,
    input clk,
    input reset,
    input stall,
    output [31:0] PC_out,
    output reg [31:0] inst_out,
    input flush
);

assign PC_out = PC;

always @(posedge clk or posedge reset) begin
    if (reset || flush) begin
        inst_out <= 0;
    end else if (!stall) begin
        inst_out <= inst;
    end
end


endmodule
