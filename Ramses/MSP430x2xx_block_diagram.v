// Copyright (C) 1991-2016 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, the Altera Quartus Prime License Agreement,
// the Altera MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Altera and sold by Altera or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.0.0 Build 211 04/27/2016 SJ Lite Edition"
// CREATED		"Wed Nov 30 19:35:49 2016"

module MSP430x2xx_block_diagram(
	Clk,
	Rst,
	Wr_en_out,
	PC_inc_out,
	A_data_out,
	B_data_out,
	Dst_reg_out,
	Flags,
	Fsm,
	Instr,
	Instr_1,
	Instr_2,
	PC,
	PC_after_x2_out,
	PC_data_in_out,
	PC_offset_out,
	Res,
	Src_reg_out
);


input wire	Clk;
input wire	Rst;
output wire	Wr_en_out;
output wire	PC_inc_out;
output wire	[15:0] A_data_out;
output wire	[15:0] B_data_out;
output wire	[3:0] Dst_reg_out;
output wire	[3:0] Flags;
output wire	[4:0] Fsm;
output wire	[15:0] Instr;
output wire	[15:0] Instr_1;
output wire	[15:0] Instr_2;
output wire	[15:0] PC;
output wire	[9:0] PC_after_x2_out;
output wire	[15:0] PC_data_in_out;
output wire	[9:0] PC_offset_out;
output wire	[15:0] Res;
output wire	[3:0] Src_reg_out;

wire	[15:0] SYNTHESIZED_WIRE_29;
wire	[15:0] SYNTHESIZED_WIRE_30;
wire	[4:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	[15:0] SYNTHESIZED_WIRE_31;
wire	[15:0] SYNTHESIZED_WIRE_5;
wire	[15:0] SYNTHESIZED_WIRE_6;
wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	[3:0] SYNTHESIZED_WIRE_9;
wire	[15:0] SYNTHESIZED_WIRE_10;
wire	[3:0] SYNTHESIZED_WIRE_11;
wire	[15:0] SYNTHESIZED_WIRE_12;
wire	[3:0] SYNTHESIZED_WIRE_13;
wire	[15:0] SYNTHESIZED_WIRE_14;
wire	[15:0] SYNTHESIZED_WIRE_32;
wire	[15:0] SYNTHESIZED_WIRE_33;
wire	[9:0] SYNTHESIZED_WIRE_17;
wire	SYNTHESIZED_WIRE_18;
wire	[15:0] SYNTHESIZED_WIRE_34;
wire	[9:0] SYNTHESIZED_WIRE_21;
wire	SYNTHESIZED_WIRE_24;
wire	[15:0] SYNTHESIZED_WIRE_26;

assign	Wr_en_out = SYNTHESIZED_WIRE_7;
assign	PC_inc_out = SYNTHESIZED_WIRE_8;
assign	A_data_out = SYNTHESIZED_WIRE_29;
assign	B_data_out = SYNTHESIZED_WIRE_30;
assign	Dst_reg_out = SYNTHESIZED_WIRE_9;
assign	Instr = SYNTHESIZED_WIRE_14;
assign	Instr_1 = SYNTHESIZED_WIRE_32;
assign	Instr_2 = SYNTHESIZED_WIRE_33;
assign	PC = SYNTHESIZED_WIRE_31;
assign	PC_after_x2_out = SYNTHESIZED_WIRE_21;
assign	PC_data_in_out = SYNTHESIZED_WIRE_10;
assign	PC_offset_out = SYNTHESIZED_WIRE_17;
assign	Res = SYNTHESIZED_WIRE_12;
assign	Src_reg_out = SYNTHESIZED_WIRE_11;




ALU16bit	b2v_inst(
	.A(SYNTHESIZED_WIRE_29),
	.B(SYNTHESIZED_WIRE_30),
	.sel(SYNTHESIZED_WIRE_2),
	.flags(Flags),
	.result(SYNTHESIZED_WIRE_12));


instruction_mem	b2v_inst1(
	.clk(Clk),
	.addr_wr_en(SYNTHESIZED_WIRE_3),
	.addr(SYNTHESIZED_WIRE_31),
	.addr_wr_dest(SYNTHESIZED_WIRE_5),
	.addr_wr_src(SYNTHESIZED_WIRE_6),
	.inst(SYNTHESIZED_WIRE_14),
	.inst_1(SYNTHESIZED_WIRE_32),
	.inst_2(SYNTHESIZED_WIRE_33));


bank_register	b2v_inst2(
	.clk(Clk),
	.wr_en(SYNTHESIZED_WIRE_7),
	.pc_inc(SYNTHESIZED_WIRE_8),
	.rst(Rst),
	.dst_reg(SYNTHESIZED_WIRE_9),
	.pc_data_in(SYNTHESIZED_WIRE_10),
	.src_reg(SYNTHESIZED_WIRE_11),
	.wr_data(SYNTHESIZED_WIRE_12),
	.wr_reg(SYNTHESIZED_WIRE_13),
	.a(SYNTHESIZED_WIRE_29),
	.b(SYNTHESIZED_WIRE_30),
	.pc_data_out(SYNTHESIZED_WIRE_31));
	defparam	b2v_inst2.cg2 = 3;
	defparam	b2v_inst2.pc = 0;
	defparam	b2v_inst2.r10 = 10;
	defparam	b2v_inst2.r11 = 11;
	defparam	b2v_inst2.r12 = 12;
	defparam	b2v_inst2.r13 = 13;
	defparam	b2v_inst2.r14 = 14;
	defparam	b2v_inst2.r15 = 15;
	defparam	b2v_inst2.r4 = 4;
	defparam	b2v_inst2.r5 = 5;
	defparam	b2v_inst2.r6 = 6;
	defparam	b2v_inst2.r7 = 7;
	defparam	b2v_inst2.r8 = 8;
	defparam	b2v_inst2.r9 = 9;
	defparam	b2v_inst2.sp = 1;
	defparam	b2v_inst2.sr = 2;


control_unit	b2v_inst3(
	.clk(Clk),
	.rst(Rst),
	.instruction(SYNTHESIZED_WIRE_14),
	.instruction_1(SYNTHESIZED_WIRE_32),
	.instruction_2(SYNTHESIZED_WIRE_33),
	.en_pc_2(SYNTHESIZED_WIRE_18),
	.wr_en(SYNTHESIZED_WIRE_7),
	.branch_en(SYNTHESIZED_WIRE_24),
	.pc_inc(SYNTHESIZED_WIRE_8),
	.wr_rom_en(SYNTHESIZED_WIRE_3),
	.dst_reg(SYNTHESIZED_WIRE_9),
	.fsm_state(Fsm),
	.op_code(SYNTHESIZED_WIRE_2),
	.pc_offset(SYNTHESIZED_WIRE_17),
	.src_reg(SYNTHESIZED_WIRE_11),
	.wr_reg(SYNTHESIZED_WIRE_13));
	defparam	b2v_inst3.f0 = 0;
	defparam	b2v_inst3.f1 = 1;
	defparam	b2v_inst3.f2 = 2;
	defparam	b2v_inst3.f3 = 3;
	defparam	b2v_inst3.f4 = 4;


mult_by_2	b2v_inst4(
	.clk(Clk),
	.in(SYNTHESIZED_WIRE_17),
	.out(SYNTHESIZED_WIRE_21));


adderpc	b2v_inst5(
	.en(SYNTHESIZED_WIRE_18),
	.a(SYNTHESIZED_WIRE_31),
	.res(SYNTHESIZED_WIRE_34));


adder16bits	b2v_inst6(
	.a(SYNTHESIZED_WIRE_34),
	.b(SYNTHESIZED_WIRE_21),
	.res(SYNTHESIZED_WIRE_26));


adder16bits_full	b2v_inst7(
	.a(SYNTHESIZED_WIRE_32),
	.b(SYNTHESIZED_WIRE_29),
	.res(SYNTHESIZED_WIRE_6));


mux_16_bits	b2v_inst8(
	.sel(SYNTHESIZED_WIRE_24),
	.data0x(SYNTHESIZED_WIRE_34),
	.data1x(SYNTHESIZED_WIRE_26),
	.result(SYNTHESIZED_WIRE_10));


adder16bits_full	b2v_inst9(
	.a(SYNTHESIZED_WIRE_33),
	.b(SYNTHESIZED_WIRE_30),
	.res(SYNTHESIZED_WIRE_5));


endmodule
