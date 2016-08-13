`include "alu.sv"
`include "defines.sv"

module Regfile();

endmodule

module Pipeline(
	input clk, 
	output reg [`MEMORY_SIZE_ENC:0]mem_addr, 
	inout [`MEMORY_WIDTH - 1:0]mem_data, 
	output reg mrd, 
	output reg mwr
);

reg mem_oe = 0;
reg [7:0]mem_data_buffer = 0;

assign mem_data = mem_oe ? mem_data_buffer : 'bZ;

initial begin
	mrd = 0;
	mwr = 0;
	mem_addr = 0;
end

endmodule
