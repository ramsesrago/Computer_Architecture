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
reg		[15: 0]	_instruction_reg;	//Instruction comming from PC
reg		[ 3: 0]	_inst_doub_flags;	//Flags indicating addressing mode
reg		[ 9: 0]	pc_offset;
reg		[ 4: 0]  fsm_state;			//Sharing fsm current state
reg		[ 4: 0]	op_code;				//Alu selection Mux
reg		[ 3: 0]	src_reg;				//Search reg in bank register
reg		[ 3: 0]	dst_reg; 			//Search reg in bank register
reg		[ 3: 0]	wr_reg;				//Register to write information
reg					en_pc_2; 			//Goes to Mux to add 2 to PC 
reg					wr_en;				//Tells Bank register when to write
reg					branch_en;			//Used for jump in Mux_2
reg					pc_inc;				//Load new data on PC
 

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

initial
begin
	_fsm_state = f0;
end


//	STATE_MACHINE_BEHAVIOR
always @(_fsm_state)
	begin
		case (_fsm_state)
			f0:
				begin
					fsm_state 	= 4'b0000;
					en_pc_2		= 1'b0;
					wr_en 		= 1'b0;
					branch_en	= 1'b0;
					pc_inc		= 1'b0;
					wr_reg		= 4'd0;
					src_reg		= 4'd0;
					dst_reg		= 4'd0;
					op_code		= 5'd0;
					pc_offset	= 10'd0;
				end
			f1: 
				begin
					fsm_state = 4'b0001;
					_instruction_reg = instruction;
				end
			f2: 
				begin
					fsm_state = 4'b0010;
					_instruction_reg = instruction;
				end
			f3: 
				begin
					fsm_state = 4'b0100;
					_instruction_reg = instruction;
				end
			f4:
				begin
					fsm_state = 4'b1000;
					_instruction_reg = instruction;
				end
			f5: fsm_state = 4'b1001;
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
				f4: _fsm_state = f5;
				f5: _fsm_state = f0;
			endcase
	end
//	end of STATE_MACHINE_BEHAVIOR

// INSTRUCTION - OPCODE CODIFICATION
always @(_instruction_reg)
	begin
		_op_code = _instruction_reg[15:12];
		case (_op_code)
			4'h1:				//	Special-Op
				op_code 		= 5'hx;
			4'h2,
			4'h3:				//	Jump-Op
				op_code		= 5'hx;
			//	Double-Op
			4'h4: 
				begin
					op_code				= 5'b00000;							//MOV 
					_inst_doub_flags	= _instruction_reg[ 7: 4];
				end
			4'h5: 
				begin
					op_code				= 5'b00001;						//ADD and ADDB
					_inst_doub_flags	= _instruction_reg[ 7: 4];
				end
			4'h6: op_code		= 5'b00010;		//ADDC
			4'h7: op_code		= 5'b00011;		//SUB
			4'h8: op_code		= 5'b00100;		//SUBC
			4'h9: op_code		= 5'b00101;		//CMP
			4'hA: op_code		= 5'b00110;		//DADD
			4'hB: op_code		= 5'b00111;		//BIT
			4'hC: op_code		= 5'b01000;		//BIC
			4'hD: op_code		= 5'b01001;		//BIS
			4'hE: op_code		= 5'b01010;		//XOR
			4'hF: op_code		= 5'b01011;		//AND
		endcase
		
		case (_inst_doub_flags)
			4'b0100,					//Register addressing mode
			4'b0000:
				begin
					src_reg	= _instruction_reg[11: 8];
					dst_reg	= _instruction_reg[ 3: 0];
				end
			4'b1001,					//Symbolic and Absolute addessing mode
			4'b1101:
				begin 
					src_reg	= _instruction_reg[11: 8];
					dst_reg	= _instruction_reg[ 3: 0];
				end
			4'bxx10:					//Indirect addressing mode
				begin
					src_reg	= _instruction_reg[11: 8];
					dst_reg	= _instruction_reg[ 3: 0];
				end
			4'bxx11:					//Indirect auto increase, Inmediate mode
				begin
					src_reg	= _instruction_reg[11: 8];
					dst_reg	= _instruction_reg[ 3: 0];
				end
			default:
				begin
					src_reg	= 4'h0;
					dst_reg	= 4'b0;
				end
		endcase
	end

endmodule
