`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 13:06:13
// Design Name: 
// Module Name: top2
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


module top2(
    input clk,
    input reset,
    output out,
    output stall_out,
    output [1:0] forwardA_out
);
  
    wire [31:0] inst, PC_jmp, PC;
    wire [4:0] Rdst, Rsrc1, Rsrc2, shamt, shamt_rr;
    wire [5:0] func, func_rr, op_code;
    wire [31:0] const;
    wire [31:0] op_a, op_b, const_rr;
    wire [31:0] alu_out, write_data;
    wire [31:0] mem_out, mem_alu_out;
    wire [31:0] write_back_data;
    wire jmp_src;
    wire [4:0]Rdst_ex_out;
        wire [4:0] Rdst_mem_out;
    wire [4:0] Rsrc1_hazard;
    wire [4:0] Rsrc2_hazard;

   wire [5:0] rdst_wb_out;
    wire alu_src_id, mem_write_id, reg_write_id, wb_src_id;   
    wire wb_src_rr, alu_src_rr, reg_write_rr, mem_write_rr;
    wire wb_src_ex, reg_write_ex, mem_write_ex;
    wire wb_src_mm, reg_write_mm;
    wire reg_write_wb;

    wire stall;

    wire [4:0] Rdst_rr_out;
    wire memread_rr;
    wire [1:0] forwardA, forwardB;
    wire store_word_flag;
    wire memread_ex;
   //for stalls
    hazard_detection_unit hdu (
        .RR_EX_Rdst(Rdst_rr_out),
        .Rsrc1(Rsrc1),
        .Rsrc2(Rsrc2),
        .MemRead(memread_rr),    
        .stall(stall)
        
    );

    //for ex to ex and mem to ex forwarding
    forward_unit fwd_unit(
           .RR_EX_Rsrc1(Rsrc1_rr),
            .RR_EX_Rsrc2(Rsrc2_rr),
            .EX_MEM_Rdst(Rdst_ex_out),
            .MEM_WB_Rdst(Rdst_mem_out),
            .EX_MEM_RegWrite(reg_write_ex),
            .MEM_WB_RegWrite(reg_write_wb),
    
        .forwardA(forwardA),
        .forwardB(forwardB)
    );

    // fetch stage contains the inst_mem PC counter gets jump address from decode stage
    fetch2 fetch1(
        .clk(clk),
        .reset(reset),
        .jmp_src(jmp_src),
        .stall(stall),
        .PC_j(PC_jmp),
        .PC_curr(PC),
        .inst_curr(inst),
        .flush(jmp_src)
    );
    wire memread_dec;
    
    //instruction decode,sign extend, and jump addr calc
    inst_decode2 decode1 (
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
        .wb_src_id(wb_src_id),
        .stall(stall),          
        .flush(jmp_src),
        .memread_dec(memread_dec),
        .Rsrc1_hazard(Rsrc1_hazard),
        .Rsrc2_hazard(Rsrc2_hazard),
        .store_word_flag_out(store_word_flag)
                
    );
    wire [4:0] Rsrc1_rr,Rsrc2_rr;

    //contains the register file, read at -ve edge write at +ve edge 
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
        .mem_write_rr(mem_write_rr),
        .Rdst_rr_out(Rdst_rr_out),
        .memread_dec(memread_dec),
        .memread_rr(memread_rr),
        .Rsrc1_rr(Rsrc1_rr),
        .Rsrc2_rr(Rsrc2_rr),
        .rdst_input(rdst_wb_out),
        .store_word_flag(store_word_flag)
    );
    

    wire [4:0]Rdst_ex_out;
    wire memread_ex;
    
    //contains the ALU and forwarding wires
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
        .reg_write_ex(reg_write_ex),
        
        .MEM_OUT(write_back_data),
        .sel1(forwardA),
        .sel2(forwardB),
        .Rdst_rr_out(Rdst_rr_out),
        .Rdst_ex_out (Rdst_ex_out),
        .memread_rr(memread_rr),
        .memread_ex(memread_ex),
        .ALU_OUT(alu_out) 
    );
    wire [4:0] Rdst_mem_out;
    
    //caontisn data memory
    mem_stage mem_stage1(
        .clk(clk),
        .reset(reset),
        .write_data(write_data),
        .alu_result(alu_out),
        .data_out(mem_out),
        .alu_out(mem_alu_out),
        .mem_write_ex(mem_write_ex),
        .reg_write_ex(reg_write_ex),
        .wb_src_ex(wb_src_ex),
        .wb_src_mm(wb_src_mm),
        .reg_write_mm(reg_write_mm),
        .Rdst_ex_out(Rdst_ex_out),
        .Rdst_mem_out(Rdst_mem_out)
    
    );

//write back mux
    write_back wb1(
        .a(mem_alu_out),
        .b(mem_out),
        .wb_src_mm(wb_src_mm),
        .write_back_data(write_back_data),
        .reg_write_mm(reg_write_mm),
        .reg_write_wb(reg_write_wb),
        .rdst_mem(Rdst_mem_out),
        .rdst_wb_out(rdst_wb_out)
    );
  assign out = write_back_data;
  assign stall_out =stall;
  assign forwardA_out = forwardA;
endmodule

