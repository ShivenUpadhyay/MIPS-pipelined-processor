`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 20:51:11
// Design Name: 
// Module Name: execution_unit
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


module execution_unit(
    input clk,
    input reset,
    input [31:0] op_a,
    input [31:0] op_b,
    input [5:0] func,
    output reg [31:0] result,
    input [31:0] const,
    output reg [31:0] reg_read2,
    input alu_src_rr,
    input wb_src_rr,   
    input mem_write_rr,
    input reg_write_rr,
    output reg wb_src_ex,
    output reg mem_write_ex,
    output reg reg_write_ex,
    
    input [31:0] MEM_OUT,
    input [1:0] sel1,
    input [1:0] sel2,
    input [4:0] Rdst_rr_out,
    output reg [4:0] Rdst_ex_out,
    input memread_rr,
    output reg memread_ex,
    input [31:0] ALU_OUT  
    );  
    
   
    
     wire [31:0] result_w,oparand;
     wire [31:0] mux_1,mux_2;
    assign oparand = alu_src_rr ? const : mux_2;    
    
alu alu1(   
    .op_a(mux_1),
    .op_b(oparand),
    .ctrl(func),
    .shamt(5'd0),  
    .zero(),    
    .result(result_w)
);

fwd_mux2 mux2(

    .ALU_OUT(ALU_OUT),
     .mux_2(mux_2),
    .WB_OUT(MEM_OUT),
    .op_b(op_b),
    .sel2(sel2)
    );
    
    fwd_mux1 mux1(

    .ALU_OUT(ALU_OUT),
    .mux_1(mux_1),
    .WB_OUT(MEM_OUT),
    .op_a(op_a),
    .sel1(sel1)
    );

always@(posedge clk or posedge reset) begin
if(reset) begin
    result<=32'b0;
    reg_read2<=32'b0;
    wb_src_ex<=0;
    mem_write_ex<=0;
    reg_write_ex<=0;
    Rdst_ex_out<=5'b0;
    memread_ex<=0;
end
else begin
    result<=result_w;
    reg_read2<=op_b;
    wb_src_ex<=wb_src_rr;
    mem_write_ex<=mem_write_rr;
    reg_write_ex<=reg_write_rr;
    Rdst_ex_out<=Rdst_rr_out;
    memread_ex<=memread_rr;
    end
end

endmodule

