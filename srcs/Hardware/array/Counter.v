`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/23/2015 10:25:16 AM
// Design Name: 
// Module Name: Counter
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


module Counter(
    input clk,
    input scan,
    input reset,
    output reg [3:0] count_val
    );
    
    always @(posedge clk) begin
        if (reset) count_val <= 0;
        else if (scan) count_val <= count_val + 1;
    end
    

endmodule
