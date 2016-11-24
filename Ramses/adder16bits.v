module adder16bits (a, b, res);

// Inputs
input 	[15: 0]	a;
input 	[ 9: 0]	b;

// Outputs
output 	[15: 0]	res;

// Registers
reg		[15: 0]	res;

// Parameters
always@(*)
begin
	res = a+b;
end

endmodule
