module buffer4(
	input signed [18:0] mac_out1,
	input signed [18:0] mac_out2,
	input signed [18:0] mac_out3,
	input signed [18:0] mac_out4,
	input [10:0] clock_count,
	input clk,
	output reg signed [18:0] out);

reg signed [18:0] buffer1, buffer2, buffer3;

always @(posedge clk) begin
	out <= mac_out1;
	// Hold values
	if (clock_count % 8 == 1 && clock_count != 1) begin
		buffer1 <= mac_out2;
		buffer2 <= mac_out3;
		buffer3 <= mac_out4;
	end
	if (clock_count % 8 == 2 && clock_count != 2) begin
		out <= buffer1;
	end if (clock_count % 8 == 3 && clock_count != 3) begin
		out <= buffer2;
	end if (clock_count % 8 == 4 && clock_count != 4) begin
		out <= buffer3;
	end
	
end

endmodule

	