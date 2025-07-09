`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:14:46
// Design Name: 
// Module Name: prog_counter
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


module prog_counter(
    input clk,
    input reset,
    input [31:0] PC_j,    
    output reg [31:0] PC,
    input jmp_src
    );
    wire [31:0] PC_imm,PC_next;
    assign PC_next = PC + 4;
    assign PC_imm = jmp_src ? PC_j : PC_next;
    
    always@(posedge clk or posedge reset) begin
        if(reset) begin
            PC<=0;
        end
        else PC<=PC_imm;        
    end
endmodule
