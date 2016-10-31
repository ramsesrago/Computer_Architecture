`timescale 1 ns/1 ns

module ALU16bit_tb();

	// Wires and variables to connect to DUT
	reg [15:0] A_tb, B_tb;
	reg [3:0] sel_tb;
	wire [15:0] result_tb;
	wire [3:0] flags_tb;
	
	// Instantiate unit under test (adder)
	ALU16bit ALU16bit_tb (.A(A_tb), .B(B_tb), .sel(sel_tb), .result(result_tb), .flags(flags_tb));

	// Assign values to "dataa" and "datab" to test adder block
	initial begin
		// ADD, ADD.B
		sel_tb = 4'b0000;
		A_tb = 16'd5;
		B_tb = 16'd8;

		// SUB, SUB.B
		#10 sel_tb = 4'b0001;
		// AND, AND.B
		#10 sel_tb = 4'b0011;
		// XOR, XOR.B
		#10 sel_tb = 4'b0100;
		// BIT, BIT.B
		#10 sel_tb = 4'b0110;
		// BIC, BIC.B
		#10 sel_tb = 4'b0111;
		// BIS, BIS.B
		#10 sel_tb = 4'b1000;
		// CMP, CMP.B
		#10 sel_tb = 4'b1001;
		A_tb = 16'd10;
		B_tb = 16'd10;
	end

endmodule