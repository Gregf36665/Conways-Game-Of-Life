`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:55 07/07/2015 
// Design Name: 
// Module Name:    life_array_16x16 
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
module life_array_16x16(
    input clk,
    input reset,
    input [15:0] vali,
    input [3:0] vali_selector,
    input [3:0] valo_selector,
    input write_enb,
    input step,
    output [15:0] valo,
    output [15:0] valo_prev
    );
    
    wire [7:0] tile_0_Ni, tile_0_Ei, tile_0_Si, tile_0_Wi;
    wire [7:0] tile_1_Ni, tile_1_Ei, tile_1_Si, tile_1_Wi;
    wire [7:0] tile_2_Ni, tile_2_Ei, tile_2_Si, tile_2_Wi;
    wire [7:0] tile_3_Ni, tile_3_Ei, tile_3_Si, tile_3_Wi;
    
    
    
    life_array_8x8 U_8x8_0 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .valo(),
                            .valo_prev(),
                            .write_enb(),
                            .ni(tile_0_Ni),
                            .ei(tile_0_Ei),
                            .si(tile_0_Si),
                            .wi(tile_0_Wi)
                            );
    
    life_array_8x8 U_8x8_1 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .valo(),
                            .valo_prev(),
                            .write_enb(),
                            .ni(tile_1_Ni),
                            .ei(tile_1_Ei),
                            .si(tile_1_Si),
                            .wi(tile_1_Wi)
                            );
    
    life_array_8x8 U_8x8_2 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .valo(),
                            .valo_prev(),
                            .write_enb(),
                            .ni(tile_2_Ni),
                            .ei(tile_2_Ei),
                            .si(tile_2_Si),
                            .wi(tile_2_Wi)
                            );
    
    life_array_8x8 U_8x8_3 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .valo(),
                            .valo_prev(),
                            .write_enb(),
                            .ni(tile_3_Ni),
                            .ei(tile_3_Ei),
                            .si(tile_3_Si),
                            .wi(tile_3_Wi)
                            );
    


endmodule
