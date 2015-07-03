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
		                output reg alive,
                        output reg alive_prev
		                );

    wire [3:0] 		neighbor_count;
    reg 				alive_next;
    reg                 alive_next_prev; // this is the next value of the previous state

    assign 		neighbor_count = n + ne + e + se + s + sw + w + nw;

    always @(posedge clk) begin 
		if (write) begin
				alive <= val;
                alive_prev <= val;
				end
		else if (reset) begin
				alive <= 0;
                alive_prev <= 0;
				end
			
		else begin
            alive <= alive_next;
            alive_prev <= alive_next_prev;
        end
	end
	
	always @* begin
		if (enb) begin
		        alive_next_prev = alive;
				if (alive)
					if (neighbor_count < 2 || neighbor_count > 3 ) alive_next = 0;
					else alive_next = 1;
				else if (neighbor_count == 3) alive_next = 1;
				else alive_next = 0;
		end
		else begin
		    alive_next = alive;
		    alive_next_prev = alive_prev;
		end
	end

endmodule // life_cell

