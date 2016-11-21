module control_unit (
				instruction, inst_load, clk, rst,
				en_pc_2, src_reg, wr_reg,
				dst_reg, wr_en, op_code, branch_en,
				pc_inc, fsm_state, pc_offset
);

// Inputs 
input 	[15: 0] 	instruction;		//Instruction comming from PC
input 				inst_load; 			//Used for testing purposes
input 				clk;					//System clk
input					rst;					//Reset complete program

// Outputs
output				en_pc_2; 			//Goes to Mux to add 2 to PC 
output				wr_en;				//Tells Bank register when to write
output				branch_en;			//Used for jump in Mux_2
output				pc_inc;				//Load new data on PC
output	[ 3: 0]	wr_reg;				//Register to write information
output	[ 3: 0]	src_reg;				//Search reg in bank register
output	[ 3: 0]	dst_reg; 			//Search reg in bank register
output	[ 4: 0]	op_code;				//Alu selection Mux
output	[ 4: 0]  fsm_state;			//Sharing fsm current state
output	[ 9: 0] 	pc_offset;			//Offset to do the jump

//Registers
reg		[ 3: 0]	_wr_reg;				//Register to write information inner
reg		[ 3: 0]	_src_reg;			//Search reg in bank register inner
reg		[ 3: 0]	_dst_reg; 			//Search reg in bank register inner
reg		[ 4: 0]	_op_code;			//Alu selection Mux inner
reg		[ 2: 0]  _fsm_state;			//Sharing fsm current state
reg		[ 9: 0]	pc_offset;
reg		[ 4: 0]  fsm_state;			//Sharing fsm current state
 

//Parameters
parameter f0 = 0;
parameter f1 = 1;
parameter f2 = 2;
parameter f3 = 3;
parameter f4 = 4;
parameter f5 = 5;

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
	Retrieve information on Src_reg, and Des_reg 

State 4
	Perform action
	
State 5
	Save data start again
	
**Jumps done in fetch
*/


//	STATE_MACHINE_BEHAVIOR
always @(_fsm_state)
	begin
		case (_fsm_state)
			f0: fsm_state = 4'b0000;
			f0: fsm_state = 4'b0001;
			f0: fsm_state = 4'b0010;
			f0: fsm_state = 4'b0100;
			f0: fsm_state = 4'b1000;
			default:
				 fsm_state = 4'b0000;
		endcase
	end

always @(posedge clk or posedge rst)
	begin
		if (rst)
			_fsm_state = f0;
		else
			case (_fsm_state)
			/*
			TODO: Add correct logic
			*/
				f0: _fsm_state = f1;
				f1: _fsm_state = f2;
				f2: _fsm_state = f3;
				f3: _fsm_state = f4;
				f5: _fsm_state = f0;
			endcase
	end
//	end of STATE_MACHINE_BEHAVIOR


endmodule
