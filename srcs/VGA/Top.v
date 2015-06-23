`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
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
	input  [1:0] row,
	input  [1:0] col,
	input  val,
	input	write_enb,
	input enb,
	input scan_enb
    );
    
     wire [10:0] y;
     wire [10:0] x;
	 wire [15:0] alive;
	 wire frame;
	 wire [11:0] rgb;
	
	 
	 wire run;    
					
	 assign red = rgb[11:8];
					  
	assign green = rgb[7:4];
				  
	assign blue = rgb[3:0];
						

    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));
    
    Timer #(.COUNT_MAX(100000000)) U_TIMER(.clk(clk),.trigger(trigger));
    
    Display_4x4 U_DISP(.x(x),.y(y),.alive(alive),.rgb(rgb));
    
    
    assign run = trigger & enb;
    
    assign scan = trigger & scan_enb;
    
    Counter U_COUNTER (.clk(clk), .scan(scan), .reset(reset), .count_val());
    
	life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(alive), .row(row), .col(col),
									.val(val),.write_enb(write_enb),.scan(scan),.scan_write_val(1'b0),
									.scan_write_enb(1'b0), .scan_read_val(), .run(run),
									.nw(1'b0), .ne(1'b0), .se(1'b0), .sw(1'b0),
									.n(4'b0), .e(4'b0), .s(4'b0), .w(4'b0) );
	 
endmodule
