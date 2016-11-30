module ALU16bit(A, B, result, sel, flags);
	/* inputs */
	input  [15:0] A, B;
	input  [4:0]  sel;
	
	/* outputs */
	output [15:0] result;
	output [3:0]  flags;
	
	/* regs */
	reg    [3:0]  flags;
	reg 	 [15:0] result;
	
initial
	begin
		flags[3] = 1'b0;
		flags[2] = 1'b0;
		flags[1] = 1'b0;
		flags[0] = 1'b0;
	end
	
always @(A or B or sel) 
	begin
		case(sel)
		
		/*
			DOUBLE OPERAND OPERATIONS
		*/
			5'b00000: result = A + B;				// MOV
			5'b00001: result = A + B;				// ADD, ADD.B
			5'b00010: result = A + B + flags[1];// ADDC
			5'b00011: result = A - B;				// SUB, SUB.B
			5'b00100: result = A - B - flags[1];// SUBC
			5'b00101: 									//	CMP
				begin
					result = A - B;
					if(A > B) flags[3] = 0;
					else if( A == B) flags[2] = 1;
					else if(result[15] == 1) flags[1] = 1;
				end
			5'b00110: result = A + B;				// DADD
			5'b00111: 									//	BIT
				begin
					if(result[15] == 1) flags[3] = 1;
					else flags[3] = 0; 
				
					if(result == 16'b0) flags[2] = 1;
					else flags[2] = 0;
							
					if(result != 16'b0) flags[1] = 1;
					else flags[1] = 0;
				end
			5'b01000: result = ~A & result;		// BIC, BIC.B
			5'b01001: result = A | result;		// BIS, BIS.B
			5'b01010: result = A ^ B;				// XOR, XOR.B
			5'b01011: result = A & B;				// AND, AND.B
			5'b01100: result = 16'b0;
		/*
			end of DOUBLE OPERAND OPERATIONS
		*/
		/*
			SINGLE OPERAND OPERATIONS
		*/
			5'b10000,									//RRC
			5'b10001,
			5'b10011,
			5'b10100:
				begin
					if (flags[1]==1) 
						begin
							flags[1] = B[0];
							result = (B/2)+16'h8000;
						end
					else 
						begin
							flags[1] = B[0];
							result = (B/2);
						end
				end
		/*
			end of SINGLE OPERAND OPERATIONS
		*/
			
			default: result = 16'bxxxx;
		endcase
	end
	
endmodule
