//-----------------------------------------------------------------------------
// Title         : pe - Processing Element for Conway's Life
// Project       : TSP - Tiled Spatial Processing (Life Prototype)
//-----------------------------------------------------------------------------
// File          : pe.v
// Author        : John Nestor
// Created       : 19.03.2013
// Last modified : 19.03.2013
//-----------------------------------------------------------------------------
// Description :
// Processing element module comprised of a single PE tile memoruy
// (pe_mem) and a combinational sequencer unit (pe_seq)
//-----------------------------------------------------------------------------
// Copyright (c) 2015 by John Nestor.
//------------------------------------------------------------------------------
// Modification history :
// 19.03.2013 : created
//-----------------------------------------------------------------------------

`include "pe_array_decs.sv"
`include "pe_decs.sv"

module pe (input clk, rst,
	   input 		       rsel, csel, // used for read, write
	   input [`PE_CMD_BITS-1:0]    cmd,
	   output [`N_STATUS_BITS-1:0] status_out, // for communicating with neighbors
	   input [`PE_STATE_BITS-1:0]  state_in,
	   output reg [`PE_STATE_BITS-1:0] state_out,
	   output 		       active, // for keeping track of activity in entire array - true when state changes

	   input [`N_STATUS_BITS-1:0]  w_i, e_i, n_i, s_i, // manhattan neighbors
   	   input [`N_STATUS_BITS-1:0]  nw_i, ne_i, sw_i, se_i);   // diagonal neighbors

   // PE selection logic

   logic 			      sel;
   
   assign sel = rsel & csel;
   
   // state memory for this PE

   logic [`PE_STATE_BITS-1:0] 	      state, nstate;

   // This functon should be modified for different PEs
   // the idea of putting it into a function is to limit other changes

   function [`PE_STATUS_BITS-1:0] status_from_state;
      input [`PE_STATE_BITS-1:0] state;
      
      status_from_state = state;  // status == state in Conway's Life, for example
      
   endfunction // status_from_state

   assign 			     status_out = status_from_state(state);

   logic [3:0] 			 neighbor_count;

   assign neighbor_count = w_i + n_i + e_i + s_i
	  + nw_i + ne_i + sw_i + se_i;


   always_ff @(posedge clk)
     if (rst) state <= `PE_STATE_DEAD;
     else state <= nstate;
         
   always_comb
     begin
     state_out = state; // default beavhior
     nstate = state;
	case (cmd)
	  `PE_CMD_NOP:
	    nstate = state;  // do nothing!
	  `PE_CMD_PROCESS:
	    if (neighbor_count < 2) nstate = `PE_STATE_DEAD;
	    else if (neighbor_count == 2) nstate = state;
	    else if (neighbor_count == 3) nstate = `PE_STATE_LIVE;
	    else nstate = `PE_STATE_DEAD;
	  `PE_CMD_READ:
	    if (sel) state_out = state;
	    else state_out = 0;
	  `PE_CMD_WRITE:
	    if (sel) nstate = state_in;
	    else nstate = state;
	  default: nstate = state;
	 endcase // case(cmd)
     end // always_comb

   
   

   
   

   assign active = nstate != state;

endmodule // pe







	   