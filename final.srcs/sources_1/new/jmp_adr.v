`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:56:28
// Design Name: 
// Module Name: jmp_addr
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


module jmp_addr(
    input [25:0] addr,
    input [3:0] bits,
    output [31:0] jmp_adr
    );
    
   assign jmp_adr = {bits,addr,2'b00};
   
endmodule
