`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 15:22:21
// Design Name: 
// Module Name: fwd_mux_ex
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

module fwd_mux1(
    input [31:0] ALU_OUT,    
    input [31:0] WB_OUT,     
    input [31:0] op_a,       
    input [1:0] sel1,        
    output reg [31:0] mux_1  
);
    always @(*) begin
        case(sel1)
            2'b00: mux_1 = op_a;     
            2'b10: mux_1 = ALU_OUT;  
            2'b01: mux_1 = WB_OUT;   
            default: mux_1 = op_a;   
        endcase
    end
endmodule
