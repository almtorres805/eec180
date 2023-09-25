module add3_ref_tb;
reg [2:0] a;
reg [2:0] b;
wire [3:0] sum;
wire [3:0] golden_ref; 
reg ci;
integer i;
integer j;

add3 test(
	.a (a),
	.b (b),
	.ci (ci),
	.s (sum));
	

add3_ref golden(
	.a (a),
	.b (b),
	.s (golden_ref));
	

initial begin

	ci = 1'b0;
	for (i = 0; i < 8; i = i + 1'b1) begin
		for (j = 0; j < 8; j = j + 1'b1) begin
			a <= i;
			b <= j;
			#100
			$display("in = %b, in = %b, test = %b, golden = %b", a, b, sum, golden_ref);
			if (sum == golden_ref)
				$display("pass");
			else
				$display("fail");
		end
	end
	
end

endmodule
