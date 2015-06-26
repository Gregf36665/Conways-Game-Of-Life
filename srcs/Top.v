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
	input  [3:0] selector, // for debugging, this will load a preset
	input enb,
	output[3:0] leds
    );
    
    wire [10:0] y;
    wire [10:0] x;
	wire [15:0] alive_out, alive_in, alive_vga, val;
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
    
    Timer #(.COUNT_MAX(100000000)) U_TIMER_1_SEC(.clk(clk),.trigger(trigger));
    
    
    
    Display U_DISPLAY (.x(x), .y(y), .alive(alive_vga), .rgb(rgb), .array_pos(vga_array_pos));
    
    Block_Mem U_MEM (.clk(clk), .array_in_vga(vga_array_pos), .alive_out_vga(alive_vga),
                    .write_enb(write_mem), .array_selector(array_in_selector),
                    .alive_in_selector(alive_in),
                    .alive_out_selector(alive_out), .debug(selector[0]));
                    
    assign run = enb & fsm_run;
    
    
    Controller U_CONTROL (.clk(clk), .write_array(write_4x4), .run(fsm_run),
                          .pos(array_in_selector), .write_mem(write_mem),
                          .reset(reset));
    
	life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(alive_in),
									.val(alive_out),.write_enb(write_4x4),.run(run),
									.nw(1'b0), .ne(1'b0), .se(1'b0), .sw(1'b0),
									.n(4'b0), .e(4'b0), .s(4'b0), .w(4'b0));
	 
endmodule
