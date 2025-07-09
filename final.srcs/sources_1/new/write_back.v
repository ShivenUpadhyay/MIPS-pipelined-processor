`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 21:42:54
// Design Name: 
// Module Name: write_back
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


module write_back(
    input [31:0] a,
    input [31:0] b,
    input wb_src_mm,
    output [31:0] write_back_data,
    input reg_write_mm,
    output reg_write_wb,
    input [4:0] rdst_mem,
    output [4:0] rdst_wb_out
    );
    assign rdst_wb_out = rdst_mem;
    assign reg_write_wb = reg_write_mm;
    assign write_back_data = wb_src_mm ? a:b;
endmodule
