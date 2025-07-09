`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:12:34
// Design Name: 
// Module Name: hazard_detect
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


module hazard_detection_unit(
    input [4:0] RR_EX_Rdst,
    input [4:0] Rsrc1,
    input [4:0] Rsrc2,
    input MemRead,
    output reg stall

);

always @(*) begin
    


    if (MemRead && ((RR_EX_Rdst == Rsrc1) || (RR_EX_Rdst == Rsrc2))) begin
        stall <= 1'b1;

    end
    else stall <=1'b0;
end

endmodule