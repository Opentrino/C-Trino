`define ALU_WIDTH 8
`define ALU_FUNC_WIDTH 5

module  alu(a,b,ci,f,s,co);
	input wire [`ALU_WIDTH - 1:0] a,b;
	input wire ci;
	input wire [`ALU_FUNC_WIDTH - 1:0] f;
	output reg [`ALU_FUNC_WIDTH - 1:0] s;
	output reg co;
	
	always@(a or b or ci or f) begin
		case(f)
		`ALU_FUNC_WIDTH'd0: s <= s; /* NoOp/Buffer */
		`ALU_FUNC_WIDTH'd1: s <= a + b; /* Add */
		`ALU_FUNC_WIDTH'd2: s <= a - b; /* Sub */
		`ALU_FUNC_WIDTH'd3: s <= a * b; /* Mul */
		`ALU_FUNC_WIDTH'd4: s <= a / b; /* Div */
		`ALU_FUNC_WIDTH'd5: s <= a % b; /* Mod */
		`ALU_FUNC_WIDTH'd6: s <= a | b; /* Or */
		`ALU_FUNC_WIDTH'd7: s <= a & b; /* And */
		`ALU_FUNC_WIDTH'd8: s <= ~(a & b); /* Nand */
		`ALU_FUNC_WIDTH'd9: s <= a ^ b; /* Xor */
		`ALU_FUNC_WIDTH'd10: s <= ~a; /* Inverse */
		`ALU_FUNC_WIDTH'd11: s <= !a; /* Logical Not */
		`ALU_FUNC_WIDTH'd12: s <= a || b; /* Logical Or */
		`ALU_FUNC_WIDTH'd13: s <= a && b; /* Logical And */
		`ALU_FUNC_WIDTH'd14: s <= a << b; /* Shift Left */
		`ALU_FUNC_WIDTH'd15: s <= a >> b; /* Shift Right */
		`ALU_FUNC_WIDTH'd16: s <= a << 1; /* Shift Left by 1 */
		`ALU_FUNC_WIDTH'd17: s <= a >> 1; /* Shift Right by 1 */
		`ALU_FUNC_WIDTH'd18: s <= s + 1; /* Increment */
		`ALU_FUNC_WIDTH'd19: s <= s - 1; /* Decrement */
		`ALU_FUNC_WIDTH'd20: {co,s} <= 0; /* Zero */
		`ALU_FUNC_WIDTH'd21: s <= 1; /* One */
		`ALU_FUNC_WIDTH'd22: s <= ~0; /* Max */
		endcase
	end

endmodule
