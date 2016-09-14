/****************************************************************************
 * uncore.sv
 ****************************************************************************/
`include "l3_cache.sv"

/**
 * Module: Uncore
 * 
 * TODO: Add module documentation
 */
module Uncore(output reg clk);
	/* Declare L3 Cache */
	L3_Cache l3_cache(clk);
	
	/* TODO: Declare 'DDR3 DRAM Controller' */
	
	/* Generate Clock: */
	always begin #1 clk = ~clk; end
	initial begin clk = 0; end
	
	always@(clk) begin
		
	end
endmodule
