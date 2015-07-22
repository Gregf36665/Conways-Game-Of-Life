`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2015 04:50:06 PM
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
    input [7:0] sw,
    output [7:0] leds
    );
    
    pe_array ARRAY (.clk(clk),
                    .reset(sw[0]),
                    .cmd(sw[2:1]),
                    .adr_x(sw[6]),
                    .adr_y(sw[7]),
                    .state_in(1'b1),
                    .state_out(leds[0])
                    );
                    
   assign leds[7:6] = sw[7:6];
                    
endmodule
