`timescale 1 ns/1 ns

module adderpc_tb();

	// Wires and variables to connect to DUT
	reg	[15:0] 	a_tb;
	reg  				en_tb;
	wire 	[15:0] 	res_tb;
	
	// Instantiate unit under test (adder)
	adderpc adderpc_tb (.a(a_tb), .en(en_tb), .res(res_tb));
	
initial
	begin
		a_tb = 15'd4;
		en_tb = 1'b1;
		
		#10 a_tb = 15'd6;
		#10 a_tb = 15'd8;
		#10 a_tb = 15'd10;
		#10 a_tb = 15'd12;
		#10 a_tb = 15'd14;
		#10 a_tb = 15'd16;
		#10 a_tb = 15'd18;


	end

always
	begin
		#5 en_tb = !en_tb;
	end

endmodule 
