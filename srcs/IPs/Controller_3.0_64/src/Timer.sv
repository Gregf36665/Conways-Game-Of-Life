`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/20/2015 07:34:08 PM
// Design Name: 
// Module Name: Timer
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


module Timer(
    input clk,
    input [31:0] delay,
    output reg trigger
    );
    
    reg [31:0] count;
    
    always @(posedge clk) begin
        count <= count + 1;
        if (count == delay) begin
            trigger <= 1;
            count <= 0;
        end
        else trigger <= 0;
   end
   
endmodule
