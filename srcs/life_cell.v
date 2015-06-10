//-----------------------------------------------------------------------------
// Title         : life_cell
// Project       : TSP - Tiled Spatial Processing
//-----------------------------------------------------------------------------
// File          : life_cell.v
// Author        : John Nestor
// Created       : 05.03.2013
// Last modified : 05.03.2013
//-----------------------------------------------------------------------------
// Description :
// Basic cell for calculating next state in Conway's Life
//------------------------------------------------------------------------------
// Modification history :
// 05.03.2013 : created
//-----------------------------------------------------------------------------

////  TODO: add an "operation" input that allows hold, read, write???

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
		                output reg alive
		                );

    wire [3:0] 		neighbor_count;
    reg alive_next;

    assign 		neighbor_count = n + ne + e + se + s + sw + w + nw;

    always @(posedge clk)  begin alive <= alive_next;
      if (reset) alive_next <= 0;
      else if (write) alive_next <= val;
		else if(!enb); // do nothing
      else if (alive)
        if (neighbor_count < 2 || neighbor_count >3 ) alive_next <= 0;
        else alive_next <= 1;
      else if (neighbor_count == 3) alive_next <= 1;
   end

endmodule // life_cell

