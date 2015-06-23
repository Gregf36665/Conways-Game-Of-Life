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
    output [11:0] rgb,
    input cell_x, 
    input cell_y
    );
    
    wire [3:0] pos;
    wire draw;
    
    
    assign pos[1:0] = y[8:7];
    assign pos[3:2] = x[8:7];
    
                         
    assign draw = (cell_x == x[9] && cell_y == y[9]) ? alive[pos[3:0]] : 0;
    
    assign out_of_range = x[10] == 1'b1 || y[10] == 1'b1;
    
    assign rgb = draw & ~out_of_range ? 12'hFFF : 0;
    
endmodule
