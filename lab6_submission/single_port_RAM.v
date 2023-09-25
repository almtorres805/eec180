// resource: https://verilogguide.readthedocs.io/en/latest/verilog/designs.html#random-access-memory-ram

module single_port_RAM
#(
    parameter file = "", parameter size = 8
)
(
    input wire clk,
    input wire we,
    input wire [5:0] addr,
    input wire signed [size-1:0] din,
    output reg signed [size-1:0] dout
);

reg signed [18:0] mem[63:0];

always @(posedge clk)
begin
    if (we == 1) // write data to address 'addr'
        mem[addr] <= din;
	 // read data from address 'addr'
	 dout <= mem[addr];
end

initial
begin
	if (file != "")
		begin
			$readmemb(file, mem);
		end
end

endmodule 
