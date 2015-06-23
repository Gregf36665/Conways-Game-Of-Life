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
		      input [1:0] row,
		      input [1:0] col,
		      input val,
		      input write_enb,
		      input scan,
			  input scan_write_val,
			  input scan_write_enb,
			  output scan_read_val,
		      input run, // set this high to start running the tiles
		      input nw,
		      input ne,
		      input se,
		      input sw,
		      input [3:0] n,
		      input [3:0] e,
		      input [3:0] s,
		      input [3:0] w

		      );


    // internal connections
    wire [3:0] alive_col0, alive_col1, alive_col2, alive_col3;
	wire [3:0]	scan_col0, scan_col1, scan_col2, scan_col3; // values into col#		
	 
	assign alive = {alive_col3,alive_col2,alive_col1,alive_col0};
	 
	assign write_0 = write_enb & (col == 2'd0);
    assign write_1 = write_enb & (col == 2'd1);
    assign write_2 = write_enb & (col == 2'd2);
    assign write_3 = write_enb & (col == 2'd3);
	 
	assign scan_col_topLeft = scan_write_enb ? scan_write_val : alive_col3[3];
	 
	assign scan_read_val = alive_col3[3];	 
   
	assign scan_col0 = {alive_col3[2:0],scan_col_topLeft};
	assign scan_col1 = alive_col0;
	assign scan_col2 = alive_col1;
	assign scan_col3 = alive_col2;

    life_col4 COL0 (.clk(clk), .reset(reset), .n(n[0]), .ne(n[1]), .e_col(alive_col1),
		 .se(s[1]), .s(s[0]) , .sw(sw), .w_col(w), .nw(nw),
		 .val(val),  .write_enb(write_0), .row(row), .enable(run),
		 .scan(scan), .scan_val(scan_col0),
 		 .alive_col(alive_col0));

    life_col4 COL1 (.clk(clk), .reset(reset), .n(n[1]), .ne(n[2]), .e_col(alive_col2),
		 .se(s[2]), .s(s[1]) , .sw(s[0]), .w_col(alive_col0), .nw(n[0]),
		 .val(val), .write_enb(write_1), .row(row), .enable(run),
		 .scan(scan), .scan_val(scan_col1),
 		 .alive_col(alive_col1));

    life_col4 COL2 (.clk(clk), .reset(reset), .n(n[2]), .ne(n[3]), .e_col(alive_col3),
       .se(s[3]), .s(s[2]) , .sw(s[1]), .w_col(alive_col1), .nw(n[1]),
       .val(val), .write_enb(write_2), .row(row), .enable(run),
		 .scan(scan), .scan_val(scan_col2),
 		 .alive_col(alive_col2));
 		 
    life_col4 COL3 (.clk(clk), .reset(reset), .n(n[3]), .ne(ne), .e_col(e),
       .se(se), .s(s[3]) , .sw(s[2]), .w_col(alive_col2), .nw(n[2]),
       .val(val), .write_enb(write_3), .row(row), .enable(run),
		 .scan(scan), .scan_val(scan_col3),
       .alive_col(alive_col3));
                 


endmodule // life_array_4x4
