module buffer8(
	input signed [18:0] mac_out1,
	input signed [18:0] mac_out2,
	input signed [18:0] mac_out3,
	input signed [18:0] mac_out4,
	input signed [18:0] mac_out5,
	input signed [18:0] mac_out6,
	input signed [18:0] mac_out7,
	input signed [18:0] mac_out8,
	input [10:0] clock_count,
	input clk,
	output reg signed [18:0] out, out2);

reg signed [18:0] buffer1, buffer2, buffer3, buffer4, buffer5, buffer6, buffer7;

always @(posedge clk) begin
	out <= mac_out1;
	out2 <= mac_out2;
	// Hold values
	if (clock_count % 8 == 1 && clock_count != 1) begin
		buffer1 <= mac_out3;
		buffer2 <= mac_out4;
		buffer3 <= mac_out5;
		buffer4 <= mac_out6;
		buffer5 <= mac_out7;
		buffer6 <= mac_out8;
	end
	if (clock_count % 8 == 2 && clock_count != 2) begin
		out <= buffer1;
		out2 <= buffer2;
	end if (clock_count % 8 == 3 && clock_count != 3) begin
		out <= buffer3;
		out2 <= buffer4;
	end if (clock_count % 8 == 4 && clock_count != 4) begin
		out <= buffer5;
		out2 <= buffer6;
	end
	
end

endmodule


	