`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2025 13:58:11
// Design Name: 
// Module Name: mul_block
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


module mul_block(
    input wire [31:0] a,
    input wire [31:0] b,
    output reg [31:0] result
    );
    
    always@(*) begin
        result = $signed(a) * $signed(b) ;
        $display ("Multiplier Executing : a=%h (%d),b=%h(%d),result=%h(%d)",
        a,$signed(a),b,$signed(b),result,$signed(result));
        
    end
endmodule
