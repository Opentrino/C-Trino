`include "defines.sv"
`include "l2_cache.sv"
`include "l1_icache.sv"
`include "l1_dcache.sv"
`include "fetch_stage.sv"
`include "predecode_stage.sv"
`include "microcode.sv"
`include "register_file.sv"
`include "execution_stage.sv"
`include "memory_access_stage.sv"

/* Microarchitecture TODO-List:
 ********************************************
 * 1- PreFetch Stage
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
 * 2- PreDecode Stage (x86 Instruction Format: Prefix | Opcode | ModR/M (Mod|Reg/Opcode|[R/M]) | SIB (Scale|Index|Base) | Displacement | Immediate)
 * 2.1- Fetch (from Fetch Stage)
 * 2.2- Prefetch Buffers
 * 2.3- Instruction Length Decoder
 * 2.4- Instruction Queue (IQ)
 * 2.5- MSROM | Complex Dec. | Simple Dec. | Simple Dec. | ...
 * 2.6- Instruction Decoder Queue (IDQ)
 * 2.7- Register Rename (Forward)
 ********************************************
 * 3- Microcode Stage
 * 3.1- Translate Opcode into multiple micro operations (outputted in a burst in parallel and with very wide channels)
 * 3.2- Put these microops into a large FIFO queue in order to be distributed through the entire Core in multiple channels
 ********************************************
 * 4- Rename Stage
 * 4.1- Register Rename (RAT)
 * 4.2- Instruction Dispatch
 ********************************************
 * 5- Issue Stage (Out of Order)
 * 5.1- Reorder Buffer (ROB) | Issue Queue | Load Store Queue (Located on the Execute Stage)
 * 5.2- (TODO: Rest of Pipeline)
 ********************************************
 * 6- Execute Stage
 * 6.1- Load Store Queue
 * 6.2- Data Cache
 * 6.3- Registers
 * 6.4- Integer/FP Units
 * 6.5- SIMD
 * 6.6- Pipeline Bypassing (Data Hazards)
 ********************************************
 * 7- Memory Access Stage
 * 7.1- Perform a Load or a Store on this stage
 * 7.2- Implement AGU (Address Generation Unit)
 ********************************************
 * 8- Writeback Stage
 * 8.1- Write Back to the Registers, Data Cache and/or Commit Stage
 ********************************************
 * 9- Commit Stage
 * 9.1- Exception Handling
 * 9.2- Misprediction
 * 9.3- Retire Register File
 * 9.4- Merged Register File
 ********************************************
 CACHES (Set Associative | Data Cache | Instruction Cache | Trace Cache | MMU / Virtual Memory | L1 / L2 / L3):
 * 1- Address Calculation (tag + set + offset)
 * 2- Disambiguation (Address Decoders)
 * 3- Tag Access (Tag Array)
 * 4- Data Access (Data Array)
 * 5- Result Drive (Aligner + Hit or Miss) */

/********** START OF MODULE: SubCore **********
 * Description: Single Core declaration that will be instantiated together with other Cores
 ******************************************/
module SubCore(
	input clk, /* CPU Clock (undivided) */
	output [`MEMORY_SIZE_ENC:0] mem_addr, /* DDR3 DRAM Memory Address */
	inout  [`MEMORY_WIDTH - 1:0]mem_data, /* Bidirectional DRAM Data Bus  */
	output mrd, /* Memory Read */
	output mwr  /* Memory Write */
);

/*************************************/
/* L1 Instruction Cache Declaration: */
L1_ICache l1_icache();
/*************************************/

/* Stages: */
/***** 1- PreFetch Stage *****/
/* Description:
 * - Fetch 1/2/3/X (variable length) bytes from the L1 I-Cache cache and *push* it into a prefetch buffer queue (FIFO, still as a 
 *   normal opcode, not a microop).
 * - Everytime we fetch INTO the Prefetch buffers, we use the actual program counter EIP on the L1 I-Cache. 
 * - If there's a miss on the L1 I-Cache, we tell the L2 Cache that there was a miss. This stage will then fetch from L2.
 * If it misses the L2 Cache, it (the L2 Cache itself) should go fetch from the L3 Cache.
 * If it misses again, it'll go ask (the L3 Cache) directly the DRAM Controller. */
Stage_PreFetch stage1_prefetch(clk);

/***** 2- PreDecode Stage *****/
/* Description:
 * - We must pop from the Prefetch Buffers (from the previous stage) and decode the instructions 
 * so we can take care of Branching Prediction, calculate the total length of the instruction, 
 * and figure out all the fields in the instruction format, including addressing types, source
 * of operands, and their destination.
 * - We must do this more than one time in parallel, to achieve a superscalar CPU.
 */
Stage_PreDecode stage2_predecode(clk);

/***** 3- Microcode Stage *****/
/* Description:
 * - Pop from the Prefetch queue (FIFO), go through the PreDecode Stage and then receive the data from the queue into the Microcode Unit, 
 * where it will be automatically decoded (the opcode of the instruction that was popped from the queue IS the microcode memory address, 
 * where the entire memory segment will be dumped into the control signals. These control signals should be sent into a buffered
 * pipeline). This will generate multiple bytes which are the multi-cycle micro operations that actually go into the 
 * control signals of the entire core.
 * - The MicroOp stage has internal subsections, for the integer operations, fp operations,
 * load/store operations and so on. This means the MicroOp unit should have multiple 'microop program counters', one for each
 * section.
 * - This also means we should pop multiple instructions at one time from the prefetch buffers
 * - The prefetch and predecode stage should fetch multiple bytes from memory at a very fast rate without worrying about what the 
 * microop stage does. */
wire [`UC_CTRL_WIDTH:0] uop; /* Control Wires FROM the Microcode unit, AKA MicroOp */
wire uc_eos; /* End of Signal Wire FROM the Microcode unit */
reg [5:0] uc_opcode = 0; /* Opcode FOR the Microcode unit */
reg uc_sos = 0; /* Start flag FOR the Microcode unit */
Microcode stage3_microcode(clk, uop, uc_opcode, uc_eos, uc_sos);

/***** 4- Rename Stage *****/
/* TODO: Add Reorder Buffer and Register Allocation Table (RAT) */
RegFile registers(clk);

/***** 5- Issue Stage (TODO) *****/
/* TODO: Add Reservation Stations */

/***** 6- Execute Stage *****/
Execution_Stage stage6_execute(clk);

/***** 7- Memory Access *****/
Memory_Access_Stage stage7_memory_access(clk);
/******************************/
/* L1 Data Cache Declaration: */
L1_DCache l1_dcache();
/******************************/

/***** 8- Writeback Stage *****/
/* XXX: May not need to declare any module here */

/***** 9- Commit Stage *****/
/* TODO: Requires Reorder Buffer */

endmodule
/******** END OF MODULE: SubCore ********/
/****************************************/