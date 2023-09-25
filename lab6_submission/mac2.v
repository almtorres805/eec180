module mac2(
	input clk,
	input start,
	input reset,
	output reg done,
	output reg [10:0] clock_count,
	output reg [5:0] idx_c, idx_b, idx_a1, idx_a2,
	output reg we_c, macc_clear,
	output signed[7:0] out_a1, out_a2, out_b,
	output signed [18:0] mac_out1, mac_out2, buff_out
	);


// Combinational signals
reg [5:0] idx_a1_c;
reg [5:0] idx_a2_c;
reg [5:0] idx_b_c;
reg [5:0] idx_c_c;
wire signed [18:0] out_c;
reg [10:0] clock_count_c;
reg we_c_c, done_c, macc_clear_c, state_c;

// data in to single and dual port
reg signed [7:0] in_a1, in_a2, in_b;

// enable write to single_port_RAM
reg we_a1, we_a2, we_b;

// FSM signals
// 2 states
localparam [1:0] 
    IDLE = 0,
    RUNNING = 1;

reg state;

// read from memory ram A
dual_port_RAM #("ram_a_init.txt") reada(
	.clk(clk),
	.we1(we_a1),
	.we2(we_a2),
	.addr1(idx_a1),
	.addr2(idx_a2),
	.din(in_a1),
	.dout1(out_a1),
	.dout2(out_a2)
);
	
// read from memory ram B
single_port_RAM #("ram_b_init.txt") readb(
	.clk(clk),
	.we(we_b),
	.addr(idx_b),
	.din(in_b),
	.dout(out_b)
);

// write to memory
single_port_RAM #(
	.file(""),
	.size(19)
	)
	RAMOUTPUT(
	.clk(clk),
	.we(we_c),
	.addr(idx_c),
	.din(buff_out),
	.dout(out_c)
);
	
// row 0,2,4,6 multiplied by each column
MAC mac1(
  .in1(out_a1),
  .in2(out_b),
  .macc_clear(macc_clear),
  .clk(clk),
  .out(mac_out1)
);

// row 1,3,5,7 multiplied by each column
MAC mac2(
  .in1(out_a2),
  .in2(out_b),
  .macc_clear(macc_clear),
  .clk(clk),
  .out(mac_out2)
);

buffer buff(
	.mac_out1(mac_out1),
	.mac_out2(mac_out2),
	.clock_count(clock_count),
	.clk(clk),
	.out(buff_out)
);

initial begin
	idx_a1 = 0;
	idx_a2 = 1;
	idx_b = 0;
	idx_c = 0;
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
		  idx_c <= idx_c_c;
		  idx_b <= idx_b_c;
		  idx_a1 <= idx_a1_c;
		  idx_a2 <= idx_a2_c;
		  macc_clear <= macc_clear_c;
		  we_c <= we_c_c;
        end
end

always @(*) begin
	state_c = state;
	clock_count_c = clock_count;
	idx_a1_c = idx_a1;
	idx_a2_c = idx_a2;
	idx_b_c = idx_b;
	idx_c_c = idx_c;
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
				if (clock_count == 259) begin
					done_c = 1;
					state_c = IDLE;
				end else if (clock_count == 0) begin
					idx_c_c = idx_c;
					macc_clear_c = 1;
					idx_a1_c = idx_a1 + 8;
					idx_a2_c = idx_a2 + 8;
					idx_b_c = idx_b + 1;
				end else begin
					if (clock_count % 8 == 7) begin
						idx_a1_c = idx_a1 - 54;
						idx_a2_c = idx_a2 - 54;
						idx_b_c = idx_b - 7;
						if (clock_count % 32 == 31) begin
							idx_a1_c = 0;
							idx_a2_c = 1;
							idx_b_c = idx_b + 1;
						end
					end else begin
						idx_a1_c = idx_a1 + 8;
						idx_a2_c = idx_a2 + 8;
						idx_b_c = idx_b + 1;
						if(clock_count % 8 == 0) begin
							macc_clear_c = 1;
						end else begin
							macc_clear_c = 0;
						end
						if ((clock_count % 8 == 1 && clock_count != 1) | (clock_count % 8 == 2 && clock_count != 2)) begin
								we_c_c = 1;
						end else begin
								we_c_c = 0;
						end
						if ((clock_count % 8 == 2 && clock_count != 2) | clock_count % 8 == 3 && clock_count != 3) begin
							idx_c_c = idx_c + 1;
						end else begin
							idx_c_c = idx_c;
						end
					end
				end
				clock_count_c = clock_count + 1;
			end
		endcase
end

endmodule
