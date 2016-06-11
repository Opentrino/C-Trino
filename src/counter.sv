`define WIDTH 64
`timescale 1ns/1ps 

module ctr(clk, reset, en, q, upcount);
	input wire clk, reset, en, upcount;
	output reg [`WIDTH-1:0]q;
	always@(posedge clk or reset)
		if(reset) q = 0;
		else if(en) begin 
			if(upcount) q = q + 1;
			else q = q - 1;
		end
endmodule

module counter_tb;
	reg clk, reset, en, upcount;
	wire [`WIDTH-1:0] q;
	ctr _ctr(clk,reset,en,q, upcount);
	
	initial begin
		$dumpfile("counter.vcd");
		$dumpvars(0, counter_tb);
		clk = 0;
		upcount = 1;
		en = 0;
		reset = 1;
		#1 reset = 0;
		#5;
		en = 1;
		#10;
		upcount = 0;
		#10;
		$finish;
	end
	
	always begin #1; clk = ~clk; end
	
endmodule