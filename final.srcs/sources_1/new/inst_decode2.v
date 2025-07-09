`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:17:26
// Design Name: 
// Module Name: inst_decode2
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


module inst_decode2(

    input [31:0] inst,
    input clk,
    input reset,
    input stall,
    input flush,
    input [31:0] PC,
    output [31:0] jmp_adr,
  
       
    output [4:0] Rdst_out,
    output [4:0] Rsrc1_out,
    output [4:0] Rsrc2_out,
    output [4:0] shamt_out,
    output [5:0] func_out,
    output [31:0] const_out,
    output [5:0] op_code_out,
    output jmp_src,
    output alu_src_id,
    output mem_write_id,
    output reg_write_id,
    output wb_src_id,
    output memread_dec,
    output [4:0] Rsrc1_hazard,
    output [4:0] Rsrc2_hazard,
    output store_word_flag_out
    );
 
     wire [4:0] Rdst;
    wire [4:0] Rsrc1;
    wire [4:0] Rsrc2;
     wire [4:0] shamt;
    wire [5:0] func;
   wire [20:0] const;
    wire [25:0] addr;
    wire [3:0] bits;
   wire [5:0] op_code;  
   wire [31:0] const_ext;
    wire [15:0] offset;
      wire [5:0] func_inst;
 wire [31:0] jmp_addr;
 wire store_word_flag;

 
  assign Rsrc1_hazard=Rsrc1;
  assign Rsrc2_hazard=Rsrc2;
 decoder decoder1 (    
    .inst(inst),  
     .Rdst(Rdst),
    .Rsrc1(Rsrc1),
    .Rsrc2(Rsrc2),
    .shamt(shamt),
   .func_inst(func_inst),
    .const(const),
    .addr(addr),
    .bits(bits),
    .op_code(op_code),
    .PC(PC),
    .offset(offset)
    ); 
    
    jmp_addr jmp_addr1(
    .addr(addr),
    .bits(bits),
    .jmp_adr(jmp_addr)
    );  
   
   sign_extend extender1(
    .const_in(const) ,
    .const_ext(const_ext),
    .offset(offset),
    .offset_flag(offset_flag)
    );
    
     
     
  wire jmp;
    wire alu_src,reg_write,mem_write,wb_src;
   
  wire memread;
    idrr_reg2 idrr_reg2_1(
        .clk(clk),
        .rst(reset),
        .Rdst(Rdst),
        .Rsrc1(Rsrc1),
        .Rsrc2(Rsrc2),
        .shamt(shamt),
        .func(func),
        .const(const_ext),
        .op_code(op_code),
        .Rdst_out(Rdst_out),
        .Rsrc1_out(Rsrc1_out),
        .Rsrc2_out(Rsrc2_out),
        .shamt_out(shamt_out),
        .func_out(func_out),
        .const_out(const_out),
        .op_code_out(op_code_out),  
        .alu_src(alu_src),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .wb_src(wb_src),
        .alu_src_dec(alu_src_id),
        .reg_write_dec(reg_write_id),
        .mem_write_dec(mem_write_id),
        .wb_src_dec(wb_src_id),   
        .jmp_src(jmp),
        .jmp_src_out(jmp_src),
        .stall(stall),
        .flush(flush),
        .memread(memread),
        .memread_dec(memread_dec),
        .jmp_addr_in(jmp_addr),
        .jmp_addr(jmp_adr),
        .store_word_flag_in(store_word_flag),
        .store_word_flag(store_word_flag_out)
    );
    wire offset_flag;
  control_unit control_unit1(
    .opcode(op_code),
    .jmp_src(jmp),
    .alu_src(alu_src),
    .reg_write(reg_write),
    .wb_src(wb_src),
    .mem_write(mem_write),
    .func(func),
    .func_inst(func_inst),
    .memread(memread),
    .offset_flag(offset_flag),
    .store_word_flag(store_word_flag)   
    );
    
    

endmodule
