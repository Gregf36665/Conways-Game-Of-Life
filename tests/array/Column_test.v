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
// Revision 0.02 - Added in scan test
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
	reg [3:0] val;
	reg enable;
	
	reg [3:0] expected_alive;

	// Outputs
	wire [3:0] alive_col;
	wire [3:0] alive_prev_col;
    

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
		.alive_col(alive_col), 
        .alive_prev_col(alive_prev_col),
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
		enable = 0;

		// Wait 11 ns for global reset to finish
		#11;
      reset = 0;  
		// Add stimulus here
		
		expected_alive = 4'b0;
		if(expected_alive != alive_col) begin
         $display("Error with column reset!");        
         $stop;
      end
		
		// enable the column
		enable = 1;
		#10;
		
		//Bring the top cell to life
		n = 1;
		e_col = 4'b0001;
		w_col = 4'b0001;
		#10;
		expected_alive = 4'b1;
		if(expected_alive != alive_col) begin
         $display("Error with bringing cell to life!");        
         $stop;
      end
		// this will enable the cell beneath it to come to life
	   // which will overcrowd the first cell killing it
		// this is now stable
		#10;
		expected_alive = 4'b11;
		if(expected_alive != alive_col) begin
         $display("Error with logically creating a cell!");        
         $stop;
      end
		#50;
		expected_alive = 4'b10;
		if(expected_alive != alive_col) begin
         $display("Error with keeping a column alive!");        
         $stop;
      end
		
		// disable col
		enable = 0;
		#10;
		// kill all other cells
		n = 0;
		e_col = 4'b0;
		w_col = 4'b0;
		
		// bring the entire column to life
		val = 4'hf;
		write_enb = 1;
		#10;
		write_enb = 0;
		#10;
		
		expected_alive = 4'b1111;
		if(expected_alive != alive_col) begin
         $display("Error with write creating a cell!");        
         $stop;
      end
		// watch the column die
		enable = 1;
		
		#50;
		expected_alive = 4'b0;
		if(expected_alive != alive_col) begin
         $display("Error with death column survived!");        
         $stop;
      end
		
        
        // test previous state
        
        write_enb = 0;
        reset = 1;
        #10;
        expected_alive = 4'b0;
		if(expected_alive != alive_prev_col) begin
            $display("Error with reset for alive previous!");        
            $stop;
        end
        reset = 0;
        e_col = 4'b0111;
        enable = 1;
        #10;
        e_col = 4'b0;
        expected_alive = 4'b0010;
		if(expected_alive != alive_col) begin
            $display("Error with logical spawn for alive!");        
            $stop;
        end
        #10;
        expected_alive = 4'b0010;
		if(expected_alive != alive_prev_col) begin
            $display("Error with logical spawn for alive previous!");        
            $stop;
        end
        #10;
        expected_alive = 4'b0000;
		if(expected_alive != alive_prev_col) begin
            $display("Error with death for alive previous!");        
            $stop;
        end

        
        $display("All tests pass");
		$stop;
		

	end
      
endmodule

