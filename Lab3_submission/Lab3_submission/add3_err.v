
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module add3_err(
	input [2:0] a,
	input [2:0] b,
	output [3:0] s);



//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [3:0] s_temp;



//=======================================================
//  Structural coding
//=======================================================

always @(*) begin
	s_temp = a + b;
	if ((a == 4'b111 & b == 4'b100) | (b == 4'b111 & a == 4'b100))
		s_temp = 4'b1100;
end

assign s = s_temp;

endmodule
