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
	 
	 wire run;    
	 
	 wire [3:0] red_1,red_2,red_3,red_4,
					red_5,red_6,red_7,red_8,
					red_9,red_10,red_11,red_12,
					red_13,red_14,red_15,red_16;
					
	 wire [3:0] green_1,green_2,green_3,green_4,
					green_5,green_6,green_7,green_8,
					green_9,green_10,green_11,green_12,
					green_13,green_14,green_15,green_16;
					
	 wire [3:0] blue_1,blue_2,blue_3,blue_4,
					blue_5,blue_6,blue_7,blue_8,
					blue_9,blue_10,blue_11,blue_12,
					blue_13,blue_14,blue_15,blue_16;
					
	 assign red = 4'b0;
					  
	 assign green = 4'b0;
					  
	 assign blue = 4'b0;
						

    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));
    
    Timer #(.COUNT_MAX(100000000)) U_TIMER(.clk(clk),.trigger(trigger));
    
    assign run = trigger & enb;
    
    assign scan = trigger & scan_enb;
    
    Counter U_COUNTER (.clk(clk), .scan(scan), .reset(reset), .count_val());
    
	life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(alive), .row(row), .col(col),
									.val(val),.write_enb(write_enb),.scan(scan),.scan_write_val(1'b0),
									.scan_write_enb(1'b0), .scan_read_val(), .run(run),
									.nw(1'b0), .ne(1'b0), .se(1'b0), .sw(1'b0),
									.n(4'b0), .e(4'b0), .s(4'b0), .w(4'b0) );
	 
endmodule
