module MSP430x2xx_top(Clk, Rst, 
						User_input, Seven_seg);

// Inputs
input 				Clk;
input					Rst;
input 	[ 3: 0]	User_input;

output	[41: 0] Seven_seg;
// Signals
// Registers
// Behavior

MSP430x2xx_block_diagram MSP430x2xx ( 
.Clk				(Clk),
.Rst				(Rst),
.User_input		(User_input),
.Seven_seg		(Seven_seg));

endmodule
