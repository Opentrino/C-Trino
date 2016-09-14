`include "defines.sv"
`include "subcore.sv"
`include "uncore.sv"

 /********** START OF MODULE: Die **********
 * Description: Top Level CPU which contains the Cores and Caches
 ******************************************/
module Die(
	output clk, 
	output [`MEMORY_SIZE_ENC:0] mem_addr, 
	inout  [`MEMORY_WIDTH - 1:0]mem_data, 
	output mrd, 
	output mwr
);

/*************************/
/* L2 Cache Declaration: */
L2_Cache l2_cache(clk);
/*************************/

/*************************/
/* Sub Core Declaration: */
SubCore core1(clk, mem_addr, mem_data, mrd, mwr);
/*************************/

/**************************************************************/
/* Uncore (outside all cores but inside the die) Declaration: */
/**************************************************************/
Uncore uncore(clk);
/**************************************************************/

endmodule
/******** END OF MODULE: Die ********/
/*************************************/
