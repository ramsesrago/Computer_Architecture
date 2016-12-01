module control_unit (
				instruction, instruction_1, instruction_2,
				clk, rst, 
				en_pc_2, src_reg, wr_reg,
				dst_reg, wr_en, op_code, branch_en,
				pc_inc, fsm_state, pc_offset,wr_rom_en,
				addr_mode_sel
);

// Inputs 
input 	[15: 0] 	instruction;		//Instruction comming from PC
input 	[15: 0] 	instruction_1;		//Instruction comming from PC
input 	[15: 0] 	instruction_2;		//Instruction comming from PC
input 				clk;					//System clk
input					rst;					//Reset complete program

// Outputs
output				en_pc_2; 			//Goes to Mux to add 2 to PC 
output				wr_en;				//Tells Bank register when to write
output	[ 1: 0]	branch_en;			//Used for jump in Mux_2
output				pc_inc;				//Load new data on PC
output				wr_rom_en;			//Enabler to write specific address to memory
output	[ 3: 0]	wr_reg;				//Register to write information
output	[ 3: 0]	src_reg;				//Search reg in bank register
output	[ 3: 0]	dst_reg; 			//Search reg in bank register
output	[ 4: 0]	op_code;				//Alu selection Mux
output	[ 4: 0]  fsm_state;			//Sharing fsm current state
output	[ 9: 0] 	pc_offset;			//Offset to do the jump
output	[ 1: 0]  addr_mode_sel;		//Selection for addressing mode mux

//Registers
reg		[ 3: 0]	_wr_reg;				//Register to write information inner
reg		[ 3: 0]	_src_reg;			//Search reg in bank register inner
reg		[ 3: 0]	_dst_reg; 			//Search reg in bank register inner
reg		[ 4: 0]	_op_code;			//Alu selection Mux inner
reg		[ 1: 0]  _jp_code;			//Code to know what jump opperation has to be done
reg		[ 4: 0] 	_sg_code;			//Code to know what single opperation has to be done
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
reg		[ 1: 0]	branch_en;			//Used for jump in Mux_2
reg					pc_inc;				//Load new data on PC
reg					wr_rom_en;			//Enabler to write specific address to memory
reg		[ 1: 0]  addr_mode_sel;		//Selection for addressing mode mux

 

//Parameters
parameter f0 = 0;
parameter f1 = 1;
parameter f2 = 2;
parameter f3 = 3;
parameter f4 = 4;
/*
In type_operation, will change depending on op_code in instruction. 
type_operation = 0 << Single Operand operations 
type_operation = 1 << Jump operation
type_operation = 2 << Doble operand operations
type_operation = 3 << Needs to be added +4 to the PC << Indexed, addressing modes
*/
integer  type_operaton = 2;


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
	_fsm_state 	= f4;
	fsm_state 	= 5'b00000;
	en_pc_2		= 1'b0;
	wr_en 		= 1'b0;
	branch_en	= 2'b00;
	pc_inc		= 1'b0;
	op_code		= 5'd0;
	wr_reg		= 4'd0;
	src_reg 		= 4'd0;
	dst_reg 		= 4'd0;
	op_code		= 5'd0;
	pc_offset	= 10'd0;
end


//	STATE_MACHINE_BEHAVIOR
always @(_fsm_state)
	begin
		case (_fsm_state)
			f0:
				begin
					fsm_state 	= 5'b00000;
					en_pc_2		= 1'b0;
					wr_en 		= 1'b0;
					branch_en	= 2'b00;
					pc_inc		= 1'b0;
				end
			f1: 
				begin
					/*
						Use of information in instruction to bank_register.v
						PC will be added and written to the value regmem[pc];
					*/
					fsm_state = 5'b00001;
					_instruction_reg = instruction;
					en_pc_2		= 1'b1;							//Sum enabler for PC, always needed

					if (type_operaton == 1)						//Jump operations
						begin
							//pc_inc		= 1'b0;					//Multiplication on offset must be done first
							branch_en	= 2'b01;					//In MUX select the input on the PC
						end
					else if (type_operaton == 3)
						begin
							branch_en 	= 2'b10;
						end
					else												//Double operand operations					
						begin	
							//pc_inc		= 1'b1;					//Input in bank_register.v
							branch_en	= 2'b00;					//In MUX select the input on the PC
						end
				end
			f2: 
				begin
					/*
						Bank register clk operation
						Gather 16 bits of information in the register
						Operation in ALU is done
						wr_reg [3:0] will be set to write on it
					*/
					fsm_state 	= 5'b00010;
					en_pc_2		= 1'b0;					//This is always needed
					pc_inc		= 1'b1;
					if (type_operaton == 1)				//Jump operations
						begin
							//pc_inc		= 1'b1;					//Multiplication on offset must be done first
							branch_en	= 2'b01;					//In MUX select the input on the PC
						end
					else if (type_operaton == 3)
						begin
							branch_en 	= 2'b10;
						end
					else												//Double operand operations					
						begin	
							//pc_inc		= 1'b0;					//Input in bank_register.v
							branch_en	= 2'b00;					//In MUX select the input on the PC
						end					
				end
			f3: 
				begin
					fsm_state 	= 5'b00100;
					if ((type_operaton == 1)
					 || (type_operaton == 3)) wr_en = 1'b0;	//In order to save value into the register
					else wr_en = 1'b1;
					pc_inc		= 1'b0;
					/*if (type_operaton == 1)				//Jump operations

						begin
							pc_inc		= 1'b0;					//Multiplication on offset must be done first
						end*/
					
				end
			f4:
				begin
					fsm_state = 5'b1000;
					wr_en 		= 1'b0;
					
				end
			default:
				 fsm_state = 5'b0000;
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
				f4: _fsm_state = f0;
			endcase
	end
//	end of STATE_MACHINE_BEHAVIOR

// INSTRUCTION - OPCODE CODIFICATION
always @(_instruction_reg)
	begin
		_op_code = _instruction_reg[15:12];
		_jp_code = _instruction_reg[11:10];
		_sg_code = _instruction_reg[11: 6];
		case (_op_code)
			4'h1:				//	Special-Op
			begin
				op_code 			= 5'h1f;
				type_operaton	= 0;
				case (_sg_code)
					6'd0:		// RRC
						begin
							op_code 	= 5'b10000;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd1:		// RRC.B
						begin
							op_code 	= 5'b10001;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd2:		// SWPB
						begin
							op_code = 5'b10010;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd4:		//RRA
						begin	
							op_code = 5'b10011;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd5:		//RRA.B
						begin
							op_code = 5'b10100;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd6:		//SXT
						begin
							op_code = 5'b10101;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd8:		//PUSH
						begin
							op_code = 5'b10110;
							src_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd9:		//PUSH.B
						begin
							op_code = 5'b10111;
							src_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd10:	//CALL
						begin
							op_code = 5'b11000;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
						end
					6'd12:	//RETI
						begin
							op_code = 5'b11001;
							dst_reg	= _instruction_reg[ 3: 0];
							wr_reg	= _instruction_reg[ 3: 0];
							//Function not to be implemented
						end
					endcase
			end
			
			//Jump Operations
			4'h2:
			begin
				op_code			= 5'h1f;
				type_operaton 	= 1;
				case (_jp_code)
					2'b00:	// JNE/JNZ
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b01:	// JEQ/JZ
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b10:	// JNC
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b11:	// JGE
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
				endcase
			end
			4'h3:				//	Jump-Op
			begin
				op_code			= 5'h1f;
				type_operaton 	= 1;
				case (_jp_code)
					2'b00:	// JN
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b01:	// JGE
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b10:	// JL
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
					2'b11:	// JMP
						begin
							pc_offset = _instruction_reg[ 9: 0];
						end
				endcase
			end
			//	Double-Op
			4'h4: 
				begin
					type_operaton		= 3;
					op_code				= 5'b00000;							//MOV 
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
					if (_inst_doub_flags == 4'h9) 
						begin
							wr_rom_en = 1'b1;
							addr_mode_sel = 2'b00;
						end
					else if (_inst_doub_flags == 4'hE)
						begin
							wr_rom_en = 1'b1;
							addr_mode_sel = 2'b01;
						end
					else 
						begin
							wr_rom_en = 1'b0;
							addr_mode_sel = 2'b00;
						end
				end
			4'h5: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00001;						//ADD and ADDB
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'h6: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00010;		//ADDC
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'h7: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00011;		//SUB
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'h8: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00100;		//SUBC
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'h9: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00101;		//CMP
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hA: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00110;		//DADD
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hB: 
				begin
					type_operaton		= 2;
					op_code				= 5'b00111;		//BIT
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hC: 
				begin
					type_operaton		= 2;
					op_code				= 5'b01000;		//BIC
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hD: 
				begin
					type_operaton		= 2;
					op_code				= 5'b01001;		//BIS
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hE: 
				begin
					type_operaton		= 2;
					op_code				= 5'b01010;		//XOR
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
			4'hF: 
				begin
					type_operaton		= 2;
					op_code				= 5'b01011;		//AND
					_inst_doub_flags	= _instruction_reg[ 7: 4];
					wr_reg				= _instruction_reg[ 3: 0];
					src_reg				= _instruction_reg[11: 8];
					dst_reg				= _instruction_reg[ 3: 0];
				end
		endcase
	end


endmodule
