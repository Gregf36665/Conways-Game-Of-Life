`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Engineer: Greg Flynn and Craig Lombardo
//
// Create Date: 2014-11-20
// Module Name:    RecGenerator 
// Project Name: 	 Pong
// Target Devices: Spartan 3
// Description:
//    This module creates the top and bottom walls which are a 
//		specified height and are the width of the screen.
// 
//	Dependencies:
//    None
//
////////////////////////////////////////////////////////////////////////////////
module RecGenerator(input [10:0] x, input [9:0] y, input enb,
					output [3:0] red,output [3:0] green,output [3:0] blue);
	 parameter XPOS = 100;
	 parameter YPOS = 100;
	 parameter WIDTH = 100;	 
	 parameter HEIGHT = 100;
	 parameter RVAL = 0;
	 parameter GVAL = 0;
	 parameter BVAL = 0;
	  
	 assign red = enb && (XPOS < x) && (XPOS+WIDTH > x ) && (YPOS < y) && (YPOS+HEIGHT > y ) ? RVAL : 0;
	 
	 assign green = enb && (XPOS < x) && (XPOS+WIDTH > x ) && (YPOS < y) && (YPOS+HEIGHT > y ) ? GVAL : 0;
	 
	 assign blue = enb && (XPOS < x) && (XPOS+WIDTH > x ) && (YPOS < y) && (YPOS+HEIGHT > y ) ? BVAL : 0;
	 
endmodule
