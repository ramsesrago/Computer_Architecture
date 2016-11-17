/*
	TEC de Monterrey
	TIMSP430 ALU description
	Operations supported:
	 - ADD, ADD.B
	 - ADDC, ADDC.B
	 - SUBC, SUBC.B
	 - SUB, SUB.B
	 - CMP, CMP.B
	 - DADD, DADD.B
	 - BIT, BIT.B
	 - BIC, BIC.B
	 - BIS, BIS.B
	 - XOR, XOR.B
	 - AND, AND.B
*/

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
	
	
	always @(A or B or sel) 
	begin
		case(sel)
		
		/*
			DOUBLE OPERAND OPERATIONS
		*/
			// ADD, ADD.B
			5'b00000: result = A + B;
			// SUB, SUB.B
			5'b00001: result = A - B;
			5'b00010: result = A * B;
			// AND, AND.B
			5'b00011: result = A & B;
			// XOR, XOR.B
			5'b00100: result = A ^ B;
			5'b00101: result = 16'b0;
			// BIT, BIT.B
			5'b00110: 
				begin
					if(result[15] == 1) N = 1;
					else N = 0; 
				
					if(result == 16'b0) Z = 1;
					else Z = 0;
							
					if(result != 16'b0) C = 1;
					else C = 0;
				end
			// BIC, BIC.B
			5'b00111: 
				begin
					result = ~A & result;
				end
			// BIS, BIS.B
			5'd01000: 
				begin
					result = A | result;
				end
			// CMP, CMP.B
			5'd01001: 
				begin
					result = A - B;
					if(A > B) N = 0;
					else if( A == B) Z = 1;
					else if(result[15] == 1) C = 1;
				end
		/*
			end of DOUBLE OPERAND OPERATIONS
		*/
			
			default: result_reg = 16'bxxxx;
		endcase
	end
	
	assign flags = {N,Z,C,V};
	
endmodule