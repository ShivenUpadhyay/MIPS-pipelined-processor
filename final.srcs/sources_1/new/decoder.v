`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:53:13
// Design Name: 
// Module Name: decoder
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


module decoder(    
    input wire [31:0] inst,  
    input wire [31:0] PC,
    output wire [4:0] Rdst,
    output wire [4:0] Rsrc1,
    output wire [4:0] Rsrc2,
    output wire [4:0] shamt,
   output wire [5:0] func_inst,
    output wire [20:0] const,
    output wire [25:0] addr,
    output wire [3:0] bits,
    output wire [5:0] op_code,
    output wire [15:0] offset
    );    

  
    assign op_code = inst[31:26];
    assign Rdst = inst[25:21];
    assign Rsrc1 = inst[20:16];
    assign Rsrc2 = inst[15:11];
    assign shamt = inst[10:6];
    assign func_inst = inst[5:0];
    assign const = inst[20:0];
    assign addr = inst[25:0];
   assign bits = PC[31:28];
   assign offset = inst[15:0];
    
endmodule

