`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 17:33:06
// Design Name: 
// Module Name: top2_tb
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

module top2_tb();

    reg clk;
    reg reset;
   // wire [31:0] write_back_data;

    // Instantiate the processor
    top2 dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, top2_tb);
end


    // Memory initialization
    initial begin
        // Initialize data memory (big-endian)
        dut.mem_stage1.data_mem1.mem[12] = 8'hAA;
         dut.mem_stage1.data_mem1.mem[13] = 8'hBB; 
          dut.mem_stage1.data_mem1.mem[14] = 8'hCC; 
           dut.mem_stage1.data_mem1.mem[15] = 8'hDD;   // Address 0xC
//        dut.dat.mem[13] = 8'hBB;
//        dut.data_mem1.mem[14] = 8'hCC;
//        dut.data_mem1.mem[15] = 8'hDD;
    end

    // Test sequence
    initial begin
        // Initialize registers through hierarchical access
        $display("Initializing...");
        reset = 1;
        #10;
        reset = 0;
        
        // Allow time for program execution
        #200;  // ~20 cycles
        
        // Check register values
        $display("\nFinal Register Values:");
        check_register(1, "R1");
        check_register(2, "R2");
        check_register(3, "R3");
        check_register(4, "R4");
        check_register(5, "R5");
        check_register(6, "R6");
        check_register(11, "R11");
        
        $finish;
    end

    task check_register;
        input [4:0] regnum;
        input [80:0] regname;
        begin
            $display("%s = 0x%h", regname, 
                    dut.reg_read1.reg_file1.registers[regnum]);
        end
    endtask

    // Monitor pipeline progress
    always @(posedge clk) begin
        if (!reset) begin
            $display("Cycle %0d: PC=0x%h, Instr=0x%h",
                    $time/10, dut.fetch1.pc1.PC, dut.fetch1.inst_curr);
        end
    end
    

endmodule