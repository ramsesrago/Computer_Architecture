module MSP430x2xx(Clk, Rst, Flags, Res, Fsm, Instr, Instr_1,Instr_2,
						PC_data_in_out, A_data_out, B_data_out, Src_reg_out, Dst_reg_out,
						PC_inc_out, Wr_en_out, PC, PC_offset_out, 
						User_input, Seven_seg);

// Inputs
input 				Clk;
input					Rst;
input 	[ 3: 0]	User_input;
// Outputs
output   [ 3: 0] Flags;
output	[15: 0] Res;
output	[ 4: 0] Fsm;
output 	[15: 0] Instr;
output 	[15: 0] Instr_1;
output 	[15: 0] Instr_2;
output	[15: 0] PC_data_in_out;
output 	[15: 0] A_data_out;
output	[15: 0] B_data_out;
output	[ 3: 0] Src_reg_out;
output	[ 3: 0] Dst_reg_out;
output			  PC_inc_out;
output			  Wr_en_out;
output	[15: 0] PC;
output	[ 9: 0] PC_offset_out;
output	[27: 0] Seven_seg;
// Signals
// Registers
// Behavior

MSP430x2xx_block_diagram MSP430x2xx ( 
.Clk				(Clk),
.Rst				(Rst),
.Flags			(Flags),
.Res				(Res),
.Instr			(Instr),
.Instr_1			(Instr_1),
.Instr_2			(Instr_2),
.PC_data_in_out(PC_data_in_out),
.A_data_out		(A_data_out),
.B_data_out		(B_data_out),
.Fsm				(Fsm),
.Src_reg_out	(Src_reg_out),
.Dst_reg_out	(Dst_reg_out),
.PC_inc_out 	(PC_inc_out), 
.Wr_en_out		(Wr_en_out),
.PC				(PC),
.PC_offset_out	(PC_offset_out),
.User_input		(User_input),
.Seven_seg		(Seven_seg));

endmodule
