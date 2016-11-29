`timescale 1 ns/1 ns

module double_op_tb();

// Wires and variables to connect to DUT

// Inputs
reg		Load_en_tb;
reg 		Clk_tb;
reg		Rst_tb;

// Outputs
wire  [ 3: 0] Flags_tb;
wire	[15: 0] Res_tb;
wire	[ 4: 0] Fsm_tb;
wire 	[15: 0] Instr_tb;
wire	[15: 0] PC_data_in_out_tb;
wire 	[15: 0] A_data_out_tb;
wire	[15: 0] B_data_out_tb;
wire	[ 3: 0] Src_reg_out_tb;
wire	[ 3: 0] Dst_reg_out_tb;
wire			  PC_inc_out_tb;
wire			  Wr_en_out_tb;
wire	[15: 0] PC_tb;
wire	[ 9: 0] PC_offset_out_tb;
wire	[ 9: 0] PC_after_x2_out_tb;

// Instantiate unit under test (adder)
	MSP430x2xx MSP430x2xx_tb  (.Load_en(Load_en_tb), .Clk(Clk_tb), .Rst(Rst_tb),
										.Flags(Flags_tb), .Res(Res_tb), .Fsm(Fsm_tb), 
										.Instr(Instr_tb), .PC_data_in_out(PC_data_in_out_tb),
										.A_data_out(A_data_out_tb), .B_data_out(B_data_out_tb),
										.Src_reg_out(Src_reg_out_tb), .Dst_reg_out(Dst_reg_out_tb),
										.Wr_en_out(Wr_en_out_tb), .PC_inc_out(PC_inc_out_tb),
										.PC(PC_tb), .PC_offset_out(PC_offset_out_tb), 
										.PC_after_x2_out(PC_after_x2_out_tb));

initial
begin
	Clk_tb = 1'b0;
	Rst_tb = 1'b1;
	#10 Rst_tb = 1'b0;
end
always
begin
	#5 Clk_tb = !Clk_tb;
end

endmodule
