`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:58:38
// Design Name: 
// Module Name: forward_unit
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


module forward_unit(
    input [4:0] RR_EX_Rsrc1,
    input [4:0] RR_EX_Rsrc2,
    input [4:0] EX_MEM_Rdst,
    input [4:0] MEM_WB_Rdst,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
);

always @(*) begin
  
    forwardA = 2'b00;
    forwardB = 2'b00;

   
    if (EX_MEM_RegWrite  && (EX_MEM_Rdst == RR_EX_Rsrc1))
        forwardA = 2'b10;
    if (EX_MEM_RegWrite && (EX_MEM_Rdst == RR_EX_Rsrc2))
        forwardB = 2'b10;

   
    if (MEM_WB_RegWrite && !(EX_MEM_RegWrite && (EX_MEM_Rdst == RR_EX_Rsrc1)) &&(MEM_WB_Rdst == RR_EX_Rsrc1))
        forwardA = 2'b01;

    if (MEM_WB_RegWrite &&!(EX_MEM_RegWrite && (EX_MEM_Rdst == RR_EX_Rsrc2)) &&(MEM_WB_Rdst == RR_EX_Rsrc2))
        forwardB = 2'b01;
end

endmodule