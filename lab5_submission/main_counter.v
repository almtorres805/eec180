module main_counter(
	input en1,
	input en2,
	input up_down,
	input free_run,
	input reset,
	input clk,
	output reg [23:0] count = 0);
	
always @(posedge clk) begin
	if (reset == 1'b0) begin
		if (en1 == 1'b1 && en2 == 1'b1) begin

			// Increment indefinitely
			if (free_run == 1'b1 && up_down == 1'b1) begin
				count <= (count == 24'hFFFFFF) ? 24'd0: count + 1;
			end
	
			// decrement indefinitely
			else if (free_run == 1'b1 && up_down == 1'b0) begin
				count <= (count == 24'd0) ? 24'hFFFFFF: count - 1;
			end
			
			else if (free_run == 1'b0) begin
				// Halt at half of max value
				if (count == 24'd8388607) begin
					count <= count;
				end
				else if (up_down == 1'b1) begin
					count <= (count == 24'hFFFFFF) ? 24'd0: count + 1;
				end
				else begin
					count <= (count == 24'd0) ? 24'hFFFFFF: count - 1;
				end
			end
		end
	end
	// Reset has priority 
	if (reset == 1'b1) begin
		count <= 24'd0;
	end
end
	
endmodule
