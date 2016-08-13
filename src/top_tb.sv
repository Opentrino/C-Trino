`include "core_main.sv"
`include "memory.sv"

module top_tb;

/* Generate Clock: */
reg clk;
always begin #1 clk = ~clk; end

/***** CPU pins: *****/
wire [7:0]mem_addr;
inout [7:0]mem_data;
wire mrd, mwr;
/********************/

Core  core(clk, mem_addr, mem_data, mrd, mwr);
Memory mem(clk, mem_addr, mem_data, mrd, mwr);

initial begin
	clk = 0;
	
	$dumpfile("top_tb.vcd");
	$dumpvars(0, core, mem);
	
	#10
	#10
	$finish;
end

endmodule