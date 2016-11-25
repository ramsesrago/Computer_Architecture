module mux_16_bits (
	data0x,
	data1x,
	sel,
	result);

	input	[15:0]  data0x;
	input	[15:0]  data1x;
	input	  sel;
	output	[15:0]  result;

	reg [15: 0]	result;
	
initial 
	begin
		result = 16'd0;
	end
	
always@(sel)
	begin
		if (sel == 1'b0)
			result = data0x;
		else
			result = data1x;
	end
endmodule
