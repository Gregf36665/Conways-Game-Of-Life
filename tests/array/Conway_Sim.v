`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2015 03:08:57 PM
// Design Name: 
// Module Name: Conway_Sim
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
// 
//////////////////////////////////////////////////////////////////////////////////


module Conway_Sim;

    task display_life;
      input [15:0] alive;
      integer i,j;
      for (i = 0; i < 4; i = i + 1) begin
         for (j = 0; j < 4; j = j + 1) begin
            $write("%b",alive[4*i+j]);
         end
         $display();
      end
      
    endtask
            
    reg clk = 1;
    wire [15:0] alive;
    reg reset = 0;
    reg [15:0] val;
    reg write_enb;
    reg step = 0;
	 reg scan = 0;
	 reg [3:0] n = 4'b0,
				  e = 4'b0,
				  s = 4'b0,
				  w = 4'b0;
				  
	 reg nw = 0,
		  ne = 0,
		  se = 0,
		  sw = 0;
	 
    reg [15:0] expected_alive;
    
    always #5 clk = ~clk;   
      
    life_array_4x4 arr (.clk(clk),
                        .reset(reset),
                        .alive(alive),
                        .val(val),
                        .write_enb(write_enb),
                        .step(step),
								.n(n),
								.e(e),
								.s(s),
								.w(w),
								.nw(nw),
								.ne(ne),
								.se(se),
								.sw(sw)
                        );
								
    initial begin
	   // reset everything
      reset = 1;
      #10;
      reset = 0;
      #11;
		
		// write to the top left cell only
		val = 16'h0001;
		expected_alive = 16'h0001;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write to top left cell only");
		    $stop;
		end
		#10;
		
		// check it dies
		step = 1; 
		#10;
		expected_alive = 16'h0;
		if(expected_alive != alive) begin
		    $display("Top left cell failed to die");
		    $stop;
		end
		
		step = 0;
		$display("Top left passed");
		
		// write a horizontal line
		val = 16'h0011;
		expected_alive = 16'h0011;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write to horizontal line");
		    $stop;
		end
		#10;
		
		// check it dies
		step = 1; 
		#10;
		expected_alive = 16'h0;
		if(expected_alive != alive) begin
		    $display("Horizontal line failed to die");
		    $stop;
		end
		
		step = 0;
		$display("Horizontal line passed");
		
		// write a vertical line
		val = 16'h0002;
		expected_alive = 16'h0002;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write to vertical line");
		    $stop; 
		end
		#10;
		
		// check it dies
		step = 1; 
		#10;
		expected_alive = 16'h0;
		if(expected_alive != alive) begin
		    $display("Vertical line failed to die");
		    $stop;
		end
		
		step = 0;
		$display("Vertical line passed");
		
		// write a blinker
		val = 16'h0070;
		expected_alive = 16'h0070;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write blinker");
		    $stop; 
		end
		#10;
		
		// check it doesn't die
		step = 1; 
		#10;
		expected_alive = 16'h0222;
		if(expected_alive != alive) begin
		    $display("Blinker failed to blink");
		    $stop;
		end
		
		#10;
		// test step (nothing should have changed)
		if(expected_alive != alive) begin
		    $display("Cell went to next generation when it shouldn't have");
		    $stop;
		end
		
		step = 0;
		$display("Blinker passed");
      
		// write a block
		val = 16'h0660;
		expected_alive = 16'h0660;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write block");
		    $stop; 
		end
		#10;
		
		// check it doesn't die
		step = 1; 
		#10;
		if(expected_alive != alive) begin 
		    $display("Block failed to stay the same");
		    $stop;
		end
		
		$display("Block passed");
		
		// write a beacon
		val = 16'hCC33;
		expected_alive = 16'hCC33;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write beacon");
			 $display("Warning, could be due to write_enb not resetting toggle");
		    $stop; 
		end
		#10;
		
		// check it doesn't die
		step = 1; 
		#10;
		expected_alive = 16'hC813;
		if(expected_alive != alive) begin
		    $display("Beacon failed to blink");
		    $stop;
		end
		
		#10;
		// test step (nothing should have changed)
		if(expected_alive != alive) begin
		    $display("Cell went to next generation when it shouldn't have");
		    $stop;
		end
		$display("Beacon passed");
		
		// write a beehive
		val = 16'h6996;
		expected_alive = 16'h6996;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write beehive");
		    $stop; 
		end
		#10;
		
		// check it doesn't die
		step = 1; 
		#10;
		if(expected_alive != alive) begin
		    $display("Beehive failed to stay static");
		    $stop;
		end
		
		// write a toad
		val = 16'h6186;
		expected_alive = 16'h6186;
		#10;
		write_enb = 1;
		#10;
		write_enb = 0;
		if(expected_alive != alive) begin
		    $display("Failed to write toad");
		    $stop; 
		end
		#10;
		
		// check it doesn't die
		step = 1; 
		#10;
		expected_alive = 16'h2664;
		if(expected_alive != alive) begin
		    $display("Toad failed to blink");
		    $stop;
		end
		
		#10;
		// test step (nothing should have changed)
		if(expected_alive != alive) begin
		    $display("Cell went to next generation when it shouldn't have");
		    $stop;
		end

		$display("Toad passed");
		
		
		$stop;
	end
   
endmodule

