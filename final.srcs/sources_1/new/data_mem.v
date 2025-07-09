`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.03.2025 21:26:18
// Design Name: 
// Module Name: data_mem
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


module data_memory(
    input clk,
    input reset,
    input [31:0] address,
    input [31:0] write_data,
    input write_e,
    output [31:0] read_out
);
    reg [7:0] mem [0:1023];  
    wire [9:0] addr = address[9:0];
    
    assign read_out = {mem[addr], mem[addr+10'd1], mem[addr+10'd2], mem[addr+10'd3]};
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            
            for (i = 0; i < 1024; i = i + 1) begin
                mem[i] <= 8'h00;
            end
             
               mem[10'd12]<=8'h00;
                mem[10'd13]<=8'h00;
                 mem[10'd14]<=8'h00;
                  mem[10'd15]<=8'h00;
        end
        else if (write_e) begin
        mem[addr]     <= write_data[31:24];
        mem[addr+1]   <= write_data[23:16];
        mem[addr+2]   <= write_data[15:8];
        mem[addr+3]   <= write_data[7:0];
        end
    end
endmodule
