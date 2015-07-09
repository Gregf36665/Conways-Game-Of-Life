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
    input nw,ne,se,sw,
    output [31:0] no, eo, so, wo,
    output nwo, neo, seo, swo
    );
    
   /*****START EDGE CONNECTIONS********/
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
    
    // diagonal inputs
    wire tile_0_NWi = nwi,
         tile_0_NEi = ni[8],
         tile_0_SEi = tile_3_NWo,
         tile_0_SWi = wi[8];
         
    wire tile_1_NWi = wi[7],
         tile_1_NEi = tile_2_SWo,
         tile_1_SEi = si[8],
         tile_1_SWi = swi;
         
    wire tile_2_NWi = ni[7],
         tile_2_NEi = nei,
         tile_2_SEi = ei[8],
         tile_2_SWi = tile_1_NEo;
         
    wire tile_3_NWi = tile_0_SEo,
         tile_3_NEi = ei[7],
         tile_3_SEi = se,
         tile_3_SWi = si[7];
         
    // diagonal outputs
    wire tile_0_NWo,
         tile_0_NEo,
         tile_0_SEo,
         tile_0_SWo;
         
    wire tile_1_NWo,
         tile_1_NEo,
         tile_1_SEo,
         tile_1_SWo;
         
    wire tile_2_NWo,
         tile_2_NEo,
         tile_2_SEo,
         tile_2_SWo;
         
    wire tile_3_NWo,
         tile_3_NEo,
         tile_3_SEo,
         tile_3_SWo;
         
    // edge inputs
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
    
    
    /*******END EDGE CONNECTIONS**********/
    
    /*******START VALO SELECTOR***********/
    
    wire [15:0] valo_0,valo_1,valo_2,valo_3;
    wire [15:0] valo_prev_0,valo_prev_1,valo_prev_2,valo_prev_3;
    
    always @*
        case(valo_selector[3:2])
            2'b00: begin
                valo = valo_0;
                valo_prev = valo_prev_0;
                end
            2'b01: begin
                valo = valo_1;
                valo_prev = valo_prev_1;
                end
            2'b10: begin
                valo = valo_2;
                valo_prev = valo_prev_2;
                end
            2'b11: begin
                valo = valo_3;
                valo_prev = valo_prev_3;
                end
        endcase
            
    /*******END VALO SELECTOR*************/
    
    
    
    /************START MODULES************/
    
    life_array_8x8 U_8x8_0 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .vali_selector(),
                            .valo(valo_0),
                            .valo_prev(valo_prev_0),
                            .valo_selector(valo_selector[1:0]),
                            .write_enb(),
                            .step(step),
                            .ni(tile_0_Ni),
                            .ei(tile_0_Ei),
                            .si(tile_0_Si),
                            .wi(tile_0_Wi),
                            .no(tile_0_No),
                            .eo(tile_0_Eo),
                            .so(tile_0_So),
                            .wo(tile_0_Wo),
                            .nwi(tile_0_NWi),
                            .nei(tile_0_NEi),
                            .sei(tile_0_SEi),
                            .swi(tile_0_SWi),
                            .nwo(tile_0_NWo),
                            .neo(tile_0_NEo),
                            .seo(tile_0_SEo),
                            .swo(tile_0_SWo)
                            );
    
    life_array_8x8 U_8x8_1 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .vali_selector(),
                            .valo(valo_1),
                            .valo_prev(valo_prev_1),
                            .valo_selector(valo_selector[1:0]),
                            .write_enb(),
                            .step(step),
                            .ni(tile_1_Ni),
                            .ei(tile_1_Ei),
                            .si(tile_1_Si),
                            .wi(tile_1_Wi),
                            .no(tile_1_No),
                            .eo(tile_1_Eo),
                            .so(tile_1_So),
                            .wo(tile_1_Wo),
                            .nwi(tile_1_NWi),
                            .nei(tile_1_NEi),
                            .sei(tile_1_SEi),
                            .swi(tile_1_SWi),
                            .nwo(tile_1_NWo),
                            .neo(tile_1_NEo),
                            .seo(tile_1_SEo),
                            .swo(tile_1_SWo)
                            );
    
    life_array_8x8 U_8x8_2 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .vali_selector(),
                            .valo(valo_2),
                            .valo_prev(valo_prev_2),
                            .valo_selector(valo_selector[1:0]),
                            .write_enb(),
                            .step(step),
                            .ni(tile_2_Ni),
                            .ei(tile_2_Ei),
                            .si(tile_2_Si),
                            .wi(tile_2_Wi),
                            .no(tile_2_No),
                            .eo(tile_2_Eo),
                            .so(tile_2_So),
                            .wo(tile_2_Wo),
                            .nwi(tile_2_NWi),
                            .nei(tile_2_NEi),
                            .sei(tile_2_SEi),
                            .swi(tile_2_SWi),
                            .nwo(tile_2_NWo),
                            .neo(tile_2_NEo),
                            .seo(tile_2_SEo),
                            .swo(tile_2_SWo)
                            );
    
    life_array_8x8 U_8x8_3 (.clk(clk),
                            .reset(reset),
                            .vali(vali),
                            .vali_selector(),
                            .valo(valo_3),
                            .valo_prev(valo_prev_3),
                            .valo_selector(valo_selector[1:0]),
                            .write_enb(),
                            .step(step)
                            .ni(tile_3_Ni),
                            .ei(tile_3_Ei),
                            .si(tile_3_Si),
                            .wi(tile_3_Wi),
                            .no(tile_3_No),
                            .eo(tile_3_Eo),
                            .so(tile_3_So),
                            .wo(tile_3_Wo),
                            .nwi(tile_3_NWi),
                            .nei(tile_3_NEi),
                            .sei(tile_3_SEi),
                            .swi(tile_3_SWi),
                            .nwo(tile_3_NWo),
                            .neo(tile_3_NEo),
                            .seo(tile_3_SEo),
                            .swo(tile_3_SWo)
                            );
    
    /*****************END MODULES***************/

endmodule
