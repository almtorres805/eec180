module top(
	input 		          		MAX10_CLK1_50,
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	input 		     [1:0]		KEY,
	output		     [9:0]		LEDR,
	input 		     [9:0]		SW
);

wire pulse_out;
wire [23:0] counter_out;

// Instantiate counters
pulse_gen count1(
	.divideby(SW[9:4]),
	.en(SW[0]),
	.reset(~KEY[0]),
	.clk(MAX10_CLK1_50),
	.go(pulse_out),
	.led(LEDR[9:0]));

main_counter count2(
	.en1(SW[0]),
	.en2(pulse_out),
	.up_down(SW[1]),
	.free_run(SW[2]),
	.reset(~KEY[0]),
	.clk(MAX10_CLK1_50),
	.count(counter_out));

// Instantiate 6 7-seg displays
seg7 hex0(
	.in(counter_out[3:0]),
	.out(HEX0));

seg7 hex1(
	.in(counter_out[7:4]),
	.out(HEX1));

seg7 hex2(
	.in(counter_out[11:8]),
	.out(HEX2));
	
seg7 hex3(
	.in(counter_out[15:12]),
	.out(HEX3));
	
seg7 hex4(
	.in(counter_out[19:16]),
	.out(HEX4));
	
seg7 hex5(
	.in(counter_out[23:20]),
	.out(HEX5));

endmodule
