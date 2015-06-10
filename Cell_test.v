`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:48:11 06/03/2015
// Design Name:   life_cell
// Module Name:   U:/Excel/TSP/Conway/Cell_test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: life_cell
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Cell_test;

	// Inputs
	reg clk;
	reg reset;
	reg n;
	reg ne;
	reg e;
	reg se;
	reg s;
	reg sw;
	reg w;
	reg nw;
	reg write;
	reg val;
	reg enb;

	// Outputs
	wire alive;

	// Instantiate the Unit Under Test (UUT)
	life_cell uut (
		.clk(clk), 
		.reset(reset), 
		.n(n), 
		.ne(ne), 
		.e(e), 
		.se(se), 
		.s(s), 
		.sw(sw), 
		.w(w), 
		.nw(nw), 
		.write(write), 
		.val(val), 
		.enb(enb), 
		.alive(alive)
	);

	always begin
	#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		n = 0;
		ne = 0;
		e = 0;
		se = 0;
		s = 0;
		sw = 0;
		w = 0;
		nw = 0;
		write = 0;
		val = 0;
		enb = 0;

		// Wait 10 ns for global reset to finish
		#10;
        
		// reset the cell
		reset = 1;
		#10;
		reset = 0;
		#10;
		// activate it
		enb = 1;
		#10;
		// bring it to life
		n = 1;
		e = 1;
		s = 1;
		#10;
		// keep it alive
		s = 0;
		#10;
		// kill it
		n = 0;
		#10;
		
		// deactivate it
		enb = 0;
		# 10;
		
		//set it alive
		write = 1;
		val = 1;
		# 10;
		write = 0;
		
		// does it stay alive
		s = 1;
		#10;
		enb = 1;
		#50;
		
		// now kill it again
		s = 0;
		#20;
		
		
		$stop;

	end
      
endmodule

