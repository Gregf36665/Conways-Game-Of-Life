`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:05:04 06/03/2015
// Design Name:   life_col4
// Module Name:   U:/Excel/TSP/Conway/Column_test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: life_col4
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Column_test;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] w_col;
	reg [3:0] e_col;
	reg n;
	reg s;
	reg ne;
	reg nw;
	reg se;
	reg sw;
	reg write_enb;
	reg val;
	reg [1:0] row;
	reg enable;

	// Outputs
	wire [3:0] alive_col;

	// Instantiate the Unit Under Test (UUT)
	life_col4 uut (
		.clk(clk), 
		.reset(reset), 
		.w_col(w_col), 
		.e_col(e_col), 
		.n(n), 
		.s(s), 
		.ne(ne), 
		.nw(nw), 
		.se(se), 
		.sw(sw), 
		.write_enb(write_enb), 
		.val(val), 
		.row(row), 
		.alive_col(alive_col), 
		.enable(enable)
	);

	always begin
	#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		w_col = 0;
		e_col = 0;
		n = 0;
		s = 0;
		ne = 0;
		nw = 0;
		se = 0;
		sw = 0;
		write_enb = 0;
		val = 0;
		row = 0;
		enable = 0;

		// Wait 10 ns for global reset to finish
		#10;
      reset = 0;  
		// Add stimulus here
		
		// enable the column
		enable = 1;
		#10;
		
		//Bring the top cell to life
		n = 1;
		e_col = 4'b0001;
		w_col = 4'b0001;
		#10;
		// this will enable the cell beneath it to come to life
	   // which will overcrowd the first cell killing it
		// this is now stable
		#50;
		
		// disable row
		enable = 0;
		#10;
		// kill all other cells
		n = 0;
		e_col = 4'b0;
		w_col = 4'b0;
		
		// bring the entire column to life
		val = 1;
		write_enb = 1;
		# 10;
		row = 1;
		#10;
		row = 2;
		#10;
		row = 3;
		#10;
		write_enb = 0;
		#10;
		
		// watch the column die
		enable = 1;
		
		#50;
		
		$stop;
		

	end
      
endmodule

