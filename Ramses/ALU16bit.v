/*
	author: Ramses Ramirez
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
	input  [3:0]  sel;
	
	/* outputs */
	output [15:0] result;
	output [3:0]  flags;
	
	/* regs */
	reg    N, Z, C, V;
	reg 	 [15:0] result;
	
	
	always @(A or B or sel) 
	begin
		case(sel)
			 // ADD, ADD.B
			 4'b0000: result = A + B;
			 // SUB, SUB.B
			 4'b0001: result = A - B;
			 4'b0010: result = A * B;
			 // AND, AND.B
			 4'b0011: result = A & B;
			 // XOR, XOR.B
			 4'b0100: result = A ^ B;
			 4'b0101: result = 16'b0;
			 // BIT, BIT.B
			 4'b0110: begin
							if(result[15] == 1) N = 1;
							else N = 0; 
							
							if(result == 16'b0) Z = 1;
							else Z = 0;
							
							if(result != 16'b0) C = 1;
							else C = 0;
						 end
				// BIC, BIC.B
				4'b0111: begin
								result = ~A & result;
							end
				// BIS, BIS.B
				4'd1000: begin
								result = A | result;
							end
				// CMP, CMP.B
				4'd1001: begin
								result = A - B;
								if(A > B) N = 0;
								else if( A == B) Z = 1;
								else if(result[15] == 1) C = 1;
							end
			default: result = 16'bxxxx;
		endcase
	end
	
	assign flags = {N,Z,C,V};
	
endmodule