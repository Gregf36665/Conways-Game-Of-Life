`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/24/2015 04:36:50 PM
// Design Name: 
// Module Name: Controller
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


module Controller(
    input clk,
    input run_enb,
	input reset,
    output write_array,
    output run,
    output [1:0] pos,
    output write_mem
    );
    
    reg [3:0] state;
    reg run_output_enb;
    
    assign pos = state[3:2];
    
    assign write_array = state[1:0] == 2'b01;
    assign run       =   (state[1:0] == 2'b10) & run_output_enb;
    assign write_mem =   state[1:0] == 2'b11;
    
    always @(posedge clk) begin
        if(reset) state <= 0;
		else state <= state + 1;
        if(state == 0) run_output_enb <= run_enb;
    end
    
endmodule
