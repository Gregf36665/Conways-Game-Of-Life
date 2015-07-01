`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Engineer: Greg Flynn
// 
// Create Date: 06/08/2015 10:42:10 AM
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input reset,
    output Hsync,
    output Vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    input debug,
    input enb,
    output[3:0] leds
    );
    
    wire [10:0] y;
    wire [10:0] x;
    wire [15:0] alive_vga, val;
    wire [1:0] vga_array_pos, array_in_selector;
    wire frame;
    wire [11:0] rgb;

    assign leds[1:0] = array_in_selector;
    assign leds[3:2] = vga_array_pos;
	 
    wire run;    
					
    assign red = rgb[11:8];
					  
    assign green = rgb[7:4];
				  
    assign blue = rgb[3:0];
	
    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));   
    
    
    Display U_DISPLAY (.x(x), .y(y), .alive(alive_vga), .rgb(rgb), .array_pos(vga_array_pos));
    
                    
    
    life_array_8x8 (.clk(clk),
                    .reset(reset),
                    .vali(value),
                    .valo(alive_vga),
                    .valo_selector(vga_array_pos),
                    .write_enb(write),
                    .step(enb),
                    .n(8'b0),
                    .e(8'b0),
                    .s(8'b0),
                    .w(8'b0),
                    .nw(1'b0),
                    .ne(1'b0),
                    .se(1'b0),
                    .sw(1'b0)
                    );
	 
endmodule
