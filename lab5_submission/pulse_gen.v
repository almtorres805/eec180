module pulse_gen(
	input [5:0] divideby,
	input en,
	input reset,
	input clk,
	output reg go = 1'b0,
	output [9:0] led,
	output reg [5:0] count = 6'd0);

assign led = (divideby == 6'd0) ? 10'h3ff : 10'h000;

always @(posedge clk) begin
	// Reset holds priority
	if (reset == 1'b0) begin
		if (en == 1'b1) begin
			if (divideby == 6'd0) begin
				count <= 6'd0;
				go <= 1'b0;
			end
			else if (count == (divideby - 1)) begin
				count <= 6'd0;
				go <= 1'b1;
			end
			else begin
				count <= count + 6'd1;
				go <= 1'b0;
			end
		end
	end
	else begin
		count <= 6'd0;
		go <= 1'b0;
	end
end
endmodule
