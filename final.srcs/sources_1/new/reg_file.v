`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 20:10:43
// Design Name: 
// Module Name: reg_file
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
module reg_file(
    input reset,
    input clk,
    input[4:0] reg_sel_1,
    input [4:0] reg_sel_2,
    output wire [31:0] reg1,
    output wire [31:0] reg2,
    input write_e,
    input[4:0] write_sel,
    input wire [31:0] write_data
    );
          
    reg [31:0] registers [31:0];    
    
    assign reg1 = registers[reg_sel_1];
    assign reg2 = registers[reg_sel_2];
    
    always@(negedge clk or posedge reset) begin
        if(reset) begin
      registers[0]  <= 32'h00000000;  // R0 always zero
    registers[1]  <= 32'h00000000;
    registers[2]  <= 32'h00000000;
    registers[3]  <= 32'h00000000;
    registers[4]  <= 32'h00000000;
    registers[5]  <= 32'h00000000;
    registers[6]  <= 32'h00000000;
    registers[7]  <= 32'h00000000;
    registers[8]  <= 32'h00000000;
    registers[9]  <= 32'h00000000;
    registers[10] <= 32'h00000000;
    registers[11] <= 32'h00000000;
    registers[12] <= 32'h00000000;
    registers[13] <= 32'h00000000;
    registers[14] <= 32'h00000000;
    registers[15] <= 32'h00000000;
    registers[16] <= 32'h00000000;
    registers[17] <= 32'h00000000;
    registers[18] <= 32'h00000000;
    registers[19] <= 32'h00000000;
    registers[20] <= 32'h00000000;
    registers[21] <= 32'h00000000;
    registers[22] <= 32'h00000000;
    registers[23] <= 32'h00000000;
    registers[24] <= 32'h00000000;
    registers[25] <= 32'h00000000;
    registers[26] <= 32'h00000000;
    registers[27] <= 32'h00000000;
    registers[28] <= 32'h00000000;
    registers[29] <= 32'h00000000;
    registers[30] <= 32'h00000000;
    registers[31] <= 32'h00000000;

        end
        
        else if(write_e) begin
        registers[write_sel] <= write_data;
        end
    end
    
endmodule

