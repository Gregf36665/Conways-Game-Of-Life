`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:29:20 06/25/2015
// Design Name:   Controller
// Module Name:   U:/Excel/TSP/Conway/Controller_test.v
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

module Controller_test;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire write_array;
	wire run;
	wire [1:0] pos;
	wire write_mem;
	
	reg [1:0] expected_pos;

	// Instantiate the Unit Under Test (UUT)
	Controller uut (
		.clk(clk), 
		.reset(reset),
		.write_array(write_array), 
		.run(run), 
		.pos(pos), 
		.write_mem(write_mem)
	);

	always begin
	#5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		expected_pos = 0;

		// Wait 11 ns for global reset to finish
		#11;
		reset = 0;
        
		// Step along and see what state we are in
		// vs what we expect to be in
		
		// S0.0
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 0.0 passed");
		#10;
		
		// S0.1
		if(!write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 0.1 passed");
		#10;
		
		// S0.2
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 0.2 passed");
		#10;
		
		// S0.3
		if(write_array) $stop;
		if(run) $stop;
		if(!write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 0.3 passed");
		expected_pos = 1;
		#10;
		
		// S1.0
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 1.0 passed");
		#10;
		
		// S1.1
		if(!write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 1.1 passed");
		#10;
		
		// S1.2
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 1.2 passed");
		#10;
		
		// S1.3
		if(write_array) $stop;
		if(run) $stop;
		if(!write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 1.3 passed");
		expected_pos = 2;
		#10;
		
		// S2.0
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 2.0 passed");
		#10;
		
		// S2.1
		if(!write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 2.1 passed");
		#10;
	
		// S2.2
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 2.2 passed");
		#10;
		
		// S2.3
		if(write_array) $stop;
		if(run) $stop;
		if(!write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 2.3 passed");
		expected_pos = 3;
		#10;
		
		// S3.0
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 3.0 passed");
		#10;
		
		// S3.1
		if(!write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 3.1 passed");
		#10;
		
		// S3.2
		if(write_array) $stop;
		if(run) $stop;
		if(write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 3.2 passed");
		#10;
		
		// S3.3
		if(write_array) $stop;
		if(run) $stop;
		if(!write_mem) $stop;
		if(expected_pos != pos) begin
         $display("Error with state 0.0");
			$display("Expected %d, found %d",expected_pos,pos);
         $stop;
      end
		$display("State 3.3 passed");
		#10;

		$stop;

	end
      
endmodule

