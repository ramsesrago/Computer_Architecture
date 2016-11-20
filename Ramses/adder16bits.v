module adder16bits (a, b, en, res);

// Inputs
input 	[15: 0]	a;
input 	[15: 0]	b;
input					en;

// Outputs
output 	[15: 0]	res;

// Registers
reg		[15: 0]	res;

// Parameters
always@(posedge en)
begin
	res = a+b;
end

endmodule
