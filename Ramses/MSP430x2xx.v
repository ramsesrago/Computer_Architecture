module MSP430x2xx(Load_en, Clk, Rst, Flags, Res, Fsm, Instr);

// Inputs
input		Load_en;
input 	Clk;
input		Rst;
// Outputs
output   [ 3: 0] Flags;
output	[15: 0] Res;
output	[ 4: 0] Fsm;
output 	[15: 0] Instr;

// Signals
// Registers
// Behavior

MSP430x2xx_block_diagram MSP430x2xx ( 
.Load_en	(Load_en), 
.Clk		(Clk),
.Rst		(Rst),
.Flags	(Flags),
.Res		(Res),
.Instr		(Instr));

endmodule
