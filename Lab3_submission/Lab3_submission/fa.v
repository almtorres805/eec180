module fa(
	input in1,
	input in2,
	input ci,
	output wire co,
	output wire sum
);

assign sum = in1 ^ in2 ^ ci;
assign co = (in1&in2) | (in1&ci) | (in2&ci);

endmodule