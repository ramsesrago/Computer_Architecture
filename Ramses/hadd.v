module hadd (a, b, cout, s);

// Inputs
input		a;
input 	b;
// Outputs
output   cout;
output   s;
// Signals
// Registers

//Behavior
assign {cout,s} = a + b;

endmodule
