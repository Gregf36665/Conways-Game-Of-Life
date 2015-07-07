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
      output reg [15:0] valo_prev,
      input [1:0] vali_selector, valo_selector,
      input write_enb,
      input [7:0] n,e,s,w,
      input nw,ne,se,sw,
      input step
    );
    
     // Select which cell should be the output (used by the VGA to draw on the screen
    always @* begin
        case(valo_selector)
            2'b00: begin
                valo = alive_0;
                valo_prev = alive_prev_0;
            end
            2'b01: begin
                valo = alive_1;
                valo_prev = alive_prev_1;
            end
            2'b10: begin
                valo = alive_2;
                valo_prev = alive_prev_2;
            end
            2'b11: begin
                valo = alive_3;
                valo_prev = alive_prev_3;
            end
         endcase
    end
     
    wire [15:0] alive_0, alive_1, alive_2, alive_3;
    wire [15:0] alive_prev_0, alive_prev_1, alive_prev_2, alive_prev_3;
     
    wire [3:0] tile_0_N, tile_0_E, tile_0_S, tile_0_W;
    wire [3:0] tile_1_N, tile_1_E, tile_1_S, tile_1_W;
    wire [3:0] tile_2_N, tile_2_E, tile_2_S, tile_2_W;
    wire [3:0] tile_3_N, tile_3_E, tile_3_S, tile_3_W;
    
    assign tile_0_N = n[3:0];
    assign tile_0_E = alive_2[3:0];
    assign tile_0_S = {alive_1[12],alive_1[8], alive_1[4], alive_1[0]};
    assign tile_0_W = w[3:0];
                    
    assign tile_1_N = {alive_0[15],alive_0[11],alive_0[7],alive_0[3]},
           tile_1_E = alive_3[3:0],
           tile_1_S = s[3:0],
           tile_1_W = w[7:4];
                    
    assign tile_2_N = n[7:4],
           tile_2_E = e[3:0],
           tile_2_S = {alive_3[12],alive_3[8],alive_3[4],alive_3[0]},
           tile_2_W = alive_0[15:12];
                    
    assign tile_3_N = {alive_2[15],alive_2[11],alive_2[7],alive_2[3]},
           tile_3_E = e[7:4],
           tile_3_S = s[7:4],
           tile_3_W = alive_1[15:12];
     
     wire tile_0_NW = nw,
          tile_0_NE = n[4],
          tile_0_SE = alive_3[0],
          tile_0_SW = w[4];
            
     wire tile_1_NW = w[3],
          tile_1_NE = alive_2[3],
          tile_1_SE = s[4],
          tile_1_SW = sw;
            
     wire tile_2_NW = n[3],
          tile_2_NE = ne,
          tile_2_SE = e[4],
          tile_2_SW = alive_1[12];
            
     wire tile_3_NW = alive_0[15],
          tile_3_NE = e[3],
          tile_3_SE = se,
          tile_3_SW = s[3];
    
     assign write_0 = write_enb & (vali_selector == 2'b00);
     assign write_1 = write_enb & (vali_selector == 2'b01);
     assign write_2 = write_enb & (vali_selector == 2'b10);
     assign write_3 = write_enb & (vali_selector == 2'b11);
     
      
    life_array_4x4 U_array_0 (.clk(clk),
                              .reset(reset),
                              .alive(alive_0),
                              .alive_prev(alive_prev_0),
                              .val(vali),
                              .write_enb(write_0),
                              .step(step),
                              .n(tile_0_N),
                              .e(tile_0_E),
                              .s(tile_0_S),
                              .w(tile_0_W),
                              .nw(tile_0_NW),
                              .ne(tile_0_NE),
                              .se(tile_0_SE),
                              .sw(tile_0_SW)
                              );
    
     life_array_4x4 U_array_1 (.clk(clk),
                              .reset(reset),
                              .alive(alive_1),
                              .alive_prev(alive_prev_1),
                              .val(vali),
                              .write_enb(write_1),
                              .step(step),
                              .n(tile_1_N),
                              .e(tile_1_E),
                              .s(tile_1_S),
                              .w(tile_1_W),
                              .nw(tile_1_NW),
                              .ne(tile_1_NE),
                              .se(tile_1_SE),
                              .sw(tile_1_SW)
                              );
    
     life_array_4x4 U_array_2 (.clk(clk),
                              .reset(reset),
                              .alive(alive_2),
                              .alive_prev(alive_prev_2),
                              .val(vali),
                              .write_enb(write_2),
                              .step(step),
                              .n(tile_2_N),
                              .e(tile_2_E),
                              .s(tile_2_S),
                              .w(tile_2_W),
                              .nw(tile_2_NW),
                              .ne(tile_2_NE),
                              .se(tile_2_SE),
                              .sw(tile_2_SW)
                              );
                                        
    life_array_4x4 U_array_3 (.clk(clk),
                              .reset(reset),
                              .alive(alive_3),
                              .alive_prev(alive_prev_3),
                              .val(vali),
                              .write_enb(write_3),
                              .step(step),
                              .n(tile_3_N),
                              .e(tile_3_E),
                              .s(tile_3_S),
                              .w(tile_3_W),
                              .nw(tile_3_NW),
                              .ne(tile_3_NE),
                              .se(tile_3_SE),
                              .sw(tile_3_SW)
                              );
endmodule
