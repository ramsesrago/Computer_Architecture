module MSP430x2xx(Load_en, Clk, Rst, Flags, Res, Fsm, Instr,
						PC_data_in_out, A_data_out, B_data_out, Src_reg_out, Dst_reg_out,
						PC_inc_out, Wr_en_out, PC);

// Inputs
input		Load_en;
input 	Clk;
input		Rst;
// Outputs
output   [ 3: 0] Flags;
output	[15: 0] Res;
output	[ 4: 0] Fsm;
output 	[15: 0] Instr;
output	[15: 0] PC_data_in_out;
output 	[15: 0] A_data_out;
output	[15: 0] B_data_out;
output	[ 3: 0] Src_reg_out;
output	[ 3: 0] Dst_reg_out;
output			  PC_inc_out;
output			  Wr_en_out;
output	[15: 0] PC;
// Signals
// Registers
// Behavior

MSP430x2xx_block_diagram MSP430x2xx ( 
.Load_en	(Load_en), 
.Clk			(Clk),
.Rst			(Rst),
.Flags		(Flags),
.Res			(Res),
.Instr		(Instr),
.PC_data_in_out(PC_data_in_out),
.A_data_out	(A_data_out),
.B_data_out	(B_data_out),
.Fsm			(Fsm),
.Src_reg_out(Src_reg_out),
.Dst_reg_out(Dst_reg_out),
.PC_inc_out (PC_inc_out), 
.Wr_en_out	(Wr_en_out),
.PC			(PC));

endmodule
