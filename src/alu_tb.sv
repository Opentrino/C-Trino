`include "alu.sv"

module alu_tb;
	reg [`ALU_WIDTH - 1:0] a = 0,b = 0;
	reg ci = 0;
	reg [`ALU_FUNC_WIDTH - 1:0] f = 0;
	wire [`ALU_WIDTH - 1:0] s;
	wire co;
	
	alu _alu(a,b,ci,f,s,co);
	
	task alu_calc;
		input reg [`ALU_WIDTH - 1:0] _a, _b;
		input reg _ci;
		input reg [`ALU_FUNC_WIDTH - 1:0] _f;
	begin
		#1;
		a = _a;
		b = _b;
		ci = _ci;
		f = _f;
	end
	endtask

	task alu_init; begin
		f = `ALU_FUNC_WIDTH'd20;
	end endtask	
	
	initial begin
		$monitor("a: %h b: %h cin: %b (f: %h) s = %h , cout: %b", a,b,ci,f,s,co);
		$dumpfile("alu_tb.vcd");
		$dumpvars(0, alu_tb);
		alu_init();
		
		alu_calc(1,2,0,_ALU_ADD);
		alu_calc(2,2,0,_ALU_MAX);
		alu_calc(1.7,0,0,_ALU_ONE);
		
		$finish;
	end

endmodule
