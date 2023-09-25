module MAC(
	input signed [7:0] in1,
	input signed [7:0] in2,
	input macc_clear,
	input clk,
	output reg signed [18:0] out = 0);

wire signed [18:0] D;
assign D = (macc_clear == 1'b1) ? in1 * in2 : ((in1 * in2) + out);

always @(posedge clk) begin
	out <= D;
end
endmodule


