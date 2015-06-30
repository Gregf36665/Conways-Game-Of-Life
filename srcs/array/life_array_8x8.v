`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:08:48 06/30/2015 
// Design Name: 
// Module Name:    life_array_8x8 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module life_array_8x8(
      input clk,
      input reset,
      input [15:0] vali,
      output reg [15:0] valo,
      input [1:0] vali_selector, valo_selector,
      input write_enb,
      input [7:0] n,e,s,w,
      input nw,ne,se,sw,
		input step
    );
    
	 // Select which cell should be the output (used by the VGA to draw on the screen
    always @* begin
        case(valo_selector)
            2'b00: valo = alive_0;
            2'b01: valo = alive_1;
            2'b10: valo = alive_2;
            2'b11: valo = alive_3;
         endcase
    end
	 
	 wire [15:0] alive_0, alive_1, alive_2, alive_3;
	 
    wire [3:0] tile_0_N = 4'b0,
	            tile_0_E = alive_2[0:3],
					tile_0_S = {alive_1[0],alive_1[4], alive_1[8], alive_1[12]},
					tile_0_W = 4'b0;
					
    wire [3:0] tile_1_N = {alive_0[3],alive_0[7],alive_0[11],alive_0[15]},
	            tile_1_E = alive_3[0:3],
					tile_1_S = 4'b0,
					tile_1_W = 4'b0;
					
    wire [3:0] tile_2_N = 4'b0,
	            tile_2_E =, tile_2_S, tile_2_W;
    wire [3:0] tile_3_N, tile_3_E, tile_3_S, tile_3_W;
	 
	 wire tile_0_NW, tile_0_NE, tile_0_SE, tile_0_SW;
	 wire tile_1_NW, tile_1_NE, tile_1_SE, tile_1_SW;
	 wire tile_2_NW, tile_2_NE, tile_2_SE, tile_2_SW;
	 wire tile_3_NW, tile_3_NE, tile_3_SE, tile_3_SW;
    
	 assign write_0 = write_enb & (vali_selector == 2'b00);
	 assign write_1 = write_enb & (vali_selector == 2'b01);
	 assign write_2 = write_enb & (vali_selector == 2'b10);
	 assign write_3 = write_enb & (vali_selector == 2'b11);
	 
	  
    life_array_4x4 U_array_0 (.clk(clk),
                              .reset(reset),
										.alive(alive_0),
										.val(vali),
										.write_enb(write_0),
										.step(step),
										.n(4'b0),
										.e(edge_0_2),
										.s(edge_0_1),
										.w(4'b0),
										.nw(1'b0),
										.ne(1'b0),
										.se(edge_0_3),
										.sw(1'b0)
										
                              );
    
    life_array_4x4 U_array_1 (.clk(clk),
	                           .reset(reset),
										.alive(alive_1),
										.val(vali),
										.write_enb(write_1),
										.step(step),
										.n()
										);
    
    life_array_4x4 U_array_2 ();
    
    life_array_4x4 U_array_3 ();


endmodule
