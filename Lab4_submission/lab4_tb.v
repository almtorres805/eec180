`timescale 1ps/1ps 
module lab4_tb;
reg [1:0] KEY;
reg [3:0] SW;
wire [9:0] LEDR;

// Instanstiate shift register
lab4 test(KEY, SW, LEDR);

initial begin
	// All LED's off
	SW = 4'b1100;
	KEY = 2'b00;
	#100
	KEY = 2'b11;
	#100
	$display("---Turn off all LED's---");
	$display("sw = %b, output = %b", SW, LEDR);
	$display("---Next 15 cycles---");
	repeat(15) begin
			KEY[0] = 0;
			#100
			KEY[0] = 1;
			#100
			$display("output = %b", LEDR);
	end
	
	// Alternating LED's
	SW = 4'b0101;
	KEY = 2'b00;
	#100
	KEY = 2'b11;
	#100
	$display("---Alternate LED's---");
	$display("sw = %b, output = %b", SW, LEDR);
	$display("--- Next 15 cycles---");
	repeat(15) begin
			KEY[0] = 0;
			#100
			KEY[0] = 1;
			#100
			$display("output = %b", LEDR);
	end

	// All LED's on
	SW = 4'b0111;
	KEY = 2'b00;
	#100
	KEY = 2'b11;
	#100
	$display("---Turn on all LED's---");
	$display("sw = %b, output = %b", SW,LEDR);
	$display("---Next 15 cycles---");
	repeat(15) begin
			KEY[0] = 0;
			#100
			KEY[0] = 1;
			#100
			$display("output = %b", LEDR);
	end
	
	// All LED's on
	SW = 4'b0111;
	KEY = 2'b00;
	#100
	KEY = 2'b11;
	#100
	$display("---Turn on all LED's---");
	$display("sw = %b, output = %b", SW, LEDR);
	$display("---Next 25 cycles---");
	repeat(25) begin
			KEY[0] = 0;
			#100
			KEY[0] = 1;
			#100
			$display("output = %b", LEDR);
	end
end

endmodule
