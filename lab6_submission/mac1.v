module mac1(

input clk,
	input start,
	input reset,
	output reg done,
	output reg [10:0] clock_count,
	output reg [5:0] idx_c, idx_b, idx_a,
	output reg we_c, macc_clear,
	output signed[7:0] out_a, out_b,
	output signed [18:0] mac_out
	);


// combinational signals
reg [10:0] clock_count_c;
reg [5:0] idx_a_c;
reg [5:0] idx_b_c;
reg [5:0] idx_c_c;
reg we_c_c, done_c, macc_clear_c, state_c;

wire signed [18:0] out_c;

// data in to single_port_RAM
reg signed [7:0] in_a, in_b;
reg we_a, we_b;

// FSM signals
// 2 states
localparam [1:0] 
    IDLE = 0,
    RUNNING = 1;

reg state;



// read from memory ram A
single_port_RAM #("ram_a_init.txt") reada(
	.clk(clk),
	.we(we_a),
	.addr(idx_a),
	.din(in_a),
	.dout(out_a)
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
	.din(mac_out),
	.dout(out_c)
);

	
// MAC module
MAC mac_inst(
  .in1(out_a),
  .in2(out_b),
  .macc_clear(macc_clear),
  .clk(clk),
  .out(mac_out)
);

initial begin
	idx_a = 0;
	idx_b = 0;
	idx_c = 0;
	state = 0;
	done = 0;
	clock_count = 0;
	macc_clear = 1;
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
		  idx_a <= idx_a_c;
		  macc_clear <= macc_clear_c;
		  we_c <= we_c_c;
        end
end

always @(*) begin
	state_c = state;
	clock_count_c = clock_count;
	idx_a_c = idx_a;
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
				// Last entry in C is computed
				if (clock_count == 513) begin
					done_c = 1;
					state_c = IDLE;
				end else if (clock_count == 0) begin
					idx_c_c = idx_c;
					macc_clear_c = 1;
					idx_a_c = idx_a + 8;
					idx_b_c = idx_b + 1;
				end else begin
					// An entry in C has been computed
					if (clock_count % 8 == 7) begin
						idx_a_c = idx_a - 55;
						idx_b_c = idx_b - 7;
						// An entire column has been computed
						if (clock_count % 64 == 63) begin
							idx_a_c = 0;
							idx_b_c = idx_b + 1;
						end
					end else begin
						idx_a_c = idx_a + 8;
						idx_b_c = idx_b + 1;
						if (clock_count % 8 == 1 && clock_count != 1) begin
							idx_c_c = idx_c + 1;
						end else begin
							idx_c_c = idx_c;
						end
						if (clock_count % 8 == 0) begin
							we_c_c = 1;
							macc_clear_c = 1;
						end else begin
							we_c_c = 0;
							macc_clear_c = 0;
						end
					end
				end
				clock_count_c = clock_count + 1;
			end
		endcase
end

endmodule
