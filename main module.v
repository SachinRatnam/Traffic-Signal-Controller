`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:42:48 02/27/2022 
// Design Name: 
// Module Name:    traffic_control_1 
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
module traffic_control_1(
	output reg [1:0] hi_way,cnt_way,
	input x,clk,reset
    );
	 // 2-bit output for 3 state of signal(green,yellow,red)
	 
	 parameter RED = 2'd0, YELLOW = 2'd1, GREEN = 2'd2; // output state
	 
	 parameter Y_2_R_DELAY = 3;                     // yellow to red delay
	 parameter R_2_G_DELAY = 2;                     // red to green delay
	 
	 // state definition                            //  hi_way      cnt_way
 	 parameter S0= 3'd0,                            //  green        red
	           S1= 3'd1,                            //  yellow       red
				  S2= 3'd2,                            //  red          red
				  S3= 3'd3,                            //  red          green
				  S4= 3'd4;                            //  red          yellow
	 
	 reg [2:0] state, next_state ;
	 
	 // state change at positive clock edge 
	 always @(posedge clk)begin
			if(reset)
				state <= S0 ;
			else
				state <= next_state ;
	 end
	 
	 // next_state logic
	 always @(*)begin
			case(state)
					S0: next_state = x ? S1 : S0 ;
					S1:begin
							repeat(Y_2_R_DELAY) @(posedge clk) ; // delay yellow signal at hi_way before it goes to red
							next_state = S2 ;
						end
					S2:begin
							repeat(R_2_G_DELAY) @(posedge clk) ; // // delay red signal at cnt_way before it goes to green
							next_state = S3 ;
						end
					S3: next_state = x ? S3 : S4 ;
					S4:begin
							repeat(Y_2_R_DELAY) @(posedge clk) ; // // delay yellow signal at cnt_way before it goes to red
							next_state = S0 ;
						end
			endcase
	 end
	 
	 // OUTPUT LOGIC
	 always @(*)begin
				hi_way = GREEN ;
				cnt_way = RED ;
				case(state)
						S0: ;
						S1: hi_way = YELLOW ;
						S2: hi_way = RED ;
						S3: begin
								hi_way = RED;
								cnt_way = GREEN;
							end
						S4: begin
								hi_way = RED;
								cnt_way = YELLOW;
							end
				endcase
	 end
	 
		


endmodule
