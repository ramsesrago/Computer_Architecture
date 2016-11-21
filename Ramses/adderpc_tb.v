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
		en_tb = 1'b0;
		
		#10 en_tb = 1'b1;
		#10 en_tb = 1'b0;
		#10 en_tb = 1'b1;
		#10 en_tb = 1'b0;

	end


endmodule 
