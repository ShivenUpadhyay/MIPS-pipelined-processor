`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 18:12:02
// Design Name: 
// Module Name: Inst_mem
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


module inst_mem(
   
    input [31:0] PC,
    input wire reset,
    output wire [31:0] inst
    );
    
    reg [7:0] mem [36:0];
    assign inst = {mem[PC],mem[PC+1],mem[PC+2],mem[PC+3]};   
    
   
    always @ ( posedge reset) begin
   if(reset) begin
        //NANDI
        {mem[0], mem[1], mem[2], mem[3]}   = 32'b001110_00011_01000_0000000000001000;  // 0x39030008
        
        // sub R6, R6, R6
        {mem[4], mem[5], mem[6], mem[7]}   = 32'b000000_00110_00110_00110_00000_100010; // 0x00C63022
        
        // lw R2, 12(R1)
        {mem[8], mem[9], mem[10], mem[11]} = 32'b100011_00010_00001_0000000000001100;   // 0x8C22000C
        
        // sub R5, R3, R7
        {mem[12], mem[13], mem[14], mem[15]} = 32'b000000_00101_00011_00111_00000_100010; // 0x00672822
        
        // add R4, R2, R5
        {mem[16], mem[17], mem[18], mem[19]} = 32'b000000_00100_00010_00101_00000_100000; // 0x00452020
        
        // j L1 (target address 0x1C)
        {mem[20], mem[21], mem[22], mem[23]} = 32'b000010_00000000000000000000000111;    // 0x08000007
        
        // sub R3, R4, R5 (skipped)
        {mem[24], mem[25], mem[26], mem[27]} = 32'b000000_00011_00100_00101_00000_100010; // 0x00851822
        
        // L1: sub R1, R2, R11
        {mem[28], mem[29], mem[30], mem[31]} = 32'b000000_00001_00010_01011_00000_100010;
        //sw R3, (R2)
        {mem[32], mem[33], mem[34], mem[35]} = 32'b101011_00011_00010_0000000000000000; // 0x004B0822
   end    
    end

endmodule
