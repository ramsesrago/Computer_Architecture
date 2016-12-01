module mux_16_bits (
	data0x,
	data1x,
	data2x,
	sel,
	result);

	input	[15:0]  data0x;
	input	[15:0]  data1x;
	input	[15:0]  data2x;
	input	[ 1:0]  sel;
	output	[15:0]  result;

	reg [15: 0]	result;
	
initial 
	begin
		result = 16'd0;
	end
	
always@(*)
	begin
		if (sel == 2'b00)
			result = data0x;
		else if (sel == 2'b01)
			result = data1x;
		else 
			result = data2x;
	end
endmodule
