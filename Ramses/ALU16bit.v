module ALU16bit(A, B, result, sel, flags);
	/* inputs */
	input  [15:0] A, B;
	input  [4:0]  sel;
	
	/* outputs */
	output [15:0] result;
	output [3:0]  flags;
	
	/* regs */
	reg    N, Z, C, V;
	reg 	 [15:0] result;
	
initial
	begin
		N = 1'b0;
		Z = 1'b0;
		C = 1'b0;
		V = 1'b0;
	end
	
always @(A or B or sel) 
	begin
		case(sel)
		
		/*
			DOUBLE OPERAND OPERATIONS
		*/
			5'b00000: result = A + B;				// MOV
			5'b00001: result = A + B;				// ADD, ADD.B
			5'b00010: result = A + B + C;			// ADDC
			5'b00011: result = A - B;				// SUB, SUB.B
			5'b00100: result = A - B - C;			// SUBC
			5'b00101: 									//	CMP
				begin
					result = A - B;
					if(A > B) N = 0;
					else if( A == B) Z = 1;
					else if(result[15] == 1) C = 1;
				end
			5'b00110: result = A + B;				// DADD
			5'b00111: 									//	BIT
				begin
					if(result[15] == 1) N = 1;
					else N = 0; 
				
					if(result == 16'b0) Z = 1;
					else Z = 0;
							
					if(result != 16'b0) C = 1;
					else C = 0;
				end
			5'b01000: result = ~A & result;		// BIC, BIC.B
			5'b01001: result = A | result;		// BIS, BIS.B
			5'b01010: result = A ^ B;				// XOR, XOR.B
			5'b01011: result = A & B;				// AND, AND.B
			5'b01100: result = 16'b0;
		/*
			end of DOUBLE OPERAND OPERATIONS
		*/
			
			default: result = 16'bxxxx;
		endcase
	end
	
	assign flags = {N,Z,C,V};
	
endmodule