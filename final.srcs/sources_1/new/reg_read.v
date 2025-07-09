`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 19:42:34
// Design Name: 
// Module Name: reg_read
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


module reg_read(
    input clk,
    input reset,
    output reg [31:0] op_a,
    output reg [31:0] op_b,
    input [31:0] const,
    output reg [31:0] const_out,
    input [31:0] write_back_data,
    input write_e,
    input [4:0] Rdst,
    input [4:0] Rsrc1,
    input [4:0] Rsrc2,
    input [4:0] shamt,
    output reg [4:0] shamt_out,
    input [5:0] func,
    output reg [5:0] func_out,
    input wb_src_id,
    input alu_src_id,
    input reg_write_id,
    input mem_write_id,
    output reg wb_src_rr,
    output reg alu_src_rr,
    output reg reg_write_rr,
    output reg mem_write_rr,
    output reg [4:0] Rdst_rr_out,
    input memread_dec,
    output reg memread_rr,
    output  reg [4:0] Rsrc1_rr,
    output reg [4:0] Rsrc2_rr,
    input [4:0] rdst_input,
    input store_word_flag
    ); 
    wire [31:0] op_a_w,op_b_w;
    
    wire [4:0] Rsrc2_w;
    assign Rsrc2_w = store_word_flag ? Rdst:Rsrc2;
    reg_file reg_file1(
    .reset(reset),
    .clk(clk),
    .reg_sel_1(Rsrc1),
    .reg_sel_2(Rsrc2_w),
    .reg1(op_a_w),
    .reg2(op_b_w),
    .write_e(write_e),
    .write_sel(rdst_input),
    .write_data(write_back_data)
    );
    
    always@(posedge clk or posedge reset) begin
    if(reset) begin
    op_a<=32'b0;
    op_b<=32'b0;
    const_out<=32'b0;
    func_out<=6'b0;
    shamt_out<=5'b0;
    wb_src_rr<=1'b0;
    alu_src_rr<=1'b0;
    reg_write_rr<=1'b0;
    mem_write_rr<=1'b0;
    Rdst_rr_out<=4'b0;
    memread_rr<=0;
    Rsrc1_rr<=5'b0;
    Rsrc2_rr<=5'b0;
    end    
    else begin
//      op_a<=op_a_w;
//    op_b<=op_b_w;
   op_a<=op_a_w;
    op_b<=op_b_w;
    const_out<=const;
    func_out<=func;
    shamt_out<=shamt;
     wb_src_rr<=wb_src_id;
    alu_src_rr<=alu_src_id;
    reg_write_rr<=reg_write_id;
    mem_write_rr<=mem_write_id;
    Rdst_rr_out<=Rdst;
    memread_rr<=memread_dec;
    Rsrc1_rr<=Rsrc1;
    Rsrc2_rr<=Rsrc2;
    end
    end
    
  
    
    
endmodule
