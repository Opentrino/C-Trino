`include "defines.sv"

module DRAM (clk, mem_addr, mem_data, mrd, mwr);
	/* Output enable: */
	reg oe = 0;
	
	input clk;
	input [`MEMORY_SIZE_ENC:0]mem_addr;
	inout [`MEMORY_SIZE_ENC:0]mem_data;
	assign mem_data = oe ? internal_mem[mem_addr] : 'bZ;
	
	input mrd;
	input mwr;
	reg [`MEMORY_WIDTH - 1:0]internal_mem[0:`MEMORY_SIZE];
		
	always@(clk or mem_addr or mem_data or mwr or mrd) begin 
		if(clk) begin 
			if(mwr) begin /* Write to Memory: */
				internal_mem[mem_addr] = mem_data;
				oe = 0;
			end else if(mrd) begin /* Read from Memory: */
				oe = 1;
			end else oe = 0;
		end
	end
	
	/* Initialize Memory: */
	initial begin
		integer i;
		for(i = 0; i < `MEMORY_SIZE; i++)
			internal_mem[i] = 'hFF;
	end
endmodule