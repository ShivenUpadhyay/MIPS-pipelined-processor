`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2025 10:26:04
// Design Name: 
// Module Name: reg_filetb
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

module reg_read_tb;

    // Inputs
    reg clk;
    reg reset;
    reg [31:0] const;
    reg [31:0] write_back_data;
    reg write_e;
    reg [4:0] Rdst, Rsrc1, Rsrc2, shamt;
    reg [5:0] func;
    reg wb_src_id, alu_src_id, reg_write_id, mem_write_id;

    // Outputs
    wire [31:0] op_a, op_b, const_out;
    wire [4:0] shamt_out;
    wire [5:0] func_out;
    wire wb_src_rr, alu_src_rr, reg_write_rr, mem_write_rr;

    // Instantiate the module
    reg_read uut (
        .clk(clk),
        .reset(reset),
        .op_a(op_a),
        .op_b(op_b),
        .const(const),
        .const_out(const_out),
        .write_back_data(write_back_data),
        .write_e(write_e),
        .Rdst(Rdst),
        .Rsrc1(Rsrc1),
        .Rsrc2(Rsrc2),
        .shamt(shamt),
        .shamt_out(shamt_out),
        .func(func),
        .func_out(func_out),
        .wb_src_id(wb_src_id),
        .alu_src_id(alu_src_id),
        .reg_write_id(reg_write_id),
        .mem_write_id(mem_write_id),
        .wb_src_rr(wb_src_rr),
        .alu_src_rr(alu_src_rr),
        .reg_write_rr(reg_write_rr),
        .mem_write_rr(mem_write_rr)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $display("Starting testbench...");
        // Initial values
        reset = 1;
        const = 32'hABCD1234;
        write_back_data = 32'h12345678;
        write_e = 0;
        Rdst = 5'd2;
        Rsrc1 = 5'd2;
        Rsrc2 = 5'd3;
        shamt = 5'd1;
        func = 6'b101010;
        wb_src_id = 1;
        alu_src_id = 1;
        reg_write_id = 1;
        mem_write_id = 0;

        #10 reset = 0;

        // Write to register 2
        write_e = 1;
        Rdst = 5'd2;
        write_back_data = 32'hCAFEBABE;
        #10 write_e = 0;

        // Read from register 2 and 3
        Rsrc1 = 5'd2;
        Rsrc2 = 5'd3;

        #20;

        $display("op_a = %h", op_a);
        $display("op_b = %h", op_b);
        $display("const_out = %h", const_out);
        $display("func_out = %b", func_out);
        $display("shamt_out = %d", shamt_out);
        $display("wb_src_rr = %b", wb_src_rr);
        $display("alu_src_rr = %b", alu_src_rr);
        $display("reg_write_rr = %b", reg_write_rr);
        $display("mem_write_rr = %b", mem_write_rr);

        $stop;
    end
endmodule

