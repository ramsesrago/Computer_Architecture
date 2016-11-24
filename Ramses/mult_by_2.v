module mult_by_2 (in, out, clk);
// Inputs
input		[ 9: 0]	in;
input					clk;

//	Outputs
output	[ 9: 0]	out;

// Registers
reg		[ 9: 0]	out;

initial
out = 10'd0;

always@(posedge clk)
begin
	out = in << 1;
end
endmodule
