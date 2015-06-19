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
    output Hsync,
    output Vsync,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue
    );
    
    wire [9:0] y;
    wire [10:0] x;
    
    
    VESADriver U_MONITOR(.clk(clk),.Hsyncb(Hsync), .Vsyncb(Vsync), .x(x), .y(y),.frame(1'b0));
    
    RecGenerator #(.RVAL(4'hf),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(100),.YPOS(100)) 
                 U_REC_GEN_1 (.x(x), .y(y),
                 .red(red), .green(green), .blue(blue));   
                 
    RecGenerator #(.RVAL(4'he),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(200),.YPOS(100)) 
                 U_REC_GEN_2 (.x(x), .y(y),
                 .red(red), .green(green), .blue(blue));  
                                  
    RecGenerator #(.RVAL(4'h8),.GVAL(4'b0),.BVAL(4'b0),
                 .XPOS(300),.YPOS(100)) 
                 U_REC_GEN_3 (.x(x), .y(y),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'h4),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(400),.YPOS(100)) 
                 U_REC_GEN_4 (.x(x), .y(y),
                 .red(red), .green(green), .blue(blue));  

    RecGenerator #(.RVAL(4'b1),.GVAL(4'b0),.BVAL(4'b0),
                   .XPOS(500),.YPOS(100)) 
                 U_REC_GEN_5 (.x(x), .y(y),
                 .red(red), .green(green), .blue(blue));  

endmodule
