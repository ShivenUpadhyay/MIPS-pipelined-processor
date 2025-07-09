`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.04.2025 16:56:38
// Design Name: 
// Module Name: sign_ext_tb
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


module sign_ext_tb( );

sign_extend ext1(
    .const_in() ,
    output [31:0] const_ext
    );
    assign const_ext = {{11{const_in[20]}},const_in[20:0]};
    
endmodule
endmodule
