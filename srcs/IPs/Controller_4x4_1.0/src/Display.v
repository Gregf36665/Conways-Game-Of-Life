`timescale 1ns / 1ps
`include "pe_array_decs.sv"
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
    input [15:0] alive_prev,
    output [11:0] rgb,
    output [1:0] array_pos,
    input color_enb
    );
    
    parameter DEAD = 2'b00, JUST_DEAD = 2'b10,
              JUST_ALIVE = 2'b01, ALIVE = 2'b11;
              
    wire [3:0] pos;
    reg [11:0] color;
    
    assign array_pos = {x[9] , y[9]};
    
    assign pos[1:0] = y[8:7];
    assign pos[3:2] = x[8:7];
    
                         
    assign is_alive = alive[pos[3:0]];
    assign was_alive = alive_prev[pos[3:0]];
    
    assign out_of_range = x[10] == 1'b1 || y[10] == 1'b1;
    
    assign rgb = ~out_of_range ? color : 0;
    
    // Color coded cells based on previous lives
    always @* begin
        if (color_enb)
            case({was_alive,is_alive})
                DEAD:
                    color = 12'h000;
                JUST_DEAD:
                    color = 12'hF00;
                JUST_ALIVE:
                    color = 12'hFF0;
                ALIVE:
                    color = 12'h0F0;
            endcase
        else
            color = is_alive? 12'hFFF : 12'h000;
    end
            
    
endmodule
