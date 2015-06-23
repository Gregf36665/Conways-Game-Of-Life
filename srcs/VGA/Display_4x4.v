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


module Display_4x4(
    input [10:0] x,
    input [10:0] y,
    input [15:0] alive,
    output [11:0] rgb
    // input cell_x, input cell_y
    );
    
    wire [4:0] pos;
    wire draw;
    
    
    assign pos[1:0] = x[3:2];
    assign pos[3:2] = y[3:2];
    
    assign pos[4] = (x>>4 > 0 || y>>4 > 0);
    
    assign draw = pos[4] == 1 ? 0 : alive[pos[3:0]];
    
    assign rgb = draw ? 12'hFFF : 0;
    
endmodule
