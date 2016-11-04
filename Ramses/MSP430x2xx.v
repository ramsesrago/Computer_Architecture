module MSP430x2xx(a,b,cout,s);

// Inputs
input		a;
input 	b;
// Outputs
output   cout;
output   s;

// Signals
// Registers

//Behavior
hadd halfadder (
a, 
b, 
cout, 
s
);


endmodule
