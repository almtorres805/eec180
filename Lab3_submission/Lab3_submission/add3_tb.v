`timescale 1ps/1ps 
module add3_tb;
reg [2:0] a;
reg [2:0] b;
wire [3:0] s; 
reg ci;

add3 inst1(
	.a (a),
	.b (b),
	.ci (ci),
	.s (s[3:0]));
	
 
initial begin
	ci = 1'b0; 
	a = 0;
	b = 0;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s); 
	
	a = 0;
	b = 1;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 1;
	b = 0;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 5;
	b = 5;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 7;
	b = 0;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 7;
	b = 7;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 1;
	b = 1;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 2;
	b = 3;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 6;
	b = 1;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 3;
	b = 0;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 7;
	b = 5;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 4;
	b = 2;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 5;
	b = 2;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 1;
	b = 6;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
	a = 7;
	b = 3;
	#100
	$display("in = %b, in = %b, out = %b", a, b, s);
	
end
 
endmodule
