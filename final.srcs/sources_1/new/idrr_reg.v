`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 19:11:35
// Design Name: 
// Module Name: idrr_reg
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


module idrr_reg(
    input wire clk,      // Clock signal
    input wire rst,      // Reset signal
    input wire [4:0] Rdst,
    input wire [4:0] Rsrc1,
    input wire [4:0] Rsrc2,
    input wire [4:0] shamt,
    input wire [5:0] func,
    input wire [31:0] const,
    input wire [5:0] op_code,  
    output reg [4:0] Rdst_out,
    output reg [4:0] Rsrc1_out,
    output reg [4:0] Rsrc2_out,
    output reg [4:0] shamt_out,
    output reg [5:0] func_out,
    output reg [31:0] const_out,
    output reg [5:0] op_code_out,
    input wire alu_src,
    input wire reg_write,
    input wire mem_write,
    input wire wb_src,
    output reg alu_src_dec,
    output reg reg_write_dec,
    output reg mem_write_dec,
    output reg wb_src_dec,
    input jmp_src,
    output reg jmp_src_out
    
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        Rdst_out   <= 5'b0;
        Rsrc1_out  <= 5'b0;
        Rsrc2_out  <= 5'b0;
        shamt_out  <= 5'b0;
        func_out   <= 6'b0;
        const_out  <= 32'b0;
        op_code_out <= 6'b0;
        alu_src_dec <= 1'b0;
        reg_write_dec <= 1'b0;
        mem_write_dec <= 1'b0;
        wb_src_dec <= 1'b0;
        jmp_src_out<=1'b0;
        
      
    end else begin
        Rdst_out   <= Rdst;
        Rsrc1_out  <= Rsrc1;
        Rsrc2_out  <= Rsrc2;
        shamt_out  <= shamt;
        func_out   <= func;
        const_out  <= const;
        op_code_out <= op_code; 
         alu_src_dec <= alu_src;
        reg_write_dec <= reg_write;
        mem_write_dec <= mem_write;
        wb_src_dec <= wb_src; 
        jmp_src_out<=jmp_src;    
    end
end

endmodule