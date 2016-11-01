module alu_16_bits (Z, C, V, N, PC_en, opcode, dst, src, MCLK, res);

// Inputs 
input 			Z; 		//Zero
input 			C;			//Carry
input 			V;			//Overflow
input 			N; 		//Negative
input 			PC_en;	//Program Counter enable
input [15: 0]	Dst;		//A, Dest
input [15: 0]  Src;		//B, Src
input 		   MCLK; 	//Clock
input [ 3: 0]	Opcode;	//Operation code on ALU

// Outputs
output [15: 0]	res;

// Signals
// Registers
reg [15: 0] Dst_reg;				//Destination register
reg [15: 0] Src_reg;				//Source register
reg [15: 0] Res_reg;				//Result register
reg [ 2: 0] OpAddr_mode_reg;	//Source/Destination Operand Addressing Modes
//Double-Operand (Format I) instructions
reg [ 3: 0] Opcode_reg;			//Operation code register
reg [ 4: 0] Opcode_singop_reg;//Operation code register for single-operand instructions
reg [ 1: 0] Opcode_jumpop_reg;//Operation code register for jump-operand instructions
reg 			BW_reg;				//BW reg used in instruction format
reg [ 1: 0] As_reg;				//As reg used in instruction format 
reg			Ad_reg;				//Ad reg used in instruction format

//Behavior
//Operand Addressing Modes
always @(posedge PC_en)
begin
	/*TODO: Add logic to assign part of instructions set to As_reg and Ad_reg*/
	
	if			(Ad_reg == 2'b00 && As_reg == 1'b0) OpAddr_mode_reg = 3'b000;	//Register Mode
	else if	(Ad_reg == 2'b01 && As_reg == 1'b1) OpAddr_mode_reg = 3'b100;	//Indexed, Symbolic, Absolute
	else if	(Ad_reg == 2'b10 && As_reg == 1'bX) OpAddr_mode_reg = 3'b010;	//Indirect Mode
	else if	(Ad_reg == 2'b11 && As_reg == 1'bX) OpAddr_mode_reg = 3'b011;	//Inmediate Mode
end

always @(Opcode_reg)
begin
	case (Opcode_reg)
	//Single operand (Format II) instructions
	4b'0001:
		begin
			case(Opcode_singop_reg)
			5'b00000:	
				begin
					if (BW_reg == 1'b0)
							//RRC
					else	//RRC.B
					
				end
				Res_reg = Dst;
			5'b00001:	//SWPB
				Res_reg = Dst;
			5'b00010:	//RRA
				begin	
					if (BW_reg == 1'b0)
							//RRA
					else	//RRA.B
					
				end	
			5'b00011:	//SXT
				Res_reg = Dst;
			5'b00100:	
				begin	
					if (BW_reg == 1'b0)
							//PUSH
					else	//PUSH.B
					
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
	4b'0010:
		begin
			case(Opcode_jumpop_reg)
				2b'00:		//JNE/JNZ
					Res_reg = Dst;
				2b'01:		//JEQ/JZ
					Res_reg = Dst;
				2b'10:		//JNC
					Res_reg = Dst;
				2b'11:		//JC
					Res_reg = Dst;
			endcase
		end
	//Jumps instructions
	4b'0011:
		begin
			case(Opcode_jumpop_reg)
				2b'00:		//JN
					Res_reg = Dst;
				2b'01:		//JGE
					Res_reg = Dst;
				2b'10:		//JL
					Res_reg = Dst;
				2b'11:		//JMP
					Res_reg = Dst;
			endcase
		end
	4b'0100:				//MOV
		Dst_reg = Src_reg;
	4b'0101:				//ADD
		Res_reg = Dst;
	4b'0110:				//ADDC
		Res_reg = Dst; 
	4b'0111:				//SUBC
		Res_reg = Dst;
	4b'1000:				//SUB
		Res_reg = Dst;
	4b'1001:				//CMP
		Res_reg = Dst;
	4b'1010:				//DADD
		Res_reg = Dst;
	4b'1011:				//BIT
		Res_reg = Dst;
	4b'1100:				//BIC
		Res_reg = Dst;
	4b'1101:				//BIS
		Res_reg = Dst;
	4b'1110:				//XOR
		Res_reg = Dst;
	4b'1111:				//AND
		Res_reg = Dst;
	
	endcase
		
end  
endmodule
