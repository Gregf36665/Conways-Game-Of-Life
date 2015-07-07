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
    output [15:0] valo_prev,
    input [15:0] ni,ei,si,wi,
    input nw,ne,se,sw
    );
    
    // edge inputs into the tiles
    wire [7:0] tile_0_Ni, tile_0_Ei, tile_0_Si, tile_0_Wi;
    wire [7:0] tile_1_Ni, tile_1_Ei, tile_1_Si, tile_1_Wi;
    wire [7:0] tile_2_Ni, tile_2_Ei, tile_2_Si, tile_2_Wi;
    wire [7:0] tile_3_Ni, tile_3_Ei, tile_3_Si, tile_3_Wi;
    
    // edge outputs from the tiles
    wire [7:0] tile_0_No, tile_0_Eo, tile_0_So, tile_0_Wo;
    wire [7:0] tile_1_No, tile_1_Eo, tile_1_So, tile_1_Wo;
    wire [7:0] tile_2_No, tile_2_Eo, tile_2_So, tile_2_Wo;
    wire [7:0] tile_3_No, tile_3_Eo, tile_3_So, tile_3_Wo;
    
    assign tile_0_Ni = ni[7:0];
    assign tile_0_Ei = tile_2_Wo;
    assign tile_0_Si = tile_1_No;
    assign tile_0_Wi = wi[7:0];
    
    assign tile_1_Ni = tile_0_So;
    assign tile_1_Ei = tile_3_Wo;
    assign tile_1_Si = si[7:0];
    assign tile_1_Wi = wi[15:8];
    
    assign tile_2_Ni = ni[15:8];
    assign tile_2_Ei = ei[7:0];
    assign tile_2_Si = tile_3_No;
    assign tile_2_Wi = tile_0_Eo;
    
    assign tile_3_Ni = tile_2_So;
    assign tile_3_Ei = ei[15:8];
    assign tile_3_Si = si[15:8];
    assign tile_3_Wi = tile_1_Eo;
    
    
    life_array_8x8 U_8x8_0 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .valo(),
                            .valo_prev(),
                            .write_enb(),
                            .ni(tile_0_Ni),
                            .ei(tile_0_Ei),
                            .si(tile_0_Si),
                            .wi(tile_0_Wi),
                            .no(tile_0_No),
                            .eo(tile_0_Eo),
                            .so(tile_0_So),
                            .wo(tile_0_Wo)
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
                            .wi(tile_1_Wi),
                            .no(tile_1_No),
                            .eo(tile_1_Eo),
                            .so(tile_1_So),
                            .wo(tile_1_Wo)
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
                            .wi(tile_2_Wi),
                            .no(tile_2_No),
                            .eo(tile_2_Eo),
                            .so(tile_2_So),
                            .wo(tile_2_Wo)
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
                            .wi(tile_3_Wi),
                            .no(tile_3_No),
                            .eo(tile_3_Eo),
                            .so(tile_3_So),
                            .wo(tile_3_Wo)
                            );
    


endmodule
