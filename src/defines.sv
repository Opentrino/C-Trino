`ifndef DEFINES_SV_
`define DEFINES_SV_

/**********************/
/* MEMORY RAM DEFINES */
/**********************/
`define MEMORY_SIZE 256
`define MEMORY_WIDTH 8
`define MEMORY_SIZE_ENC ($clog2(`MEMORY_SIZE) - 1)
/**********************/

/**************************/
/* MICROCODE UNIT DEFINES */
/**************************/
`define UC_CTRL_WIDTH 32
`define UC_FUNC_WIDTH 32
`define UC_CTRL_DEPTH 200
`define UC_SEGMENT_MAXCOUNT 200
`define UC_CALLSTACK_SIZE 256
/**************************/

/***********************/
/* FETCH STAGE DEFINES */
/***********************/

/***********************/
`endif