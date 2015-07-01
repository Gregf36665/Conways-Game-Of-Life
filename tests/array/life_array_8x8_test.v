`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:00:27 07/01/2015
// Design Name:   life_array_8x8
// Module Name:   U:/Excel/TSP/Conway/life_array_8x8_test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: life_array_8x8
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module life_array_8x8_test;

	// Inputs
	reg clk = 0;
	reg reset;
	reg [15:0] vali;
	reg [1:0] vali_selector;
	reg [1:0] valo_selector;
	reg write_enb;
	reg [7:0] n;
	reg [7:0] e;
	reg [7:0] s;
	reg [7:0] w;
	reg nw;
	reg ne;
	reg se;
	reg sw;
	reg step;

	// Outputs
	wire [15:0] valo;
    
    // Expected value

	// Instantiate the Unit Under Test (UUT)
	life_array_8x8 uut (
		.clk(clk), 
		.reset(reset), 
		.vali(vali), 
		.valo(valo), 
		.vali_selector(vali_selector), 
		.valo_selector(valo_selector), 
		.write_enb(write_enb), 
		.n(n), 
		.e(e), 
		.s(s), 
		.w(w), 
		.nw(nw), 
		.ne(ne), 
		.se(se), 
		.sw(sw), 
		.step(step)
	);

    always begin
        #5; clk = ~clk;
    end
    
	initial begin
		// Initialize Inputs
		reset = 1;
		vali = 0;
		vali_selector = 0;
		valo_selector = 0;
		write_enb = 0;
		n = 0;
		e = 0;
		s = 0;
		w = 0;
		nw = 0;
		ne = 0;
		se = 0;
		sw = 0;
		step = 0;

		// Wait 11 ns for global reset to finish
		#11;
        reset = 0;
        #10;
        
        $stop;
	end
      
endmodule

