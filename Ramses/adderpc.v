module adderpc (a, en, res);

// Inputs
input 	[15: 0]	a;
input					en;

// Outputs
output 	[15: 0]	res;

// Registers
reg		[15: 0]	res;
reg		[15: 0]	b;

// Parameters
always@(*)
begin
	b = 16'b0000000000000010;
	res = a+b;
end

endmodule
