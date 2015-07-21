`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2015 03:06:34 PM
// Design Name: 
// Module Name: pe_array_bench
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
`include "pe_array_decs.sv"
`include "pe_decs.sv"

module pe_array_bench;
    
    logic                       clk, reset;
    logic [`PE_CMD_BITS-1:0]    cmd;
    logic [`PE_STATE_BITS-1:0]  state_in;
    logic [`PE_STATE_BITS-1:0] state_out;
    logic 		      active;
    logic [`N_PX_BITS-1:0]      adr_x;
    logic [`N_PY_BITS-1:0]      adr_y;

    pe_array DUV (.clk(clk), .reset(reset), .cmd(cmd), .state_in(state_in),
                  .state_out(state_out), .active(active), .adr_x(adr_x), .adr_y(adr_y));

  task display_states;
    begin
      integer i, j, t;
      $display("array state at time %t", $time);
      for (j=0; j<`N_PY; j++) begin
        $write("    ");
        for (i=0; i<`N_PX; i++) begin
          for (t=`PE_STATE_BITS-1;t>=0;t--)
            $write("%b", DUV.state_out_a[i][j][t]);
          $write(" ");
        end
        $write("\n");
      end
    end  
  endtask  
      
/*
  task display_states;
    begin

      $display("array state at time %t", $time);
      $display("    %b %b %b %b", 
               DUV.outer[0].inner[0].PE_INST.state,
               DUV.outer[1].inner[0].PE_INST.state,
               DUV.outer[2].inner[0].PE_INST.state,
               DUV.outer[3].inner[0].PE_INST.state);
       $display("    %b %b %b %b", 
               DUV.outer[0].inner[1].PE_INST.state,
               DUV.outer[1].inner[1].PE_INST.state,
               DUV.outer[2].inner[1].PE_INST.state,
               DUV.outer[3].inner[1].PE_INST.state);
       $display("    %b %b %b %b", 
               DUV.outer[0].inner[2].PE_INST.state,
               DUV.outer[1].inner[2].PE_INST.state,
               DUV.outer[2].inner[2].PE_INST.state,
               DUV.outer[3].inner[2].PE_INST.state);
       $display("    %b %b %b %b", 
               DUV.outer[0].inner[3].PE_INST.state,
               DUV.outer[1].inner[3].PE_INST.state,
               DUV.outer[2].inner[3].PE_INST.state,
               DUV.outer[3].inner[3].PE_INST.state);
    end
 endtask
*/
 
   task display_neighbor_counts;
   begin

     $display("array neighbor count at time %t", $time);
     $display("    %d %d %d %d", 
              DUV.outer[0].inner[0].PE_INST.neighbor_count,
              DUV.outer[1].inner[0].PE_INST.neighbor_count,
              DUV.outer[2].inner[0].PE_INST.neighbor_count,
              DUV.outer[3].inner[0].PE_INST.neighbor_count);
      $display("    %d %d %d %d", 
              DUV.outer[0].inner[1].PE_INST.neighbor_count,
              DUV.outer[1].inner[1].PE_INST.neighbor_count,
              DUV.outer[2].inner[1].PE_INST.neighbor_count,
              DUV.outer[3].inner[1].PE_INST.neighbor_count);
      $display("    %d %d %d %d", 
              DUV.outer[0].inner[2].PE_INST.neighbor_count,
              DUV.outer[1].inner[2].PE_INST.neighbor_count,
              DUV.outer[2].inner[2].PE_INST.neighbor_count,
              DUV.outer[3].inner[2].PE_INST.neighbor_count);
      $display("    %d %d %d %d", 
              DUV.outer[0].inner[3].PE_INST.neighbor_count,
              DUV.outer[1].inner[3].PE_INST.neighbor_count,
              DUV.outer[2].inner[3].PE_INST.neighbor_count,
              DUV.outer[3].inner[3].PE_INST.neighbor_count);
   end
endtask
 
  task write_cell;
    input [`N_PX_BITS-1:0] x;
    input [`N_PY_BITS-1:0] y;
    input [`N_STATE_BITS-1:0] val;
    
    begin
      cmd = `PE_CMD_WRITE;
      adr_x = x;
      adr_y = y;
      state_in = val;
      @(posedge clk) #1;
    end
  endtask  
                  
              
   always begin
     clk = 0; #10;
     clk = 1; #10;
   end
   
   initial begin
   $display("welcome back my friends, to the show that never ends");
     reset = 1;
     cmd = `PE_CMD_NOP;
     adr_x = 0;
     adr_y = 0;
     state_in = `PE_STATE_LIVE;
     display_states();
     @(posedge clk) #1;
     display_states(); 
     reset = 0;
     @(posedge clk) #1;
      display_states();
     @(posedge clk) #1
      display_states();
     write_cell(1,2,`PE_STATE_LIVE);
      display_states();
     write_cell(2,2,`PE_STATE_LIVE);
     write_cell(3,2,`PE_STATE_LIVE);
     display_states();
     cmd = `PE_CMD_PROCESS;
     @(posedge clk) #1;
     display_states();
     @(posedge clk) #1;
     display_states();    
      @(posedge clk) #1;
     display_states(); 
      @(posedge clk) #1;
     display_states();  
     @(posedge clk); #1;   
     display_states();
     @(posedge clk); #1;   
     display_states();
     $stop;
   end

endmodule