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

    integer i; // use in for loops
    
	// Inputs
	reg clk = 0;
	reg reset = 1;
	reg [15:0] vali = 16'h0;
	reg [3:0] vali_selector = 4'h0;
	reg [3:0] valo_selector = 4'h0;
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
    
    // Expected value
    reg [15:0] expected_alive = 16'h0000;

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
        
        vali = 16'h0001; // top left cell
        vali_selector = 4'h0;
        write_enb = 1;
        #10;
        write_enb = 0;
        
        valo_selector = 4'h0;
        expected_alive = 16'h0001;
        #10;		
		if(expected_alive != valo) begin
		    $display("Failed to write to top left cell only");
		    $stop;
		end
		#10;
        
        // trigger entire north edge
        write_enb = 0;
        reset = 1;
        #10;
        reset = 0;
        #10;
        write_enb = 1;
        vali_selector = 4'h0;
        vali = 16'h1111;
        #10;
        vali_selector = 4'h4;
        vali = 16'h1111;
        #10;
        vali_selector = 4'h8;
        vali = 16'h1111;
        #10;
        vali_selector = 4'hC;
        vali = 16'h1111;
        #10;
        write_enb = 0;
        expected_alive = 16'hFFFF;
        if(expected_alive != no) begin
		    $display("Failed to write north edge of cells");
		    $stop;
		end
        
        
        
        // try writing blocks on each edge
        vali = 16'h8000;
        vali_selector = 4'h0;
        write_enb = 1;
        #10;
        vali = 16'h9000;
        vali_selector = 4'h1;
        #10;
        vali = 16'h9000;
        vali_selector = 4'h2;
        #10;
        vali = 16'h1000;
        vali_selector = 4'h3;
        #10;
        vali = 16'h8008;
        vali_selector = 4'h4;
        #10;
        vali = 16'h8008;
        vali_selector = 4'h8;
        #10;
        vali = 16'h9009;
        vali_selector = 4'h5;
        #10;
        vali = 16'h9009;
        vali_selector = 4'h6;
        #10;
        vali = 16'h9009;
        vali_selector = 4'h9;
        #10;
        vali = 16'h9009;
        vali_selector = 4'hA;
        #10;
        vali = 16'h1001;
        vali_selector = 4'h7;
        #10;
        vali = 16'h1001;
        vali_selector = 4'hB;
        #10;
        vali = 16'h0008;
        vali_selector = 4'hC;
        #10;
        vali = 16'h0009;
        vali_selector = 4'hD;
        #10;
        vali = 16'h0009;
        vali_selector = 4'hE;
        #10;
        vali = 16'h0001;
        vali_selector = 4'hF;
        #10;
        write_enb = 0;
        #10;
        step = 1;
        #10;
        
        for (i = 0; i < 16; i = i + 1) begin
            valo_selector = i;
            if (valo == 16'h0000) begin
                $display("Warning, %i is totally dead, should be stable!",i);
                $stop;
            end
        end

        #20;

        $display("All tests passed");
        $stop;
	end
      
endmodule

