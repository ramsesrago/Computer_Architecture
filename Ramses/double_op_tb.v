`timescale 1 ns/1 ns

module double_op_tb();

// Wires and variables to connect to DUT
// Inputs
reg		rst_tb;
reg		clk_tb;

//	Outputs
wire	[15: 0]	res_tb;
wire	[ 4: 0]	fsm_tb;
wire	[ 3: 0]  flags_tb;

always
begin
	#5 clk_tb = !clk_tb;
end

endmodule
