//-----------------------------------------------------------------------------
// Title         : life_cell
// Project       : TSP - Tiled Spatial Processing
//-----------------------------------------------------------------------------
// File          : life_cell.v
// Author        : John Nestor
// Created       : 05.03.2013
// Last modified : 06.19.2015
// Modified by   : Greg Flynn
//-----------------------------------------------------------------------------
// Description :
// Basic cell for calculating next state in Conway's Life
//------------------------------------------------------------------------------
// Modification history :
// 05.03.2013 : created
// 06.19.2015 : added in scan feature
//-----------------------------------------------------------------------------


module life_cell(input clk,
                        reset,
                        n,
                        ne,
                        e,
                        se,
                        s,
                        sw,
                        w,
                        nw,
                        write, // enable writing
                        val, // to set the cell to a certain value
                        enb, // enable the cell to come to life
								scan, // enable scan
								scan_val, // the value to write when scanning
											 //(normally east cell)
		                output reg alive
		                );

    wire [3:0] 		neighbor_count;
    reg 				alive_next;

    assign 		neighbor_count = n + ne + e + se + s + sw + w + nw;

    always @(posedge clk) begin 
	   if (scan) begin
				alive <= scan_val;
				alive_next = scan_val;
				end
		else if (write) begin
				alive <= val;
				alive_next = val;
				end
		else if (reset) begin
				alive <= 0;
				alive_next = 0;
				end
			
		else alive <= alive_next;
	end
	
	always @* begin
		if (enb) begin
				if (alive)
					if (neighbor_count < 2 || neighbor_count > 3 ) alive_next = 0;
					else alive_next = 1;
					else if (neighbor_count == 3) alive_next = 1;
		end
	end

endmodule // life_cell

