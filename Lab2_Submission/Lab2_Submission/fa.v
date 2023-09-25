module fa(
	input a,
	input b,
	input ci,
	output wire co,
	output wire sum
);

assign sum = a ^ b ^ ci;
assign co = (a&b) | (a&ci) | (b&ci);

endmodule