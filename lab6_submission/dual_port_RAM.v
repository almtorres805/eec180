module dual_port_RAM
#(
    parameter file = "", parameter size = 8
)
(
    input wire clk,
    input wire we1, we2,
    input wire [5:0] addr1, addr2,
    input wire [size-1:0] din,
    output reg signed [size-1:0] dout1, dout2
);

reg signed [18:0] mem[63:0];

always @(posedge clk)
begin
    if (we1 == 1) begin
        mem[addr1] <= din;
	 end
	 dout1 <= mem[addr1];
	 
	 if (we2 == 1) begin
        mem[addr2] <= din;
	 end
	 dout2 <= mem[addr2];
end

initial
begin
	if (file != "")
		begin
			$readmemb(file, mem);
		end
end

endmodule 