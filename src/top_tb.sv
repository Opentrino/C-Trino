`include "chip_die.sv"
`include "dram.sv"

module top_tb;

/***** CPU pins: *****/
wire  [7:0]mem_addr;
inout [7:0]mem_data;
wire mrd, mwr;
/********************/

Die  die (clk, mem_addr, mem_data, mrd, mwr);
DRAM dram(clk, mem_addr, mem_data, mrd, mwr);

initial begin
	$dumpfile("top_tb.vcd");
	$dumpvars(0, die, dram);
	
	#10
	#10
	$finish;
end

endmodule