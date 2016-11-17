module control_unit (
				instruction, inst_load, clk, rst
				en_pc_2, read_reg, src_reg, 
				dst_reg, wr_en, op_code, branch_en
);

// Inputs 
input 	[15: 0] 	instruction;		//Instruction comming from PC
input 				inst_load; 			//Used for testing purposes
input 				clk;					//System clk
input					rst;					//Reset complete program

// Outputs
output				pc_2_en; 			//Goes to Mux to add 2 to PC 
output				wr_en;				//Tells Bank register when to write
output				read_reg; 			//Signal to search for registers 
output				branch_en;			//Used for jump in Mux_2
output	[ 3: 0]	src_reg;				//Search reg in bank register
output	[ 3: 0]	dst_reg; 			//Search reg in bank register
output	[ 4: 0]	op_code;				//Alu selection Mux

end module
