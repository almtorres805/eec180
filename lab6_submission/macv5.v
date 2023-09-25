module mac8(
	input clk, start, reset,
	output reg done,
	output reg [10:0] clock_count,
	output reg [5:0] idx_a1, idx_a2, idx_a3, idx_a4, idx_a5, idx_a6, idx_a7, idx_a8,
	output reg [5:0] idx_c1, idx_c2, idx_b,
	output reg we_c, macc_clear,
	output signed[7:0] out_a1, out_a2, out_a3, out_a4, out_a5, out_a6, out_a7, out_a8,
	output signed [7:0] out_b,
	output signed [18:0] mac_out1, mac_out2, mac_out3, mac_out4,
	output signed [18:0] mac_out5, mac_out6, mac_out7, mac_out8, buff_out1, buff_out2
	);

 
reg [5:0] idx_a1_c, idx_a2_c, idx_a3_c, idx_a4_c, idx_a5_c, idx_a6_c, idx_a7_c, idx_a8_c;
reg [5:0] idx_b_c, idx_c1_c, idx_c2_c;
reg [10:0] clock_count_c;
reg we_c_c, done_c, macc_clear_c, state_c;
reg signed [7:0] in_a;
reg signed [7:0] in_b;
reg we_a1, we_a2, we_b;

localparam [1:0] 
    IDLE = 0,
    RUNNING = 1;

reg state;

wire signed [18:0] out_c;


// read from memory ram A
dual_port_RAM #("ram_a_init.txt") row01(.clk(clk), .we1(we_a1), .we2(we_a2), .addr1(idx_a1), .addr2(idx_a2), .din(in_a), .dout1(out_a1), .dout2(out_a2));
dual_port_RAM #("ram_a_init.txt") row23(.clk(clk), .we1(we_a1), .we2(we_a2), .addr1(idx_a3), .addr2(idx_a4), .din(in_a), .dout1(out_a3), .dout2(out_a4));
dual_port_RAM #("ram_a_init.txt") row45(.clk(clk), .we1(we_a1), .we2(we_a2), .addr1(idx_a5), .addr2(idx_a6), .din(in_a), .dout1(out_a5), .dout2(out_a6));
dual_port_RAM #("ram_a_init.txt") row67(.clk(clk), .we1(we_a1), .we2(we_a2), .addr1(idx_a7), .addr2(idx_a8), .din(in_a), .dout1(out_a7), .dout2(out_a8));

// read from memory ram b
single_port_RAM #("ram_b_init.txt") readb(.clk(clk), .we(we_b), .addr(idx_b), .din(in_b), .dout(out_b));

// write to memory
dual_port1_RAM #(
	.file(""),
	.size(19)
	)
	RAMOUTPUT(.clk(clk), .we1(we_c), .we2(we_c), .addr1(idx_c1), .addr2(idx_c2), .din1(buff_out1), .din2(buff_out2), .dout1(out_c), .dout2(out_c));
	
MAC mac1(.in1(out_a1), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out1));
MAC mac2(.in1(out_a2), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out2));
MAC mac3(.in1(out_a3), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out3));
MAC mac4(.in1(out_a4), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out4));
MAC mac5(.in1(out_a5), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out5));
MAC mac6(.in1(out_a6), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out6));
MAC mac7(.in1(out_a7), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out7));
MAC mac8(.in1(out_a8), .in2(out_b), .macc_clear(macc_clear), .clk(clk), .out(mac_out8));

buffer8 buff(.mac_out1(mac_out1), .mac_out2(mac_out2), .mac_out3(mac_out3), .mac_out4(mac_out4), .mac_out5(mac_out5), .mac_out6(mac_out6), .mac_out7(mac_out7), .mac_out8(mac_out8), .clock_count(clock_count), .clk(clk), .out(buff_out1), .out2(buff_out2));

initial begin
	idx_a1 = 0;
	idx_a2 = 1;
	idx_a3 = 2;
	idx_a4 = 3;
	idx_a5 = 4;
	idx_a6 = 5;
	idx_a7 = 6;
	idx_a8 = 7;
	idx_b = 0;
	idx_c1 = 0;
	idx_c2 = 1;
	state = 0;
	done = 0;
	clock_count = 0;
	macc_clear = 1;
	we_c = 0;
end

always @(posedge clk)
begin
	if(reset) // go to state zero if reset
        begin
        clock_count <= 0;
        state <= IDLE;
		  done <= 0;
        end
    else // otherwise update the states
        begin
        clock_count <= clock_count_c;
        state <= state_c;
		  done <= done_c;
		  idx_c1 <= idx_c1_c;
		  idx_c2 <= idx_c2_c;
		  idx_b <= idx_b_c;
		  idx_a1 <= idx_a1_c;
		  idx_a2 <= idx_a2_c;
		  idx_a3 <= idx_a3_c;
		  idx_a4 <= idx_a4_c;
		  idx_a5 <= idx_a5_c;
		  idx_a6 <= idx_a6_c;
		  idx_a7 <= idx_a7_c;
		  idx_a8 <= idx_a8_c;
		  macc_clear <= macc_clear_c;
		  we_c <= we_c_c;
        end
end

always @(*) begin
	state_c = state;
	clock_count_c = clock_count;
	idx_a1_c = idx_a1;
	idx_a2_c = idx_a2;
	idx_a3_c = idx_a3;
	idx_a4_c = idx_a4;
	idx_a5_c = idx_a5;
	idx_a6_c = idx_a6;
	idx_a7_c = idx_a7;
	idx_a8_c = idx_a8;
	idx_b_c = idx_b;
	idx_c1_c = idx_c1;
	idx_c2_c = idx_c2;
	we_c_c = we_c;
	macc_clear_c = macc_clear;
	case (state)
		IDLE: begin
			if (start) begin
					state_c = RUNNING;
					done_c = 0;
					macc_clear_c = 0;
			end
			else begin
					state_c = IDLE;
					done_c = 0;
			end
		end
			
		RUNNING: begin
			if (clock_count == 69) begin
				done_c = 1;
				state_c = IDLE;
			end else if (clock_count == 0) begin
				idx_c1_c = idx_c1;
				idx_c2_c = idx_c2;
				macc_clear_c = 1;
				idx_a1_c = idx_a1 + 8;
				idx_a2_c = idx_a2 + 8;
				idx_a3_c = idx_a3 + 8;
				idx_a4_c = idx_a4 + 8;
				idx_a5_c = idx_a5 + 8;
				idx_a6_c = idx_a6 + 8;
				idx_a7_c = idx_a7 + 8;
				idx_a8_c = idx_a8 + 8;
				idx_b_c = idx_b + 1;
			end else begin
				if (clock_count % 8 == 7) begin
					idx_a1_c = 0;
					idx_a2_c = 1;
					idx_a3_c = 2;
					idx_a4_c = 3;
					idx_a5_c = 4;
					idx_a6_c = 5;
					idx_a7_c = 6;
					idx_a8_c = 7;
					idx_b_c = idx_b + 1;
				end else begin
					idx_a1_c = idx_a1 + 8;
					idx_a2_c = idx_a2 + 8;
					idx_a3_c = idx_a3 + 8;
					idx_a4_c = idx_a4 + 8;
					idx_a5_c = idx_a5 + 8;
					idx_a6_c = idx_a6 + 8;
					idx_a7_c = idx_a7 + 8;
					idx_a8_c = idx_a8 + 8;
					idx_b_c = idx_b + 1;
					we_c_c = 0;
					if(clock_count % 8 == 0) begin
						macc_clear_c = 1;
					end else begin
						macc_clear_c = 0;
					end
				end
				if (clock_count >= 10) begin
					idx_c1_c = idx_c1 + 2;
					idx_c2_c = idx_c2 + 2;
					we_c_c = 1;
					if (clock_count % 8 >= 5 | clock_count % 8 == 0) begin
						idx_c1_c = idx_c1;
						idx_c2_c = idx_c2;
						we_c_c = 0;
					end
				end else begin
					idx_c1_c = idx_c1;
					idx_c2_c = idx_c2;
					if (clock_count >= 9) begin
						we_c_c = 1;
					end else begin
						we_c_c = 0;
					end
				end
			end
			clock_count_c = clock_count + 1;
		end
	endcase
end

endmodule
