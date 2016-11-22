`timescale 1 ns/1 ns

module instruction_mem_tb();

// Wires and variables to connect to DUT
// Inputs 
reg 				clk_tb;
reg 	[15: 0]	addr_tb;

// Outputs
wire 	[15: 0]	inst_tb;

// Instantiate unit under test (instruction_mem)
instruction_mem instruction_mem_tb (.clk(clk_tb), .addr(addr_tb), .inst(inst_tb));

initial
begin
	clk_tb = 1'b0;
	addr_tb = 15'd0;
end

always
begin
	#5 clk_tb 	= !clk_tb;
end

always@(negedge clk_tb)
begin
	addr_tb		= addr_tb + 1;
end

endmodule
