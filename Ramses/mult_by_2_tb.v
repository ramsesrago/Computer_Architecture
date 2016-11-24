`timescale 1 ns/1 ns

module mult_by_2_tb ();

// Wires and variables to connect to DUT
// Inputs
reg	[ 9: 0]	in_tb;
reg				clk_tb;

//	Outputs
wire	[ 9: 0]	out_tb;

// Instantiate unit under test (adder)
	mult_by_2 mult_by_2_tb (.in(in_tb), .clk(clk_tb), .out(out_tb));

initial
begin
	clk_tb		= 1'b1;
	in_tb			= 10'd1;
	#10 in_tb	= 10'd10;
	#10 in_tb	= 10'd21;
	#10 in_tb	= 10'd42;
	#10 in_tb	= 10'd400;
	#10 in_tb	= 10'd987;
end
	
always 
begin
	#5 clk_tb = !clk_tb;
end

endmodule
