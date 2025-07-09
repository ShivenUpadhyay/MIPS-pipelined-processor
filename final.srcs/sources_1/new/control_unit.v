`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2025 14:44:33
// Design Name: 
// Module Name: control_unit
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


module control_unit(
    input [5:0] opcode,
    output reg jmp_src,
    output reg alu_src,
    output reg reg_write,
    output reg wb_src,
    output reg mem_write,
    output reg [5:0] func,
    input [5:0] func_inst,    
    output reg memread,
    output reg offset_flag,
    output reg store_word_flag
);

    parameter LW    = 6'b100011,
              SW    = 6'b101011,
              SUB   = 6'b000000,
              NANDI = 6'b001110,
              JMP   = 6'b000010,
              ADD   = 6'b100000;
    always @(*) begin
        memread<=0;
       offset_flag<=0;
       store_word_flag<=0;
       //wb_src=1(ALU),0=mem_out
       //ALU_Src=1(const), 0(op_b)
        case(opcode) 
            LW: begin
                jmp_src   <= 0;
                reg_write <= 1;
                alu_src   <= 1; 
                mem_write <= 0;
                wb_src    <= 0;
                func      <= 6'b100000;
                memread <=1; 
                offset_flag<=1;
                
            end
            SW: begin
                jmp_src   <= 0;
                reg_write <= 0;
                alu_src   <= 1; 
                mem_write <= 1;
                wb_src    <= 1;
                store_word_flag<=1;
                func      <= 6'b100000; //(add)(reg+offset to get mem addr)
                
            end
            SUB: begin
                jmp_src   = 0;
                reg_write = 1;
                alu_src   = 0;
                mem_write = 0;
                wb_src    = 1;//w
                func      = func_inst; 
         
            end
            NANDI: begin
                jmp_src   = 0;
                reg_write = 1;
                alu_src   = 1;
                mem_write = 0;    
                wb_src    = 1;
                func      = opcode;  
            end
            JMP: begin
                jmp_src   = 1;
                reg_write = 0;
                alu_src   = 0;
                mem_write = 0;
                wb_src    = 0;
                func      = 6'b100000;
            end
             ADD: begin
                jmp_src   = 0;
                reg_write = 1;
                alu_src   = 1;
                mem_write = 0;
                wb_src    = 1;
                func      = func_inst;
                end
            default: begin
                jmp_src   = 0;
                reg_write = 0;
                alu_src   = 0;
                mem_write = 0;
                wb_src    = 0;
                func      = 6'b000000;
            end
        endcase
    end
endmodule
