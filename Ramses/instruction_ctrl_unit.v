module instruction_ctrl_unit (instr_load, instr_or_reg, 
										mem_send, mem_read,
										A_src, B_des, Opcode);

// Inputs 
input [15:0] 	instr_or_reg;		//Instruction or register of 16 bits
input 			instr_load;			//Load register for retrieving instruction from memory
input 			mem_read;			//Used for memory advice to read the Register from memory

// Outputs
output [15: 0]	A_src;				//16 bit output where is linked to ALU16bit A value
output [15: 0] B_des;				//16 bit output where is linked to ALU16bit B value
output 			mem_send;			//Used for send signal to memory to read and send value expected

// Signals
// Registers
reg [15: 0] Dst_reg;				//Destination register
reg [15: 0] Src_reg;				//Source register
reg [15: 0] Res_reg;				//Result register
reg [ 2: 0] OpAddr_mode_reg;	//Source/Destination Operand Addressing Modes
//Double-Operand (Format I) instructions
reg [ 3: 0] Opcode_reg;			//Operation code register
reg [ 3: 0] Opcode_doubop_reg;//Operation code register for double-operand instructions
reg [ 4: 0] Opcode_singop_reg;//Operation code register for single-operand instructions
reg [ 1: 0] Opcode_jumpop_reg;//Operation code register for jump-operand instructions
reg 			BW_reg;				//BW reg used in instruction format
reg [ 1: 0] As_reg;				//As reg used in instruction format 
reg			Ad_reg;				//Ad reg used in instruction format

//Behavior
//Operand Addressing Modes
always @(posedge instr_load)
begin

	/*TODO: Add logic to assign part of instructions set to As_reg and Ad_reg*/
	
	if			(Ad_reg == 2'b00 && As_reg == 1'b0) OpAddr_mode_reg = 3'b000;	//Register Mode
	else if	(Ad_reg == 2'b01 && As_reg == 1'b1) OpAddr_mode_reg = 3'b100;	//Indexed, Symbolic, Absolute
	else if	(Ad_reg == 2'b10 && As_reg == 1'bX) OpAddr_mode_reg = 3'b010;	//Indirect Mode
	else if	(Ad_reg == 2'b11 && As_reg == 1'bX) OpAddr_mode_reg = 3'b011;	//Inmediate Mode
end

/*
	TODO: Add the final state maching where for every type of operand 
			Different actions will be implemented. 
*/
always @(Opcode_reg)
begin
	case (Opcode_reg)
	//Single operand (Format II) instructions
	4'b0001:
		begin
			case(Opcode_singop_reg)
			5'b00000:	
				begin
					if (BW_reg == 1'b0)
						Res_reg = Dst;	//RRC
					else	//RRC.B
						Res_reg = Dst;
				end
			5'b00001:	//SWPB
				Res_reg = Dst;
			5'b00010:	//RRA
				begin	
					if (BW_reg == 1'b0)
						Res_reg = Dst;	//RRA
					else	//RRA.B
						Res_reg = Dst;
				end	
			5'b00011:	//SXT
				Res_reg = Dst;
			5'b00100:	
				begin	
					if (BW_reg == 1'b0)
						Res_reg = Dst;	//PUSH
					else	//PUSH.B
						Res_reg = Dst;
				end
			5'b00101:	//CALL
				Res_reg = Dst;
			5'b00110:	//RETI
				Res_reg = Dst;
			default: 
				Res_reg = Dst;
			endcase
		end
	//Jumps instructions
	4'b0010:
		begin
			case(Opcode_jumpop_reg)
				2'b00:		//JNE/JNZ
					Res_reg = Dst;
				2'b01:		//JEQ/JZ
					Res_reg = Dst;
				2'b10:		//JNC
					Res_reg = Dst;
				2'b11:		//JC
					Res_reg = Dst;
			endcase
		end
	//Jumps instructions
	4'b0011:
		begin
			case(Opcode_jumpop_reg)
				2'b00:		//JN
					Res_reg = Dst;
				2'b01:		//JGE
					Res_reg = Dst;
				2'b10:		//JL
					Res_reg = Dst;
				2'b11:		//JMP
					Res_reg = Dst;
			endcase
		end
	/*
	Double-Operand (Format I) Instructions includes:
	-MOV	-ADD	-ADC	-SUB	
	-SUBC	-CMP	-DADD	-BIT
	-BIC	-BIS	-XOR	-AND
	
	From instruction [16 bits]
	instr_or_reg[15:12]	->	Opcode_doubop_reg
	instr_or_reg[11: 8]	-> Src_reg
	instr_or_reg[    7]	-> Ad_reg
	instr_or_reg[    6]	-> BW_reg
	instr_or_reg[ 5: 4]	-> As_reg
	instr_or_reg[ 3: 0]	-> Dst_reg
	
	As all double operations are done 
	in ALU 16 bits, here we will need the 
	logic to gather the information from the 
	Registers, using the Memory Address BUS
	and the Memory Data BUS. 
	*/
	4'b0100:				//MOV
	4'b0101:				//ADD
	4'b0110:				//ADDC
	4'b0111:				//SUBC
	4'b1000:				//SUB
	4'b1001:				//CMP
	4'b1010:				//DADD
	4'b1011:				//BIT
	4'b1100:				//BIC
	4'b1101:				//BIS
	4'b1110:				//XOR
	4'b1111:				//AND
		begin
			assign	Opcode_doubop_reg = instr_or_reg[15:12];
			assign	Src_reg				= instr_or_reg[11: 8];
			assign	Ad_reg  				= instr_or_reg[    7];
			assign	BW_reg  				= instr_or_reg[    6];
			assign	As_reg  				= instr_or_reg[ 5: 4];
			assign	Dst_reg 				= instr_or_reg[ 3: 0];
		end
	/*
	End of Double-Operand (Format I) Instructions
	*/
	endcase
		
end  
endmodule
