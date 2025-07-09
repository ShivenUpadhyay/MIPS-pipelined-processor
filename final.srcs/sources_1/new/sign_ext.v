`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:54:42
// Design Name: 
// Module Name: sign_ext
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


module sign_extend(
    input [20:0] const_in ,
    output [31:0] const_ext,
    input [15:0] offset,
    input offset_flag
    
    );
    wire [31:0] const_mid,offset_mid;
    assign const_mid = {{11{const_in[20]}},const_in[20:0]};
    assign offset_mid = {{16{offset[15]}},offset[15:0]};
    assign const_ext = offset_flag ? offset_mid : const_mid;
endmodule

