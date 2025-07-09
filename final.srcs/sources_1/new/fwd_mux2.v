`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 15:26:42
// Design Name: 
// Module Name: fwd_mux2
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


module fwd_mux2(
    input [31:0] ALU_OUT,    
    input [31:0] WB_OUT,     
    input [31:0] op_b,       
    input [1:0] sel2,        
    output reg [31:0] mux_2  
);
    always @(*) begin
        case(sel2)
            2'b00: mux_2 = op_b;     
            2'b10: mux_2 = ALU_OUT;  
            2'b01: mux_2 = WB_OUT;   
            default: mux_2 = op_b;   
        endcase
    end
endmodule
