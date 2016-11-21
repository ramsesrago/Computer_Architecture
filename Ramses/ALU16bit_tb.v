`timescale 1 ns/1 ns

module ALU16bit_tb();

	// Wires and variables to connect to DUT
	reg [15:0] A_tb, B_tb;
	reg [4:0] sel_tb;
	wire [15:0] result_tb;
	wire [4:0] flags_tb;
	
	// Instantiate unit under test (adder)
	ALU16bit ALU16bit_tb (.A(A_tb), .B(B_tb), .sel(sel_tb), .result(result_tb), .flags(flags_tb));

	// Assign values to "dataa" and "datab" to test adder block
initial 
	begin
		// ADD, ADD.B
		sel_tb = 4'b00000;
		A_tb = 16'd5;
		B_tb = 16'd8;

		// SUB, SUB.B
		#10 sel_tb = 4'b00001;
		// AND, AND.B
		#10 sel_tb = 4'b00011;
		// XOR, XOR.B
		#10 sel_tb = 4'b00100;
		// BIT, BIT.B
		#10 sel_tb = 4'b00110;
		// BIC, BIC.B
		#10 sel_tb = 4'b00111;
		// BIS, BIS.B
		#10 sel_tb = 4'b01000;
		// CMP, CMP.B
		#10 sel_tb = 4'b01001;
		A_tb = 16'd10;
		B_tb = 16'd10;
	end

endmodule
