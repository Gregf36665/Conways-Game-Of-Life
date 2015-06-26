`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:16:36 06/26/2015
// Design Name:   Controller
// Module Name:   U:/Excel/TSP/Conway/Controller_Run_test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Controller
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Controller_Run_test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire write_array;
	wire run;
	wire [1:0] pos;
	wire write_mem;

	// Instantiate the Unit Under Test (UUT)
	Controller #(.DELAY(16)) uut (
		.clk(clk), 
		.reset(reset), 
		.write_array(write_array), 
		.run(run), 
		.pos(pos), 
		.write_mem(write_mem)
	);
	
	always begin
		#5; clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here
		reset = 0;
		#640;
		$stop;
	end
      
endmodule

