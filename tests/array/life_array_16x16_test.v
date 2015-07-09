`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:59:30 07/09/2015
// Design Name:   life_array_16x16
// Module Name:   U:/Excel/TSP/Conway/life_array_16x16_test.v
// Project Name:  Conway
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: life_array_16x16
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module life_array_16x16_test;

	// Inputs
	reg clk = 0;
	reg reset = 1;
	reg [15:0] vali = 16'h0;
	reg [3:0] vali_selector = 4'h0;
	reg [3:0] valo_selector =4'h0;
	reg write_enb = 0;
	reg step = 0;
	reg [15:0] ni = 16'h0000;
	reg [15:0] ei = 16'h0000;
	reg [15:0] si = 16'h0000;
	reg [15:0] wi = 16'h0000;
	reg nwi = 0;
	reg nei = 0;
	reg sei = 0;
	reg swi = 0;

	// Outputs
	wire [15:0] valo;
	wire [15:0] valo_prev;
	wire [15:0] no;
	wire [15:0] eo;
	wire [15:0] so;
	wire [15:0] wo;
	wire nwo;
	wire neo;
	wire seo;
	wire swo;

	// Instantiate the Unit Under Test (UUT)
	life_array_16x16 uut (
		.clk(clk), 
		.reset(reset), 
		.vali(vali), 
		.vali_selector(vali_selector), 
		.valo_selector(valo_selector), 
		.write_enb(write_enb), 
		.step(step), 
		.valo(valo), 
		.valo_prev(valo_prev), 
		.ni(ni), 
		.ei(ei), 
		.si(si), 
		.wi(wi), 
		.nwi(nwi), 
		.nei(nei), 
		.sei(sei), 
		.swi(swi), 
		.no(no), 
		.eo(eo), 
		.so(so), 
		.wo(wo), 
		.nwo(nwo), 
		.neo(neo), 
		.seo(seo), 
		.swo(swo)
	);

    always
        #5 clk = ~ clk;
    
	initial begin
        #11;
		// Wait 11 ns for global reset to finish
		reset = 0;
        #10;
        
		// Add stimulus here

	end
      
endmodule

