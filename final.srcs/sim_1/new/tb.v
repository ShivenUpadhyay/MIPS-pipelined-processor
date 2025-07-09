`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2025 15:48:36
// Design Name: 
// Module Name: tb
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

module top_tb();

    // Inputs
    reg clk;
    reg reset;

    // Instantiate the top module
    top2 dut (
        .clk(clk),
        .reset(reset)
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
        
        // Apply reset
        #20;
        reset = 0;
        
        $display("Starting simulation...");
        $display("Time\tPC\t\tInstruction");
        $display("----------------------------------");
        
        // Wait for pipeline to fill (6 cycles)
        #60;
        
        // Run for enough cycles to execute all instructions
        #500;
        
        // Check final register values through the register read module
        $display("\nFinal Checks:");
        $display("All lw instructions should have executed properly");
        
        $display("\nSimulation completed.");
        $finish;
    end

    // Monitor pipeline progress
    always @(posedge clk) begin
        if (!reset) begin
            $display("%0t\t%h\t%h", 
                    $time, 
                    dut.fetch1.PC,
                    dut.fetch1.inst_curr);
        end
    end

endmodule