`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:11:27 03/05/2022
// Design Name:   traffic_control_1
// Module Name:   E:/verilog_coding/traffic_control/test_bench.v
// Project Name:  traffic_control
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: traffic_control_1
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_bench;

	// Inputs
	reg car_on_cntry_rd;           // car_on_cntry_rd is sensor which indicates is there is car on cntry road
	reg clk;
	reg reset;

	// Outputs
	wire [1:0] hi_way_sig ;
	wire [1:0] cnt_way_sig ;

	// Instantiate the Unit Under Test (UUT)
	traffic_control_1 uut (
		.hi_way(hi_way_sig), 
		.cnt_way(cnt_way_sig), 
		.x(car_on_cntry_rd), 
		.clk(clk), 
		.reset(reset)
	);

	initial
		clk = 0;
	always #5 clk = ~clk ;
	
	initial
		begin
				reset = 1'b1 ;
				repeat (5) @(posedge clk);
				reset = 1'b0 ;
		end
		
	initial 
		begin
			car_on_cntry_rd = 1'b0 ;
			repeat (10) @(posedge clk) ;
			
			car_on_cntry_rd = 1'b1 ;
			repeat (20) @(posedge clk) ;
			
			car_on_cntry_rd = 1'b0 ;
			repeat (20) @(posedge clk) ;
			
			car_on_cntry_rd = 1'b1 ;
			repeat (10) @(posedge clk) ;
			
			car_on_cntry_rd = 1'b0 ;
			repeat (5) @(posedge clk) ;
			
			car_on_cntry_rd = 1'b1 ;
			repeat (25) @(posedge clk) ;
			
			$stop;
		end
		
        

      
endmodule

