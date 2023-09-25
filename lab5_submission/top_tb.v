`timescale 1ps/1ps
module top_tb;

wire [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
wire [9:0] LEDR;

reg clk;
reg [9:0] SW;
reg [1:0] KEY;

top test(
	.MAX10_CLK1_50(clk),
	.HEX0(HEX0),
	.HEX1(HEX1),
	.HEX2(HEX2),
	.HEX3(HEX3),
	.HEX4(HEX4),
	.HEX5(HEX5),
	.KEY(KEY),
	.LEDR(LEDR),
	.SW(SW));

initial begin
	clk = 0;
	SW[0] = 1; // Enable on
	SW[1] = 0; // initialize go
	SW[2:1] = 2'b00; // FREE_RUN && UP_DOWN
	SW[9:4] = 6'b00_0000; // Divideby
	KEY[0] = 1'b1;	// reset is off
	
	#100
	clk = 1;
	$display("Initially LEDS are on and displays are 0");
	$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	
	#100
	clk = 0;
	SW[2:1] = 2'b11; // FREE_RUN && UP_DOWN
	SW[9:4] = 6'b00_0010; // Divideby
	$display("Free-run is high and up_down is high");
	repeat(7) begin
		#100
		clk = 1;
		$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		#100
		clk = 0;
	end
	
	SW[2:1] = 2'b10; // FREE_RUN && UP_DOWN
	SW[9:4] = 6'b00_0010; // Divideby
	$display("Free-run is high and up_down is low");
	repeat(6) begin
		#100
		clk = 1;
		$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		#100
		clk = 0;
	end
	
	SW[2:1] = 2'b01; // FREE_RUN && UP_DOWN
	SW[9:4] = 6'b00_0010; // Divideby
	$display("Free-run is low and up_down is high");
	repeat(6) begin
		#100
		clk = 1;
		$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		#100
		clk = 0;
	end

	#100
	clk = 1;
	KEY[0] = 1'b0;
	#100
	clk = 0;
	SW[2:1] = 2'b00; // FREE_RUN && UP_DOWN
	SW[9:4] = 6'b00_0010; // Divideby
	KEY[0] = 1'b1;
	$display("Free-run is low and up_down is low");
	repeat(7) begin
		#100
		clk = 1;
		$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
		#100
		clk = 0;
	end
	
	#100
	clk = 1;
	KEY[0] = 1'b0;
	#100
	clk = 0;
	$display("RESET THE COUNTER");
	$display("LEDR = %b, HEX0=%b, HEX1=%b, HEX2=%b, HEX3=%b, HEX4=%b, HEX5=%b", LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
end
endmodule
