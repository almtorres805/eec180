`timescale 1ps/1ps 
module tb_part2; 
 
	reg [3:0] count; 

	wire [7:0] HEX0; 
	wire [7:0] HEX1; 
	wire [7:0] HEX2; 
	wire [7:0] HEX3; 
	wire [7:0] HEX4; 
	wire [7:0] HEX5; 
	wire  [1:0] KEY; 
	wire [9:0] LEDR; 
	wire  [9:0] SW; 

	assign SW[3:0] = count; 
  
	// The part of the testbench that instantiates the hardware to be tested 
	part2 p2 (.HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2),  
	.HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), 
	.KEY(KEY), .LEDR(LEDR), .SW(SW)); 
		  
	// The part of the testbench that creates test input signals 
	initial begin   
		count = 4'b0000; 
		repeat (16) begin 
			#100 
			$display("in = %b, HEX1 = %b, HEX0 = %b", count, HEX1, HEX0); 
			count = count + 4'b0001; 
		end 
	end 
endmodule