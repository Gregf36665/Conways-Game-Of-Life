`timescale 1ns / 1ps
`include "../imports/life_prototype/pe_array_decs.sv"
`include "../imports/life_prototype/pe_decs.sv"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2015 04:50:06 PM
// Design Name: 
// Module Name: Top
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


module Top(
    input clk,
    input [7:0] sw,
    input step, write, reset,
    output [7:0] leds,
    output [3:0] red,
    output [3:0] green,
    output [3:0] blue,
    output Hsync, Vsync
    );
    
    logic [1:0] cmd;
    wire [10:0] x,y;
    wire [`N_PX_BITS-1:0] adr_x_o;
    wire [`N_PY_BITS-1:0] adr_y_o;
   
    wire [`N_PX_BITS-1:0] adr_x_i;
    wire [`N_PY_BITS-1:0] adr_y_i;
    
    wire [`PE_STATE_BITS-1:0] state_out;
        
    // Trigger for delayed signal
    Timer #(.COUNT_MAX(100000000)) timer (.clk(clk),.trigger(trigger));
         
    FSM FINITE_STATE_MACHINE (.clk(clk),
                              .trigger(trigger),
                              .enb(sw[0]),
                              .reset(reset),
                              .run(sw[1]),
                              .x(adr_x_i),
                              .y(adr_y_i),
                              .cmd(cmd),
                              .val(val)
                              );
        
    
    pe_array ARRAY (.clk(clk),
                    .reset(reset),
                    .cmd(cmd),
                    .adr_x_i(adr_x_i),
                    .adr_y_i(adr_y_i),
                    .adr_x_o(adr_x_o),
                    .adr_y_o(adr_y_o),
                    .state_in(val),
                    .active(active),
                    .state_out(state_out)
                    );
                    
    VESADriver vga_driver (.clk(clk),
                           .Hsyncb(Hsync),
                           .Vsyncb(Vsync),
                           .x(x),
                           .y(y)
                           );
                          
    Display display (.x(x),
                     .y(y),
                     .state(state_out),
                     .rgb({red,green,blue}),
                     .x_array(adr_x_o),
                     .y_array(adr_y_o)
                     );
   


                    
endmodule
