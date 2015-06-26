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
	 wire scan_read_val;
    reg reset = 0;
    reg [1:0] row, col;
    reg val;
    reg write_enb;
    reg enb = 0;
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
                        .row(row),
                        .col(col),
                        .val(val),
                        .write_enb(write_enb),
                        .run(enb),
								.scan(scan),
								.scan_write_val(1'b0),
								.scan_write_enb(1'b0),
								.scan_read_val(scan_read_val),
								.n(n),
								.e(e),
								.s(s),
								.w(w),
								.nw(nw),
								.ne(ne),
								.se(se),
								.sw(sw)
                        );
								
   
    initial
    begin
       // reset everything
      reset = 1;
       #10
      reset = 0;
      #10
      
      // disable the grid during configuration
      enb = 0;
      
      // select top left only
      
      row = 0;
      col = 0;
      val = 1;
      write_enb = 1;
      #10;
      write_enb = 0;
      expected_alive = 15'b1;
      #50;
      
      @(posedge clk) #1; // offset by 1 time period
      
      // does enable work
      if(expected_alive != alive) begin
         $display("Error with basic steady state!");
         display_life(alive);         
         $stop;
      end
      
      // check it dies
      enb = 1;
      #20;
      expected_alive = 15'b0;
      #10;
		#100;
      if(expected_alive != alive) begin
         $display("Error with death, lone cell survived!");
         display_life(alive);
         $stop;
      end
      
      // try a line of 2 going down
      enb = 0;
      write_enb = 1;
      #10;
      
      row = 0;
      col = 0;
      val = 1;
   
      #10;
      row = 1;
      
      #10;
      write_enb = 0;
      expected_alive = 15'b11;
      #10;
      if(expected_alive != alive) begin
         $display("Error with vertical line formation");
         display_life(alive);
         $stop;
      end
      
      // let them die
      enb = 1;
      
      #30;
      
      expected_alive = 15'b0;
      if(expected_alive != alive) begin
         $display("Error with death, vertical line survived!");
         display_life(alive);
         $stop;
      end
      
      // try a line of 2 going across
      enb = 0;
      write_enb = 1;
      
      row = 0;
      col = 0;
   
      #10;
      col = 1;
      
      #10;
      write_enb = 0;
      expected_alive = 16'h0011;
      #20;
      if(expected_alive != alive) begin
         $display("Error with horizontal line formation on first row");
         display_life(alive);
         $stop;
      end
      
      // let them die
      enb = 1;
      
      #30;
      
      expected_alive = 15'b0;
      if(expected_alive != alive) begin
         $display("Error with death, horizontal line survived on the first row!"); 
         display_life(alive);
         $stop;
      end
            
      // try a line of 2 going across on the second row
      enb = 0;
      row = 1;
      col = 0;
      write_enb = 1;
   
      #10;
      col = 1;
      
      #10;
      write_enb = 0;
      expected_alive = 16'h0022;
      #20;
      if(expected_alive != alive) begin
         $display("Error with horizontal line formation on the second row"); 
         display_life(alive);
         $stop;
      end
      
      // let them die
      enb = 1;
      
      #30;
      
      expected_alive = 15'b0;
      if(expected_alive != alive) begin
         $display("Error with death, horizontal line survived on the second row!"); 
         display_life(alive);
         $stop;
      end      
      
      // configure for line of 3, should oscillate
      /*
      oooo      oXoo
      XXXo  <-> oXoo
      oooo      oXoo
      oooo      oooo
      */
      enb = 0;
      write_enb = 1;
      row = 1;
      col = 0;
   
      #10;
      col = 1;
      
      #10;
      col = 2;
      #10;
      
      write_enb = 0;
      expected_alive = 16'h0222;
      #20;
      if(expected_alive != alive) begin
         $display("Error with blinker formation"); 
         display_life(alive);
         $stop;
      end
      
      // let them start
      enb = 1;
      expected_alive = 16'h0070;
      
      #100;
      
      if(expected_alive != alive) begin
         // assume out by one period
         #10;
      end
      
      if(expected_alive != alive) begin
         $display("Error with oscillation, blinker fails"); 
         display_life(alive);
         $stop;
      end
      
      $display("PASSED: Configuration 'Blinker'");
      
      // configure for 'block', should be stable
      /*
      oooo
      oXXo
      oXXo
      oooo
      */
      
      enb = 0;
      
      // reset the array
      reset = 1;
      #10;
      reset = 0;
      
      #10;
      write_enb = 1;
      row = 1;
      col = 1;
      val = 1;
   
      #10;
      col = 2;
      
      #10;
      row = 2;
      
      #10;
      col = 1;
      
      #10;
      
      write_enb = 0;
      expected_alive = 16'h0660;
      #20;
      if(expected_alive != alive) begin
         $display("Error with block formation"); 
         display_life(alive);
         $stop;
      end
      
      // let them start
      enb = 1;
      
      #100;
      
      if(expected_alive != alive) begin
         $display("Error with stabliliy, block fails"); 
         display_life(alive);
         $stop;
      end
      
      $display("PASSED: Configuration 'Block'");
      
      // configure for 'beehive', should be stable
      /* 
      oXXo
      XooX
      XooX
      oXXo
      */
      enb = 0;
      
      // reset the array
      reset = 1;
      row = 1;
      col = 0;
      
      #10;
      reset = 0;
      
      write_enb = 1;
      row = 1;
      col = 0;
      
      #10;
      row = 2;
      
      #10;
      col = 1;
      row = 0;
      
      #10;
      row = 3;

      #10;
      col = 2;
      row = 3;
      
      #10;
      row = 0;
      col = 2;
      
      #10;
      col = 3;
      row = 1;
      
      #10;
      row = 2;
      
      #10;

      write_enb = 0;
      expected_alive = 16'h6996;
      #20;
      if(expected_alive != alive) begin
         $display("Error with beehive formation"); 
         display_life(alive);
         $stop;
      end
      
      // let them start
      enb = 1;
      
      #100;
      
      if(expected_alive != alive) begin
         $display("Error with stabliliy, beehive fails"); 
         display_life(alive);
         $stop;
      end
      
      $display("PASSED: Configuration 'Beehive'");

      // configure for 'Beacon', should be period 2
      /* 
      XXoo     XXoo
      XXoo <-> Xooo
      ooXX     oooX
      ooXX     ooXX
      */
      enb = 0;
      
      // reset the array
      reset = 1;
      row = 0;
      col = 0;
      
      #10;
      reset = 0;
      write_enb = 1;
      
      #10;
      row = 1;
      
      #10;
      col = 1;
      
      #10;
      row = 0;

      #10;
      col = 2;
      row = 2;

      #10;
      row = 3;
      
      #10;
      col = 3;
      
      #10;
      row = 2;
      
      #10;

      write_enb = 0;
      expected_alive = 16'hCC33;
      #20;
      if(expected_alive != alive) begin
         $display("Error with beacon formation"); 
         display_life(alive);
         $stop;
      end
      
      // let them start
      enb = 1;
      
      expected_alive = 16'hC813;
      
      #100;
      
      if(expected_alive != alive) begin
         // assume out by one period
         #10;
      end
      
      if(expected_alive != alive) begin
         $display("Error with oscillation, beacon fails"); 
         display_life(alive);
         $stop;
      end
      
      $display("PASSED: Configuration 'Beacon'");   

      // configure for 'Toad', should be period 2
      /* 
      ooXo     oooo
		XooX <-> oXXX
		XooX     XXXo
		oXoo     oooo
      */
      enb = 0;
      
      // reset the array
      reset = 1;
      row = 1;
      col = 0;
      
      #10;
      reset = 0;
      write_enb = 1;
      
      #10;
		row = 2;
		
		#10;
		col = 1;
		row = 3;
		
		#10;
		col = 2;
		row = 0;
		
		#10;
		col = 3;
		row = 1;
		
		#10;
		row = 2;
      
      #10;

      write_enb = 0;
      expected_alive = 16'h6186;
      #20;
      if(expected_alive != alive) begin
         $display("Error with toad formation"); 
         display_life(alive);
         $stop;
      end
      
      // let them start
      enb = 1;
      
      expected_alive = 16'h2664;
      
      #100;
      
      if(expected_alive != alive) begin
         // assume out by one period
         #10;
      end
      
      if(expected_alive != alive) begin
         $display("Error with oscillation, toad fails"); 
         display_life(alive);
         $stop;
      end
      
      $display("PASSED: Configuration 'Toad'");         
      
      $display("Good run");
      $stop;
   end
   
endmodule

