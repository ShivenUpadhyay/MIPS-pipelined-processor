`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 10:55:08
// Design Name: 
// Module Name: mem_tb
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


`timescale 1ns / 1ps

module mem_stage_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] reg_read2;
    reg [31:0] alu_result;
    reg mem_write_ex;
    reg reg_write_ex;
    reg wb_src_ex;

    // Outputs
    wire [31:0] data_out;
    wire [31:0] alu_out;
    wire wb_src_mm;
    wire reg_write_mm;

    // Instantiate the mem_stage module
    mem_stage uut (
        .clk(clk),
        .reset(reset),
        .reg_read2(reg_read2),
        .alu_result(alu_result),
        .data_out(data_out),
        .alu_out(alu_out),
        .mem_write_ex(mem_write_ex),
        .reg_write_ex(reg_write_ex),
        .wb_src_ex(wb_src_ex),
        .wb_src_mm(wb_src_mm),
        .reg_write_mm(reg_write_mm)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10ns period (100MHz)
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1;
        reg_read2 = 0;
        alu_result = 0;
        mem_write_ex = 0;
        reg_write_ex = 0;
        wb_src_ex = 0;

        // Apply reset
        #10;
        reset = 0;

        // Test 1: Write 0xAABBCCDD to address 0x00000000 (big-endian)
        #10;
        mem_write_ex = 1;
        reg_write_ex = 1;
        wb_src_ex = 1;
        alu_result = 32'h00000000;  // Address
        reg_read2 = 32'hAABBCCDD;   // Data to write
        #10;
        mem_write_ex = 0;

        // Test 2: Read back from address 0x00000000 (should return 0xAABBCCDD)
        #10;
        alu_result = 32'h00000000;
        #10;
        if (data_out !== 32'hAABBCCDD) begin
            $display("ERROR: Read mismatch at addr 0x00000000. Expected 0xAABBCCDD, got 0x%h", data_out);
        end
        else begin
            $display("SUCCESS: Correctly read 0xAABBCCDD from addr 0x00000000");
        end

        // Test 3: Write 0x11223344 to address 0x00000004
        #10;
        mem_write_ex = 1;
        alu_result = 32'h00000004;
        reg_read2 = 32'h11223344;
        #10;
        mem_write_ex = 0;

        // Test 4: Read back from address 0x00000004 (should return 0x11223344)
        #10;
        alu_result = 32'h00000004;
        #10;
        if (data_out !== 32'h11223344) begin
            $display("ERROR: Read mismatch at addr 0x00000004. Expected 0x11223344, got 0x%h", data_out);
        end
        else begin
            $display("SUCCESS: Correctly read 0x11223344 from addr 0x00000004");
        end

        // Test 5: Check reset behavior
        #10;
        reset = 1;
        #10;
        reset = 0;
        #10;
        if (data_out !== 32'h0 || alu_out !== 32'h0 || reg_write_mm !== 1'b0 || wb_src_mm !== 1'b0) begin
            $display("ERROR: Reset failed. Outputs not cleared.");
        end
        else begin
            $display("SUCCESS: Reset correctly cleared outputs.");
        end

        // End simulation
        #10;
        $finish;
    end

    // Monitor changes
    initial begin
        $monitor(
            "Time = %0t | Addr = 0x%h | WriteData = 0x%h | ReadData = 0x%h | WriteEn = %b | Reset = %b",
            $time, alu_result, reg_read2, data_out, mem_write_ex, reset
        );
    end

endmodule


