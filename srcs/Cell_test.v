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
// Revision 0.02 - Added in scan test
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
	reg scan;
	reg scan_val;
	
  reg expected_alive;
	
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
		.scan(scan),
		.scan_val(scan_val),
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
		scan = 0;
		scan_val = 0;

		// Wait 11 ns for global reset to finish
		#11;
        
		// reset the cell
		reset = 1;
		#10;
		reset = 0;
		#10;
		
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Error with cell reset!");        
         $stop;
      end
		
		// activate it
		enb = 1;
		#10;
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Cell unexpectedly came to life!");      
         $stop;
      end
		
		// bring it to life
		n = 1;
		e = 1;
		s = 1;
		#10;
		expected_alive = 1;
		if(expected_alive != alive) begin
         $display("Cell failed to come to life!");        
         $stop;
      end
		// keep it alive
		s = 0;
		#10;
		expected_alive = 1;
		if(expected_alive != alive) begin
         $display("Cell failed to stay alive!");        
         $stop;
      end
		
		// kill it
		n = 0;
		#10;
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Cell failed to die!");       
         $stop;
      end
		
		// deactivate it
		enb = 0;
		# 10;
		
		//set it alive
		write = 1;
		val = 1;
		# 10;
		write = 0;
		expected_alive = 1;
		if(expected_alive != alive) begin
         $display("Write to cell failed!");       
         $stop;
      end
		
		// does it stay alive
		s = 1;
		#10;
		enb = 1;
		#50;
		expected_alive = 1;
		if(expected_alive != alive) begin
         $display("Cell died when it should be disabled!");         
         $stop;
      end
		
		// now kill it again
		s = 0;
		#10;
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Cell failed to die");
         $stop;
      end
		
		// test scan
		scan_val = 1;
		#10;
		scan = 1;
		#10;
		expected_alive = 1;
		if(expected_alive != alive) begin
         $display("Scan failed");     
         $stop;
      end
		
		scan_val = 0;
		#10
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Scan failed");     
         $stop;
      end
		
		scan = 0;
		scan_val = 1;
		
		#10;
		expected_alive = 0;
		if(expected_alive != alive) begin
         $display("Scan should be disabled");     
         $stop;
      end
		#20;
		$stop;

	end
      
endmodule

