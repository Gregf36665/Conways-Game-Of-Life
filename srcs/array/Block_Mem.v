`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2015 02:50:39 PM
// Design Name: 
// Module Name: Block_Mem
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


module Block_Mem(
    input clk,
    input debug,
    input [1:0] array_in_vga,
    output [15:0] alive_out_vga,
    input write_enb,
    input [1:0] array_selector,
    input [15:0] alive_in_selector,
    output [15:0] alive_out_selector
    );
    
    reg [15:0] MEM [3:0];
    reg [1:0] selector_loc;
    
    
    assign alive_out_vga = MEM[array_in_vga];
    
    always @(posedge clk) begin
        if (debug) begin
            MEM[0] <= 16'h0600;
            MEM[1] <= 16'h3300;
            MEM[2] <= 16'h33CC;
            MEM[3] <= 16'h6186;
        end
        else begin
            selector_loc <= array_selector;
            if (write_enb)
                MEM[array_selector] <= alive_in_selector;
        end
    end
    
    assign alive_out_selector = MEM[selector_loc];

endmodule
