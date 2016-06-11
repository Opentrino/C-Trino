module dff(d,clk,reset,q,qbar);
	input wire d, reset, clk;
	output reg q, qbar;
		
	always@(posedge clk) begin
		q <= d;
		qbar <= !d;
	end
	
	always@(posedge reset) begin
		q <= 0;
		qbar <= 1;	
	end
endmodule

module dff_t;
	reg d,clk,reset;
	wire q, qbar;
	dff dflipflop(d,clk,reset, q,qbar);
	
	task set; 
		input new_d; 
	begin
		d = new_d;
		clk = 0;
		#1;
		clk = 1;
		#1;
		clk = 0;
	end
	endtask 

	task init;
	begin
		clk = 0;
		reset = 1;
		#1;
		reset = 0;
	end endtask
	initial begin
		$monitor("d: %d clk: %d q: %d ~q: %d", d,clk,q,qbar);
		$dumpfile("core_main.vcd");
		$dumpvars(d,reset,clk,q,qbar);
		init();
		set(1);
		set(1);
	end
endmodule