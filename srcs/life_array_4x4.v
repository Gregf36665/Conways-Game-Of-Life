module life_array_4x4(input clk,
		      input reset,
		      output [15:0] alive,
		      input [1:0] row,
		      input [1:0] col,
		      input val,
		      input write_enb,
		      input run // set this high to start running the tiles

		      );


   // internal connections
    wire [3:0] 		    alive_col0, alive_col1, alive_col2, alive_col3;
	assign alive = {alive_col3,alive_col2,alive_col1,alive_col0};
	
	assign write_0 = write_enb & (col == 2'd0);
    assign write_1 = write_enb & (col == 2'd1);
    assign write_2 = write_enb & (col == 2'd2);
    assign write_3 = write_enb & (col == 2'd3);
   

     life_col4 COL0 (.clk(clk), .reset(reset), .n(1'b0), .ne(1'b0), .e_col(alive_col1),
		 .se(1'b0), .s(1'b0) , .sw(1'b0), .w_col(4'b0), .nw(1'b0),
		 .val(val),  .write_enb(write_0), .row(row), .enable(run),
 		 .alive_col(alive_col0));

     life_col4 COL1 (.clk(clk), .reset(reset), .n(1'b0), .ne(1'b0), .e_col(alive_col2),
		 .se(1'b0), .s(1'b0) , .sw(1'b0), .w_col(alive_col0), .nw(1'b0),
		 .val(val), .write_enb(write_1), .row(row), .enable(run),
 		 .alive_col(alive_col1));

     life_col4 COL2 (.clk(clk), .reset(reset), .n(1'b0), .ne(1'b0), .e_col(alive_col3),
         .se(1'b0), .s(1'b0) , .sw(1'b0), .w_col(alive_col1), .nw(1'b0),
         .val(val), .write_enb(write_2), .row(row), .enable(run),
 		 .alive_col(alive_col2));
 		 
     life_col4 COL3 (.clk(clk), .reset(reset), .n(1'b0), .ne(1'b0), .e_col(4'b0),
          .se(1'b0), .s(1'b0) , .sw(1'b0), .w_col(alive_col2), .nw(1'b0),
          .val(val), .write_enb(write_3), .row(row), .enable(run),
          .alive_col(alive_col3));
                 


endmodule // life_array_4x4
