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
	input  [3:0] selector, // for debugging, this will load a preset
	input	write_enb,
	input enb,
	input scan_enb
    );
    
     wire [10:0] y;
     wire [10:0] x;
	 wire [15:0] alive, val;
	 wire frame;
	 wire [11:0] rgb_1;
	 wire [11:0] rgb_2;
	 wire [11:0] rgb_3;
	 wire [11:0] rgb_4;
	
	 
	 wire run;    
					
	 assign red = rgb_1[11:8] ||
	              rgb_2[11:8] ||
	              rgb_3[11:8] ||
	              rgb_4[11:8];
					  
	assign green = rgb_1[7:4] ||
	               rgb_2[7:4] ||
	               rgb_3[7:4] ||
	               rgb_4[7:4];
				  
	assign blue = rgb_1[3:0] ||
	              rgb_2[3:0] ||
	              rgb_3[3:0] ||
	              rgb_4[3:0];
						

    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));
    
    Timer #(.COUNT_MAX(100000000)) U_TIMER(.clk(clk),.trigger(trigger));
    
    assign val = selector[0] ? 16'h3300 :
                 selector[1] ? 16'h33CC :
                 selector[2] ? 16'h0700 :
                 selector[3] ? 16'h6186 :
                               16'h0; 
    
    Display_4x4 U_DISP_1 (.x(x),.y(y),.alive(alive),.rgb(rgb_1),.cell_x(1'b0),.cell_y(1'b0));
    Display_4x4 U_DISP_2 (.x(x),.y(y),.alive(alive),.rgb(rgb_2),.cell_x(1'b1),.cell_y(1'b0));
    Display_4x4 U_DISP_3 (.x(x),.y(y),.alive(alive),.rgb(rgb_3),.cell_x(1'b0),.cell_y(1'b1));
    Display_4x4 U_DISP_4 (.x(x),.y(y),.alive(alive),.rgb(rgb_4),.cell_x(1'b1),.cell_y(1'b1));
    
    
    assign run = trigger & enb;
    
    assign scan = trigger & scan_enb;
    
    Counter U_COUNTER (.clk(clk), .scan(scan), .reset(reset), .count_val());
    
	life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(alive),
									.val(val),.write_enb(write_enb),.scan(scan),.scan_write_val(1'b0),
									.scan_write_enb(1'b0), .scan_read_val(), .run(run),
									.nw(1'b0), .ne(1'b0), .se(1'b0), .sw(1'b0),
									.n(4'b0), .e(4'b0), .s(4'b0), .w(4'b0) );
	 
endmodule
