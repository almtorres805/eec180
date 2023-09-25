`timescale 1ps/1ps 
module lab4(
	input [1:0]	KEY,
	input [3:0] SW,
	output reg [9:0] LEDR
);

always @(posedge ~KEY[0]) begin
	if (LEDR == 10'b0000000000) begin
		LEDR[9] <= #1 1'b1;
	end
	else begin
		LEDR[9] <= #1 1'b0;
	end
	
	LEDR[8] <= #1 LEDR[9];
	LEDR[7] <= #1 LEDR[8];
	LEDR[6] <= #1 LEDR[7];
	LEDR[5] <= #1 LEDR[6];
	LEDR[4] <= #1 LEDR[5];
	LEDR[3] <= #1 LEDR[4];
	LEDR[2] <= #1 LEDR[3];
	LEDR[1] <= #1 LEDR[2];
	LEDR[0] <= #1 LEDR[1];
	
	case({~KEY[1], SW})
		// SW[3:0] = 1100 turns off LED's
		5'b11100: LEDR <= #1 10'b0000000000;
		// SW[3:0] = 0101 alternate LED's
		5'b10101: LEDR <= #1 10'b1010101010;
		// SW[3:0] = 0111 turns on LED's
		5'b10111: LEDR <= #1 10'b1111111111;
	endcase
end


endmodule
