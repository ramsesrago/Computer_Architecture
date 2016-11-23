`timescale 1 ns/1 ns

module control_unit_tb();

// Wires and variables to connect to DUT

// Inputs 
reg 	[15: 0] 	instruction_tb;		//Instruction comming from PC
reg 				inst_load_tb; 			//Used for testing purposes
reg 				clk_tb;					//System clk
reg				rst_tb;					//Reset complete program

// Outputs
wire				en_pc_2_tb; 			//Goes to Mux to add 2 to PC 
wire				wr_en_tb;				//Tells Bank register when to write
wire				branch_en_tb;			//Used for jump in Mux_2
wire				pc_inc_tb;				//Load new data on PC
wire	[ 3: 0]	wr_reg_tb;				//Register to write information
wire	[ 3: 0]	src_reg_tb;				//Search reg in bank register
wire	[ 3: 0]	dst_reg_tb; 			//Search reg in bank register
wire	[ 4: 0]	op_code_tb;				//Alu selection Mux
wire	[ 4: 0]  fsm_state_tb;			//Sharing fsm current state
wire	[ 9: 0] 	pc_offset_tb;			//Offset to do the jump

// Instantiate unit under test (adder)
	control_unit control_unit_tb (.instruction(instruction_tb), .inst_load(inst_load_tb), 
											.clk(clk_tb), .rst(rst_tb), .en_pc_2(en_pc_2_tb),
											.branch_en(branch_en_tb), .pc_inc(pc_inc_tb), .wr_reg(wr_reg_tb),
											.src_reg(src_reg_tb), .dst_reg(dst_reg_tb), .op_code(op_code_tb),
											.fsm_state(fsm_state_tb), .pc_offset(pc_offset_tb), .wr_en(wr_en_tb));
	
initial
begin
	instruction_tb	= 16'b0100_1100_0100_1101;
	rst_tb 			=  1'b0;
	inst_load_tb	= 	1'b0;
	clk_tb			=  1'b1;
	#60 instruction_tb = 16'b0101_1010_0100_1000;
	#60 instruction_tb = 16'b0110_1101_0100_1010;
	#60 instruction_tb = 16'b0111_1111_0100_1101;
	#60 instruction_tb = 16'b1000_1001_0100_1010;
	#60 instruction_tb = 16'b1001_1001_0100_1101;
	#60 instruction_tb = 16'b1010_1100_0100_1100;
	#60 instruction_tb = 16'b1011_1110_0100_1001;
	#60 instruction_tb = 16'b1100_1111_0100_1101;
	#60 instruction_tb = 16'b1101_1001_0100_1100;
	#60 instruction_tb = 16'b1110_1110_0100_1111;
	#60 instruction_tb = 16'b1111_1000_0100_1001;

	
end

always 
begin
	#5 clk_tb = !clk_tb;
end

endmodule
