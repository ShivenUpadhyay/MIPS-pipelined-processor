`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 21:23:48
// Design Name: 
// Module Name: mem_stage
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


module mem_stage(
    input clk,
    input reset,
    input [31:0] write_data,
    input [31:0] alu_result,
    output reg [31:0] data_out,
    output reg [31:0] alu_out,
    input mem_write_ex,
    input reg_write_ex,
    input wb_src_ex,
    output reg wb_src_mm,
    output reg reg_write_mm,
    input [4:0] Rdst_ex_out,
    output reg [4:0] Rdst_mem_out
    
    
    );
    
    wire [31:0] data_out_w;
    
 data_memory data_mem1(
 .clk(clk),
 .reset(reset),
 .address(alu_result),
 .write_data(write_data),
  .write_e(mem_write_ex),
 .read_out(data_out_w)
    );
    
    always@(posedge clk or posedge reset) begin
    if(reset) begin
    alu_out <= 32'b0;
    data_out <=32'b0;
    wb_src_mm<=1'b0;
    reg_write_mm<=1'b0;
    Rdst_mem_out<=32'b0;
    end
    else begin
    alu_out<=alu_result;
    data_out<=data_out_w;
     wb_src_mm<=wb_src_ex;
    reg_write_mm<=reg_write_ex;
    Rdst_mem_out <= Rdst_ex_out;
    
    end
    end
    
endmodule
