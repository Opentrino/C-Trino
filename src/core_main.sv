`include "fetch_stage.sv"
`include "l2_cache.sv"
`include "l1_icache.sv"
`include "l1_dcache.sv"
`include "microcode.sv"
`include "defines.sv"

/* TODO: */
/* Overview:
 ********************************************
 * 1- Fetch Stage
 *  1.1- Next Fetch Address prediction
 *    1.1.1- Branch Target Buffer (BTB)
 *    1.1.2- Next Sequential Fetch addr
 *    1.1.3- Branch Predictor
 *    1.1.4- Return Address Stack (RAS)
 *  1.2- Fetch address calculation
 *    1.2.1- Calculate address tag + index + offset
 *  1.3- ICache Access
 *    1.3.1- ICache Data Array
 *    1.3.2- ICache Tag Array
 *    1.3.3- ITLB Array
 *  1.4- Instruction drive to decode stage
 *    1.4.1- Aligner
 ********************************************
 * 2- Decode Stage (x86 Instruction Format: Prefix | Opcode | ModR/M (Mod|Reg/Opcode|[R/M]) | SIB (Scale|Index|Base) | Displacement | Immediate)
 * 2.1- Fetch (from Fetch Stage)
 * 2.2- Prefetch Buffers
 * 2.3- Instruction Length Decoder
 * 2.4- Instruction Queue (IQ)
 * 2.5- MSROM | Complex Dec. | Simple Dec. | Simple Dec. | ...
 * 2.6- Instruction Decoder Queue (IDQ)
 * 2.7- Register Rename (Forward)
 ********************************************
 * 3- Rename Stage
 * 3.1- Register Rename (RAT)
 * 3.2- Instruction Dispatch
 ********************************************
 * 4- Issue Stage (Out of Order)
 * 4.1- Reorder Buffer (ROB) | Issue Queue | Load Store Queue (Located on the Execute Stage)
 * 4.2- (TODO: Rest of Pipeline)
 ********************************************
 * 5- Execute Stage
 * 5.1- Load Store Queue
 * 5.2- Data Cache
 * 5.3- Registers
 * 5.4- Integer/FP Units
 * 5.5- SIMD
 * 5.6- Pipeline Bypassing (Data Hazards)
 ********************************************
 * 6- Writeback Stage
 * 6.1- Write Back to the Registers, Data Cache and Commit Stage
 ********************************************
 * 7- Commit Stage
 * 7.1- Exception Handling
 * 7.2- Misprediction
 * 7.3- Retire Register File
 * 7.4- Merged Register File
 ********************************************
 CACHES (Set Associative | Data Cache | Instruction Cache | Trace Cache | MMU / Virtual Memory | L1 / L2 / L3):
 * 1- Address Calculation (tag + set + offset)
 * 2- Disambiguation (Address Decoders)
 * 3- Tag Access (Tag Array)
 * 4- Data Access (Data Array)
 * 5- Result Drive (Aligner + Hit or Miss)
 */
 

/********** START OF MODULE: SubCore **********
 * Description: Single Core declaration that will be instantiated together with other Cores
 ******************************************/
module SubCore(
	input clk, 
	output [`MEMORY_SIZE_ENC:0]mem_addr, 
	inout [`MEMORY_WIDTH - 1:0]mem_data, 
	output mrd, 
	output mwr
);

/*******************************/
/* Microcode Unit Declaration: */
wire [`UC_CTRL_WIDTH:0] uop; /* Control Wires FROM the Microcode unit, AKA MicroOp */
wire uc_eos; /* End of Signal Wire FROM the Microcode unit */

reg [5:0] uc_opcode = 0; /* Opcode FOR the Microcode unit */
reg uc_sos = 0; /* Start flag FOR the Microcode unit */

Microcode ucode(clk, uop, uc_opcode, uc_eos, uc_sos);
/*******************************/

/*************************************/
/* L1 Instruction Cache Declaration: */
L1_ICache l1_icache();
/*************************************/

/******************************/
/* L1 Data Cache Declaration: */
L1_DCache l1_dcache();
/******************************/

/* Stages: */
/* 1- Fetch Stage */
Stage_Fetch s_fetch();
/* 2- Decode Stage */
/* 3- Rename Stage */
/* 4- Issue Stage */
/* 5- Execute Stage */
/* 6- Writeback Stage */
/* 7- Commit Stage */

endmodule
/******** END OF MODULE: SubCore ********/
/****************************************/

/********** START OF MODULE: Core **********
 * Description: Top Level CPU which contains the Cores and Caches
 ******************************************/
module Core(
	input clk, 
	output [`MEMORY_SIZE_ENC:0]mem_addr, 
	inout [`MEMORY_WIDTH - 1:0]mem_data, 
	output mrd, 
	output mwr
);

/*************************/
/* L2 Cache Declaration: */
L2_Cache l2_cache();
/*************************/

/*************************/
/* Sub Core Declaration: */
SubCore score(clk, mem_addr, mem_data, mrd, mwr);
/*************************/

endmodule
/******** END OF MODULE: Core ********/
/*************************************/
