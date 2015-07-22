//-----------------------------------------------------------------------------
// Title         : life_array
// Project       : TSP - Tiled Spatial Processing
//-----------------------------------------------------------------------------
// File          : life_array_4x4.v
// Author        : John Nestor
// Created       : 05.03.2013
// Last modified : 06.19.2015
// Modified by   : Greg Flynn
//-----------------------------------------------------------------------------
// Description :
// A 4x4 grid of cells
//------------------------------------------------------------------------------
// Modification history :
// 05.03.2013 : created
// 06.19.2015 : added in scan feature
//-----------------------------------------------------------------------------
module life_array_4x4(input clk,
		      input reset,
		      output [15:0] alive,
		      output [15:0] alive_prev,
		      input [15:0] val,
		      input write_enb,
		      input step, // set this high to start running the tiles
		      input nw,
		      input ne,
		      input se,
		      input sw,
		      input [3:0] n,
		      input [3:0] e,
		      input [3:0] s,
		      input [3:0] w

		      );


    // toggle
    wire run;
    reg toggle;
	 
	assign run = step & ~toggle;
	 
	always @(posedge clk) begin
	    if(reset) toggle <= 0;
		else if(write_enb) toggle <= 0;
		else toggle <= step;
    end
	 
    // internal connections
    wire [3:0] alive_col0, alive_col1, alive_col2, alive_col3;
    wire [3:0] alive_prev_col0, alive_prev_col1, alive_prev_col2, alive_prev_col3;
	 
	assign alive = {alive_col3,alive_col2,alive_col1,alive_col0};
	assign alive_prev = {alive_prev_col3,alive_prev_col2,alive_prev_col1,alive_prev_col0};
	 

    life_col4 COL0 (.clk(clk), .reset(reset), .n(n[0]), .ne(n[1]), .e_col(alive_col1),
		 .se(s[1]), .s(s[0]) , .sw(sw), .w_col(w), .nw(nw),
		 .val(val[3:0]),  .write_enb(write_enb), .enable(run),
 		 .alive_col(alive_col0),.alive_prev_col(alive_prev_col0));

    life_col4 COL1 (.clk(clk), .reset(reset), .n(n[1]), .ne(n[2]), .e_col(alive_col2),
		 .se(s[2]), .s(s[1]) , .sw(s[0]), .w_col(alive_col0), .nw(n[0]),
		 .val(val[7:4]), .write_enb(write_enb), .enable(run),
 		 .alive_col(alive_col1),.alive_prev_col(alive_prev_col1));

    life_col4 COL2 (.clk(clk), .reset(reset), .n(n[2]), .ne(n[3]), .e_col(alive_col3),
         .se(s[3]), .s(s[2]) , .sw(s[1]), .w_col(alive_col1), .nw(n[1]),
         .val(val[11:8]), .write_enb(write_enb), .enable(run),
 		 .alive_col(alive_col2),.alive_prev_col(alive_prev_col2));
 		 
    life_col4 COL3 (.clk(clk), .reset(reset), .n(n[3]), .ne(ne), .e_col(e),
         .se(se), .s(s[3]) , .sw(s[2]), .w_col(alive_col2), .nw(n[2]),
         .val(val[15:12]), .write_enb(write_enb), .enable(run),
         .alive_col(alive_col3),.alive_prev_col(alive_prev_col3));
                 


endmodule // life_array_4x4
