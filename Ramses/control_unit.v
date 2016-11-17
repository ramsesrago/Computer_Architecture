module control_unit (
				instruction, inst_load, clk, rst
				en_pc_2, src_reg, wr_reg,
				dst_reg, wr_en, op_code, branch_en,
				pc_inc
);

// Inputs 
input 	[15: 0] 	instruction;		//Instruction comming from PC
input 				inst_load; 			//Used for testing purposes
input 				clk;					//System clk
input					rst;					//Reset complete program

// Outputs
output				pc_2_en; 			//Goes to Mux to add 2 to PC 
output				wr_en;				//Tells Bank register when to write
output				branch_en;			//Used for jump in Mux_2
output				pc_inc;				//Load new data on PC
output	[ 3: 0]	wr_reg;				//Register to write information
output	[ 3: 0]	src_reg;				//Search reg in bank register
output	[ 3: 0]	dst_reg; 			//Search reg in bank register
output	[ 4: 0]	op_code;				//Alu selection Mux

/*
State Machine logic planning

State 0
	Read PC address, PC register (bank_register.v) 
	MAR <- (PC), READ 
	The address of the instruction to be fetched is stored 
	in the program counter. Since [15..0] instruction receive 
	values from the address register, the first step is accomplished 
	by copying the contents of PC to AR. 

State 1
	Increment PC
	Read instruction and add it to MBR 

State 2 
	Divide Instruction register from MBR, and process information
	(Start decoding)

State 3 
	For single Operand Operations 

State 6 
	For double operand operations
	
**Jumps done in fetch

*/
end module
