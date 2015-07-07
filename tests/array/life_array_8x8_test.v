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
	wire [15:0] valo, valo_prev;
    
    // Expected value
    reg [15:0] expected_alive = 16'h0000;
    
	// Instantiate the Unit Under Test (UUT)
	life_array_8x8 uut (
		.clk(clk), 
		.reset(reset), 
		.vali(vali), 
		.valo(valo), 
        .valo_prev(valo_prev),
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
        
        // attempt to configure array 0 (TL) with an unstable config
        
        vali = 16'h0001; // select top left cell in the array
        vali_selector = 2'b00; // top left
        #10;
        write_enb = 1;
        valo_selector = 0;
        #10;
        write_enb = 0;
        expected_alive = 16'h0001;
        if(expected_alive != valo) begin
		    $display("Failed to write to top left cell only");
		    $stop;
		end
        $display("Basic configuration passed");
        
        // try to kill the cell
        #10;
        step = 1;
        #10;
        expected_alive = 16'h0000;
        if(expected_alive != valo) begin
		    $display("Single cell failed to die");
		    $stop;
		end
        $display("Cell death passes");
        step = 0;
        #10;
        
        // Create a block with one cell in each 4x4
        
        vali = 16'h8000; // bottom right cell
        vali_selector = 2'b00; // top left 4x4
        write_enb = 1;
        #10;
        vali = 16'h0008; // bottom left cell
        vali_selector = 2'b10; // top right 4x4
        #10;
        vali = 16'h0001; // top left cell
        vali_selector = 2'b11; // bottom right 4x4
        #10;
        vali = 16'h1000; // top right cell
        vali_selector = 2'b01; // bottom left 4x4
        #10;
        write_enb = 0;
        
        // Error testing in this set up
        valo_selector = 2'b00;
        expected_alive = 16'h8000;
        if(expected_alive != valo) begin
		    $display("Top left array for block failed to configure correctly");
		    $stop;
		end
        valo_selector = 2'b01;
        #10;
        expected_alive = 16'h1000;
        if(expected_alive != valo) begin
		    $display("Bottom left array for block failed to configure correctly");
		    $stop;
		end
        valo_selector = 2'b10;
        #10;
        expected_alive = 16'h0008;
        if(expected_alive != valo) begin
		    $display("Top right array for block failed to configure correctly");
		    $stop;
		end
        valo_selector = 2'b11;
        #10;
        expected_alive = 16'h0001;
        if(expected_alive != valo) begin
		    $display("Bottom right array for block failed to configure correctly");
		    $stop;
		end
        
        $display("Block configuration passed");
        
        // see if it is stable
        step = 1;
        #10;
        step = 0;
        
        // Error testing after step
        valo_selector = 2'b00;
        #10;
        expected_alive = 16'h8000;
        if(expected_alive != valo) begin
		    $display("Top left array for block failed to stabilize");
		    $stop;
		end
        valo_selector = 2'b01;
        #10;
        expected_alive = 16'h1000;
        if(expected_alive != valo) begin
		    $display("Bottom left array for block failed to stabilize");
		    $stop;
		end
        valo_selector = 2'b10;
        #10;
        expected_alive = 16'h0008;
        if(expected_alive != valo) begin
		    $display("Top right array for block failed to stabilize");
		    $stop;
		end
        valo_selector = 2'b11;
        #10;
        expected_alive = 16'h0001;
        if(expected_alive != valo) begin
		    $display("Bottom right array for block failed to stabilize");
		    $stop;
		end
        
        // reset
        #10;
        reset = 1;
        step = 0;
        #10;
        reset = 0;
        
        // Test previous value
        $display("Testing previous values");
        vali = 16'h0025;
        vali_selector = 2'b00;
        valo_selector = 2'b00;
        write_enb = 1;
        #10;
        write_enb = 0;
        #10;
        expected_alive = 16'h0025;
        if(expected_alive != valo_prev) begin
		    $display("Previous value failed to be set during write");
		    $stop;
		end
        step = 1;
        #10;
        expected_alive = 16'h0025;
        if(expected_alive != valo_prev) begin
		    $display("Previous value failed to stay the same");
		    $stop;
		end
        step = 0;
        #10;
        step = 1;
        #10;
        expected_alive = 16'h0022;
        if(expected_alive != valo_prev) begin
		    $display("Previous value failed to update");
		    $stop;
		end
        step = 0;
        #10;
        step = 1;
        #10;
        expected_alive = 16'h0000;
        if(expected_alive != valo_prev) begin
		    $display("Previous value failed to die");
		    $stop;
		end
        step = 0;
        
        $display("Testing edges");
        reset = 1;
        step = 0;
        #10;
        reset = 0;
        ne = 1;
        se = 1;
        sw = 1;
        nw = 1;
        n = 8'h81;
        e = 8'h81;
        s = 8'h81;
        w = 8'h81;
        #10;
        step = 1;
        #10;
        expected_alive = 16'h0001;
        valo_selector = 2'b00;
        #10;
        if(expected_alive != valo) begin
		    $display("Top left corner failed to spawn");
		    $stop;
		end
        #10;
        expected_alive = 16'h0008;
        valo_selector = 2'b01;
        #10;
        if(expected_alive != valo) begin
		    $display("Bottom left corner failed to spawn");
		    $stop;
		end
        #10;
        expected_alive = 16'h1000;
        valo_selector = 2'b10;
        #10;
        if(expected_alive != valo) begin
		    $display("Top right corner failed to spawn");
		    $stop;
		end
        #10;
        expected_alive = 16'h8000;
        valo_selector = 2'b11;
        #10;
        if(expected_alive != valo) begin
		    $display("Bottom right corner failed to spawn");
		    $stop;
		end
        
        $display("Corner edges passed");
        
        nw = 0;
        ne = 0;
        se = 0;
        sw = 0;
        n = 8'h3C;
        e = 8'h3C;
        s = 8'h3C;
        w = 8'h3C;
        step = 0;
        reset = 1;
        #10;
        reset = 0;
        #10;
        
        $display("Testing middle of edges");
        step = 1;
        #10;
        #10;
        expected_alive = 16'h1008;
        valo_selector = 2'b00;
        #10;
        if(expected_alive != valo) begin
		    $display("Tile 0 failed to spawn correctly");
		    $stop;
		end
        #10;
        expected_alive = 16'h8001;
        valo_selector = 2'b01;
        #10;
        if(expected_alive != valo) begin
		    $display("Tile 1 failed to spawn correctly");
		    $stop;
		end
        #10;
        expected_alive = 16'h8001;
        valo_selector = 2'b10;
        #10;
        if(expected_alive != valo) begin
		    $display("Tile 2 failed to spawn correctly");
		    $stop;
		end
        #10;
        expected_alive = 16'h1008;
        valo_selector = 2'b11;
        #10;
        if(expected_alive != valo) begin
		    $display("Tile 3 failed to spawn correctly");
		    $stop;
		end
        
        
        
        $display("All tests passed");
        $stop;
        
        
	end
      
endmodule

