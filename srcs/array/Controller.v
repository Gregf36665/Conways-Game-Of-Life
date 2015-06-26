`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Lafayette College
// Engineer: Greg Flynn
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
// In the end this should be moved into the PS
//////////////////////////////////////////////////////////////////////////////////


module Controller(
    input clk,
	input reset,
    output write_array,
    output run,
    output [1:0] pos,
    output write_mem
    );
    
    parameter DELAY = 99999999; // set the pause time for the enable signal
                                // default 1 clk cycle less than 1 sec
    
    reg [3:0] state;
    reg run_output_enb;
    reg [31:0] timer;
    
    assign pos = state[3:2];
    
    assign write_array = state[1:0] == 2'b01;
    assign run       =   (state[1:0] == 2'b10) & run_output_enb;
    assign write_mem =   state[1:0] == 2'b11;
    
    always @(posedge clk) begin
        if(reset) state <= 0;
		else state <= state + 1;
    end
    
    // Pulse for running simulator
    always @(posedge clk)
        if (reset) begin
            timer <= 0;
            run_output_enb <= 0;
        end
        else begin
				if(timer == (DELAY + 16) )  begin
                timer <= 0;
                run_output_enb <= 0;
            end
				else if(timer >= DELAY) begin
                run_output_enb <= 1;
                timer <= timer + 1;
            end
            else timer <= timer + 1;
        end
    
endmodule
