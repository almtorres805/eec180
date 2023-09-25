module buffer (
	input signed [18:0] mac_out1,
	input signed [18:0] mac_out2,
	input [10:0] clock_count,
	input clk,
	output reg signed [18:0] out);

reg signed [18:0] buffer;

always @(posedge clk) begin
	out <= mac_out1;
	if (clock_count % 8 == 1 && clock_count != 1) begin
		buffer <= mac_out2;
	end
	if (clock_count % 8 == 2 && clock_count != 2) begin
		out <= buffer;
	end
end

endmodule

	