`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 20:51:28
// Design Name: 
// Module Name: alu
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


module alu(   
    input [31:0] op_a,
    input [31:0] op_b,
    input [5:0] ctrl,
    input [4:0] shamt,  
    output wire zero,    
    output reg [31:0] result
);
    
   
    parameter ADD = 6'b100000, 
              SUB = 6'b100010, 
              AND_OP = 6'b100100, 
              OR_OP = 6'b100101, 
              SLL = 6'b000000, 
              SRL = 6'b000010,
              NANDI = 6'b001110,
              JMP = 6'b000010;

    
    always @(*) begin
    case (ctrl)
        AND_OP:  result = op_a & op_b;
        OR_OP:   result = op_a | op_b;
        ADD:     result = op_a + op_b;
        SUB:     result = op_a - op_b;
        SLL:     result = op_a << shamt;
        SRL:     result = op_a >> shamt;
        NANDI:   result = ~(op_a & op_b);
        JMP:     result = op_a + op_b;
        default: result = 32'b0;
    endcase
end

        assign zero = (result== 32'b0);


endmodule


