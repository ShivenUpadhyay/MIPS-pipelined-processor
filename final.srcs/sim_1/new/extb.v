`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 10:28:34
// Design Name: 
// Module Name: extb
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



module execution_unit_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] op_a;
    reg [31:0] op_b;
    reg [5:0] func;
    reg [31:0] const;
    reg alu_src_rr;
    reg wb_src_rr;
    reg mem_write_rr;
    reg reg_write_rr;

    // Outputs
    wire [31:0] result;
    wire [31:0] reg_read2;
    wire wb_src_ex;
    wire mem_write_ex;
    wire reg_write_ex;

    // Instantiate the Unit Under Test (UUT)
    execution_unit uut (
        .clk(clk),
        .reset(reset),
        .op_a(op_a),
        .op_b(op_b),
        .func(func),
        .result(result),
        .const(const),
        .reg_read2(reg_read2),
        .alu_src_rr(alu_src_rr),
        .wb_src_rr(wb_src_rr),
        .mem_write_rr(mem_write_rr),
        .reg_write_rr(reg_write_rr),
        .wb_src_ex(wb_src_ex),
        .mem_write_ex(mem_write_ex),
        .reg_write_ex(reg_write_ex)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize inputs
        $display("Starting testbench...");
        reset = 1;
        op_a = 32'd0;
        op_b = 32'd0;
        func = 6'b100000;  // Example: assume func 0 is ADD
        const = 32'd0;
        alu_src_rr = 0;
        wb_src_rr = 0;
        mem_write_rr = 0;
        reg_write_rr = 0;

        // Wait for global reset
        #10 reset = 0;

        // Test: ALU operation (e.g., addition: op_a + op_b)
        op_a = 32'd15;
        op_b = 32'd20;
        const = 32'd99;
        func = 6'b100000;  // Assume func 0 is ADD
        alu_src_rr = 0;    // Select op_b
        wb_src_rr = 1;
        mem_write_rr = 1;
        reg_write_rr = 1;

        #10;

        $display("ALU Result = %d (expected 35)", result);
        $display("reg_read2 = %d (expected 20)", reg_read2);
        $display("wb_src_ex = %b (expected 1)", wb_src_ex);
        $display("mem_write_ex = %b (expected 1)", mem_write_ex);
        $display("reg_write_ex = %b (expected 1)", reg_write_ex);

        // Test: ALU operation with const instead of op_b
        alu_src_rr = 1; // Use const
        func = 6'b100000; // Same ADD
        #10;

        $display("ALU Result = %d (expected 114)", result); // 15 + 99

        $stop;
    end

endmodule

