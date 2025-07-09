`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 19:27:28
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input reset
    );
    wire [31:0] inst,PC_jmp,PC;
    wire [4:0] Rdst, Rsrc1, Rsrc2, shamt, shamt_rr;
    wire [5:0] func,func_rr, op_code;
    wire [31:0] const;
    wire [31:0] op_a,op_b,const_rr;
    wire [31:0] alu_out,write_data;
    wire [31:0] mem_out,mem_alu_out;
    wire [31:0] write_back_data;
    wire jmp_src;
    wire alu_src_id,mem_write_id,reg_write_id,wb_src_id;   
    wire wb_src_rr,alu_src_rr,reg_write_rr,mem_write_rr;
    wire wb_src_ex,reg_write_ex,mem_write_ex;
    wire wb_src_mm,reg_write_mm;
    wire reg_write_wb;
        
    instruction_fetch fetch1(
    .clk(clk),
    .reset(reset),
    .jmp_src(jmp_src),
    .PC_j(PC_jmp),
    .PC_curr(PC),
    .inst_curr(inst)
    );
    
    
   inst_decode decode1 (
        .inst(inst),
        .clk(clk),
        .reset(reset),
        .PC(PC),
        .jmp_adr(PC_jmp),
        .Rdst_out(Rdst),
        .Rsrc1_out(Rsrc1),
        .Rsrc2_out(Rsrc2),
        .shamt_out(shamt),
        .func_out(func),
        .const_out(const),
        .op_code_out(op_code),
        .jmp_src(jmp_src),
        .alu_src_id(alu_src_id),
        .mem_write_id(mem_write_id),
        .reg_write_id(reg_write_id),
        .wb_src_id(wb_src_id)
    );
    
    reg_read reg_read1 (
        .clk(clk),
        .reset(reset),
        .op_a(op_a),
        .op_b(op_b),
        .const(const),
        .const_out(const_rr),
        .write_back_data(write_back_data),
        .write_e(reg_write_wb), 
        .Rdst(Rdst),
        .Rsrc1(Rsrc1),
        .Rsrc2(Rsrc2),
        .shamt(shamt),
        .shamt_out(shamt_rr),
        .func(func),
        .func_out(func_rr),
        .wb_src_id(wb_src_id),
        .alu_src_id(alu_src_id),
        .reg_write_id(reg_write_id),
        .mem_write_id(mem_write_id),
        .wb_src_rr(wb_src_rr),
        .alu_src_rr(alu_src_rr),
        .reg_write_rr(reg_write_rr),
        .mem_write_rr(mem_write_rr)
    );
    
    
    execution_unit ex_unit1(
    .clk(clk),
    .reset(reset),
    .op_a(op_a),
    .op_b(op_b),
    .func(func_rr),
    .alu_src_rr(alu_src_rr),
    .result(alu_out),
    .const(const_rr),
    .reg_read2(write_data),
    .wb_src_rr(wb_src_rr),
    .mem_write_rr(mem_write_rr),
    .reg_write_rr(reg_write_rr),
    .wb_src_ex(wb_src_ex),
    .mem_write_ex(mem_write_ex),
    .reg_write_ex(reg_write_ex)
    
    );  
    
    mem_stage mem_stage1(
    .clk(clk),
    .reset(reset),
    .reg_read2(write_data),
    .alu_result(alu_out),
    .data_out(mem_out),
    .alu_out(mem_alu_out),
    .mem_write_ex(mem_write_ex),
    .reg_write_ex(reg_write_ex),
    .wb_src_ex(wb_src_ex),
    .wb_src_mm(wb_src_mm),
    .reg_write_mm(reg_write_mm)
    );
    
    write_back wb1(
    .a(mem_alu_out),
    .b(mem_out),
    .wb_src_mm(wb_src_mm),
    .write_back_data(write_back_data),
    .reg_write_mm(reg_write_mm),
    .reg_write_wb(reg_write_wb)
    );
endmodule
