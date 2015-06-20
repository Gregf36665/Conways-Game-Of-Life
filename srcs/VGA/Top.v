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
    
    wire [9:0] y;
    wire [10:0] x;
	 wire [15:0] alive;
	 wire frame;    
    
    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(frame));
    
	 life_array_4x4 U_Array (.clk(clk),.reset(reset), .alive(alive), .row(row), .col(col),
									.val(val),.write_enb(write_enb),.scan(1'b0),.scan_write_val(1'b0),
									.scan_write_enb(1'b0), .scan_read_val(), .run(frame));
	 
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(100)) 
                 U_REC_GEN_1 (.x(x), .y(y), .enb(alive[0]),
                 .red(red), .green(green), .blue(blue));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(100)) 
                 U_REC_GEN_2 (.x(x), .y(y), .enb(alive[1]),
                 .red(red), .green(green), .blue(blue));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(300),.YPOS(100)) 
                 U_REC_GEN_3 (.x(x), .y(y), .enb(alive[2]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(100)) 
                 U_REC_GEN_4 (.x(x), .y(y), .enb(alive[3]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(200)) 
                 U_REC_GEN_5 (.x(x), .y(y), .enb(alive[4]),
                 .red(red), .green(green), .blue(blue));  
					  
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(200)) 
                 U_REC_GEN_6 (.x(x), .y(y), .enb(alive[5]),
                 .red(red), .green(green), .blue(blue));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(200)) 
                 U_REC_GEN_7 (.x(x), .y(y), .enb(alive[6]),
                 .red(red), .green(green), .blue(blue));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(400),.YPOS(200)) 
                 U_REC_GEN_8 (.x(x), .y(y), .enb(alive[7]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(300)) 
                 U_REC_GEN_9 (.x(x), .y(y), .enb(alive[8]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(300)) 
                 U_REC_GEN_10 (.x(x), .y(y), .enb(alive[9]),
                 .red(red), .green(green), .blue(blue));  
					  
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(300)) 
                 U_REC_GEN_11 (.x(x), .y(y), .enb(alive[10]),
                 .red(red), .green(green), .blue(blue));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(300)) 
                 U_REC_GEN_12 (.x(x), .y(y), .enb(alive[11]),
                 .red(red), .green(green), .blue(blue));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(100),.YPOS(400)) 
                 U_REC_GEN_13 (.x(x), .y(y), .enb(alive[12]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(400)) 
                 U_REC_GEN_14 (.x(x), .y(y), .enb(alive[13]),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(300),.YPOS(400)) 
                 U_REC_GEN_15 (.x(x), .y(y), .enb(alive[14]),
                 .red(red), .green(green), .blue(blue));  

	 RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(400)) 
                 U_REC_GEN_16 (.x(x), .y(y), .enb(alive[15]),
                 .red(red), .green(green), .blue(blue));  
endmodule
