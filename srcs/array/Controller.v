`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:47:32 07/02/2015 
// Design Name: 
// Module Name:    Controller 
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
module Controller(
    input clk,
    input reset,
    input debug,
    output reg [1:0] pos,
    output reg [15:0] val,
    output reg write_enb
    );
    
    parameter DEFAULT=3'd0, WRITE_TL=3'd1, WRITE_BL=3'd2,WRITE_TR=3'd3, WRITE_BR=3'd4;
    
    reg [2:0] state, next;
    
    always @(posedge clk)
        if (reset) state <= DEFAULT;
        else state <= next;
        
    always @* begin
        next = DEFAULT; // in an error go to default state
        case(state)
            DEFAULT:
                if(debug) next = WRITE_TL;
                else next = DEFAULT;
            WRITE_TL:
                next = WRITE_BL;
            WRITE_BL:
                next = WRITE_TR;
            WRITE_TR:
                next = WRITE_BR;
            WRITE_BR:
                next = DEFAULT;
        endcase
    end
    
    // this is configured to create a block in the center of the screen
    always @(posedge clk) begin
        case(next)
            DEFAULT:
                write_enb <= 0;
            WRITE_TL: begin
                pos <= 2'b00;
                val <= 16'h8000;
                write_enb <= 1;
            end
            WRITE_BL: begin
                pos <= 2'b01;
                val <= 16'h1000;
                write_enb <= 1;
            end
            WRITE_TR: begin
                pos <= 2'b10;
                val <= 16'h0008;
                write_enb <= 1;
            end
            WRITE_BR: begin
                pos <= 2'b11;
                val <= 16'h0001;
                write_enb <= 1;
            end
        endcase
    end
    


endmodule
