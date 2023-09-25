`timescale 1ps/1ps
module pulse_gen_tb;

reg [5:0] divideby;
reg en, reset, clk;
wire out;
wire [5:0] count;
wire [9:0] ledr;

pulse_gen count1(
	.divideby(divideby[5:0]),
	.en(en),
	.reset(reset),
	.clk(clk),
	.go(out),
	.led(ledr[9:0]),
	.count(count[5:0]));
	
initial begin
	clk = 0;
	en = 1;
	reset = 0;
	divideby = 6'd0;
	$display("CASE 1: divideby = %b", divideby);
	repeat(4) begin
		#100
		clk = 1;
		$display("divideby = %b, go = %b, ledr = %b", divideby, clk, ledr);
		#100
		clk = 0;
	end
	
	#100
	clk = 1;
	reset = 1;
	#100
	clk = 0;
	reset = 0;
	divideby = 6'd2;
	$display("CASE 2: divideby = %b", divideby);
	repeat(8) begin
		#100
		clk = 1;
		$display("divideby = %b, go = %b, count = %b, reset = %b, en = %b", divideby, out, count, reset, en);
		#100
		clk = 0;
	end
	
	#100
	clk = 1;
	reset = 1;
	#100
	clk = 0;
	reset = 0;
	divideby = 6'd63;
	$display("CASE 3: divideby = %b", divideby);
	repeat(65) begin
		#100
		clk = 1;
		$display("divideby = %b, go = %b, count = %b, reset = %b, en = %b", divideby, out, count, reset, en);
		#100
		clk = 0;
	end
	
	#100
	clk = 1;
	reset = 1;
	#100
	reset = 0;
	en = 0;
	divideby = 6'd3;
	$display("CASE 3: ENABLE OFF: en = %b", en);
	repeat(5) begin
		#100
		clk = 1;
		$display("divideby = %b, go = %b, count = %b, reset = %b, en = %b", divideby, out, count, reset, en);
		#100
		clk = 0;
	end
end
	
endmodule
