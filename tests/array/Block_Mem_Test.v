`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:50:49 06/25/2015
// Design Name:   Block_Mem
// Module Name:   U:/Excel/TSP/Conway/Block_Mem_Test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Block_Mem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Block_Mem_Test;

	// Inputs
	reg clk = 0;
	reg debug;
	reg [1:0] array_in_vga;
	reg write_enb;
	reg [1:0] array_selector;
	reg [15:0] alive_in_selector;

	// Outputs
	wire [15:0] alive_out_vga;
	wire [15:0] alive_out_selector;


	// Expected alive for error testing
	reg [15:0] expected_alive;
	
		 
	// Instantiate the Unit Under Test (UUT)
	Block_Mem uut (
		.clk(clk), 
		.debug(debug), 
		.array_in_vga(array_in_vga), 
		.alive_out_vga(alive_out_vga), 
		.write_enb(write_enb), 
		.array_selector(array_selector), 
		.alive_in_selector(alive_in_selector), 
		.alive_out_selector(alive_out_selector)
	);
	
	always begin
		#5; clk = ~clk;
	end
	
	// Keep changing the vga alive value
	always @(posedge clk) 
		array_in_vga = array_in_vga + 1;
		

	initial begin
		// Initialize Inputs
		debug = 0;
		array_in_vga = 0;
		write_enb = 0;
		array_selector = 0;
		alive_in_selector = 0;

		// Wait 11 ns for global reset to finish
		#11;
        
		// Add stimulus here
		
		// set to debug settings
		debug = 1;
		expected_alive = 16'hC813;
		#10;
		debug = 0;
		if(expected_alive != alive_out_selector) begin
         $display("Error with debug memory location 0!");       
         $stop;
      end
		expected_alive = 16'h338C;
		array_selector = 1;
		#10;
		if(expected_alive != alive_out_selector) begin
         $display("Error with debug memory location 1!");      
         $stop;
      end
		expected_alive = 16'h33CC;
		array_selector = 2;
		#10;
		if(expected_alive != alive_out_selector) begin
         $display("Error with debug memory location 0!");        
         $stop;
      end
		expected_alive = 16'h6186;
		array_selector = 3;
		#10;
		if(expected_alive != alive_out_selector) begin
         $display("Error with debug memory location 0!");        
         $stop;
      end
		#10;
		array_selector = 0;
		#20;
        
        $display("All passed");
		$stop;
		
	end
      
endmodule

