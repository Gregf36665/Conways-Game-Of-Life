`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2015 11:19:05 AM
// Design Name: 
// Module Name: Display_4x4
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


module Display(
    input [10:0] x,
    input [10:0] y,
    input [15:0] alive,
    output [11:0] rgb,
    output [1:0] array_pos
    );
    
    wire [3:0] pos;
    wire draw;
    wire [11:0] color;
    
    assign array_pos = {x[9] , y[9]};
    
    assign pos[1:0] = y[8:7];
    assign pos[3:2] = x[8:7];
    
                         
    assign draw = alive[pos[3:0]];
    
    assign out_of_range = x[10] == 1'b1 || y[10] == 1'b1;
    
    assign rgb = draw & ~out_of_range ? color : 0;
    
    // Just to get some patterns
    assign color[11:8] = {4{( x[9] | ~y[9])} };
    assign color[7:4] =  {4{(~x[9] |  y[9])} };
    assign color[3:0] =  {4{( x[9] &  y[9])} };
    
endmodule
