module add4bit(
	input [3:0]in1,
	input [3:0]in2,
	input ci,
	output co,
	output [3:0]sum
);

// Output of the first 3 adders
wire [2:0] fa_co;

fa inst1(in1[0], in2[0], ci, fa_co[0], sum[0]);
fa inst2(in1[1], in2[1], fa_co[0], fa_co[1], sum[1]);
fa inst3(in1[2], in2[2], fa_co[1], fa_co[2], sum[2]);
fa inst4(in1[3], in2[3], fa_co[2], co, sum[3]);
	
endmodule