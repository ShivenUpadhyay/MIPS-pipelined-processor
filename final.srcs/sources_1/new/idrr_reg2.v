    `timescale 1ns / 1ps
    //////////////////////////////////////////////////////////////////////////////////
    // Company: 
    // Engineer: 
    // 
    // Create Date: 15.04.2025 13:15:34
    // Design Name: 
    // Module Name: idrr_reg2
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
    
    
    module idrr_reg2(
    
        input wire clk,
        input wire rst,
        input wire stall,
        input wire flush,
        input wire [4:0] Rdst,
        input wire [4:0] Rsrc1,
        input wire [4:0] Rsrc2,
        input wire [4:0] shamt,
        input wire [5:0] func,
        input wire [31:0] const,
        input wire [5:0] op_code,  
        input wire alu_src,
        input wire reg_write,
        input wire mem_write,
        input wire wb_src,
        output reg [4:0] Rdst_out,
        output reg [4:0] Rsrc1_out,
        output reg [4:0] Rsrc2_out,
        output reg [4:0] shamt_out,
        output reg [5:0] func_out,
        output reg [31:0] const_out,
        output reg [5:0] op_code_out,
        output reg alu_src_dec,
        output reg reg_write_dec,
        output reg mem_write_dec,
        output reg wb_src_dec,
        input jmp_src,
        
        output reg jmp_src_out,
        input memread,
        output reg memread_dec,
        input [31:0] jmp_addr_in,
        output reg [31:0] jmp_addr,
        output reg store_word_flag,
        input store_word_flag_in
        
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst || flush || stall) begin
            Rdst_out <= 5'b0;
            Rsrc1_out <= 5'b0;
            Rsrc2_out <= 5'b0;
            shamt_out <= 5'b0;
            func_out <= 6'b0;
            const_out <= 32'b0;
            op_code_out <= 6'b0;
            alu_src_dec <= 1'b0;
            reg_write_dec <= 1'b0;
            mem_write_dec <= 1'b0;
            wb_src_dec <= 1'b0;
            jmp_src_out <= 1'b0;
            jmp_addr<=32'b0;
            memread_dec<=0;
            store_word_flag<=0;
        end else if (!stall) begin
            Rdst_out <= Rdst;
            Rsrc1_out <= Rsrc1;
            Rsrc2_out <= Rsrc2;
            shamt_out <= shamt;
            func_out <= func;
            const_out <= const;
            op_code_out <= op_code;
            alu_src_dec <= alu_src;
            reg_write_dec <= reg_write;
            mem_write_dec <= mem_write;
            wb_src_dec <= wb_src;
            jmp_src_out <= jmp_src;
            memread_dec <= memread;
            jmp_addr<=jmp_addr_in;
            store_word_flag<=store_word_flag_in;
        end
      
        end
    
    endmodule
