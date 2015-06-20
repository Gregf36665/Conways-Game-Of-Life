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
	 input        val,
	 input		  write_enb
    );
    
    wire [10:0] y;
    wire [10:0] x;
	 wire [15:0] alive;
	 wire frame;    
	 
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
					
	 assign red = red_1 || red_2 || red_3 || red_4 ||
					  red_5 || red_6 || red_7 || red_8 ||
					  red_9 || red_10 || red_11 || red_12 ||
					  red_13 || red_14 || red_15 || red_16;
					  
	 assign green = green_1 || green_2 || green_3 || green_4 ||
					    green_5 || green_6 || green_7 || green_8 ||
					    green_9 || green_10 || green_11 || green_12 ||
					    green_13 || green_14 || green_15 || green_16;
					  
	 assign blue = blue_1 || blue_2 || blue_3 || blue_4 ||
					   blue_5 || blue_6 || blue_7 || blue_8 ||
					   blue_9 || blue_10 || blue_11 || blue_12 ||
					   blue_13 || blue_14 || blue_15 || blue_16;
						
	 assign alive = 16'hf;
    
    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));
    
	 life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(/*alive*/), .row(row), .col(col),
									.val(val),.write_enb(write_enb),.scan(1'b0),.scan_write_val(1'b0),
									.scan_write_enb(1'b0), .scan_read_val(), .run(frame));
	 
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(100)) 
                 U_REC_GEN_1 (.x(x), .y(y), .enb(alive[0]),
                 .red(red_1), .green(green_1), .blue(blue_1));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(100)) 
                 U_REC_GEN_2 (.x(x), .y(y), .enb(alive[1]),
                 .red(red_2), .green(green_2), .blue(blue_2));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(300),.YPOS(100)) 
                 U_REC_GEN_3 (.x(x), .y(y), .enb(alive[2]),
                 .red(red_3), .green(green_3), .blue(blue_3));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(100)) 
                 U_REC_GEN_4 (.x(x), .y(y), .enb(alive[3]),
                 .red(red_4), .green(green_4), .blue(blue_4));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(200)) 
                 U_REC_GEN_5 (.x(x), .y(y), .enb(alive[4]),
                 .red(red_5), .green(green_5), .blue(blue_5));  
					  
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(200)) 
                 U_REC_GEN_6 (.x(x), .y(y), .enb(alive[5]),
                 .red(red_6), .green(green_6), .blue(blue_6));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(200)) 
                 U_REC_GEN_7 (.x(x), .y(y), .enb(alive[6]),
                 .red(red_7), .green(green_7), .blue(blue_7));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(400),.YPOS(200)) 
                 U_REC_GEN_8 (.x(x), .y(y), .enb(alive[7]),
                 .red(red_8), .green(green_8), .blue(blue_8));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(300)) 
                 U_REC_GEN_9 (.x(x), .y(y), .enb(alive[8]),
                 .red(red_9), .green(green_9), .blue(blue_9));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(300)) 
                 U_REC_GEN_10 (.x(x), .y(y), .enb(alive[9]),
                 .red(red_10), .green(green_10), .blue(blue_10));  
					  
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(300)) 
                 U_REC_GEN_11 (.x(x), .y(y), .enb(alive[10]),
                 .red(red_11), .green(green_11), .blue(blue_11));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(300)) 
                 U_REC_GEN_12 (.x(x), .y(y), .enb(alive[11]),
                 .red(red_12), .green(green_12), .blue(blue_12));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(100),.YPOS(400)) 
                 U_REC_GEN_13 (.x(x), .y(y), .enb(alive[12]),
                 .red(red_13), .green(green_13), .blue(blue_13));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(400)) 
                 U_REC_GEN_14 (.x(x), .y(y), .enb(alive[13]),
                 .red(red_14), .green(green_14), .blue(blue_14));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(400)) 
                 U_REC_GEN_15 (.x(x), .y(y), .enb(alive[14]),
                 .red(red_15), .green(green_15), .blue(blue_15));  

	 RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(400)) 
                 U_REC_GEN_16 (.x(x), .y(y), .enb(alive[15]),
                 .red(red_16), .green(green_16), .blue(blue_16));  
endmodule
