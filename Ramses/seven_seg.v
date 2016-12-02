module seven_seg (data_input, data_output);

input	[15: 0]	data_input;
output[41: 0]	data_output;


reg	[ 3: 0]	data_input_4;
reg	[ 3: 0]	data_input_3;
reg	[ 3: 0]	data_input_2;
reg	[ 3: 0]	data_input_1;
reg	[ 6: 0]	data_output_4;
reg	[ 6: 0]	data_output_3;
reg	[ 6: 0]	data_output_2;
reg	[ 6: 0]	data_output_1;
reg	[41: 0]  data_output;

always@(data_input)
begin
	data_input_1	= data_input [ 3: 0];
	data_input_2	= data_input [ 7: 4];
	data_input_3	= data_input [11: 8];
	data_input_4	= data_input [15:12];
	case (data_input_1)
		4'h0:	data_output_1 = 7'h40;
		4'h1:	data_output_1 = 7'h79;
		4'h2:	data_output_1 = 7'h24;
		4'h3:	data_output_1 = 7'h30;
		4'h4:	data_output_1 = 7'h19;
		4'h5:	data_output_1 = 7'h12;
		4'h6:	data_output_1 = 7'h02;
		4'h7:	data_output_1 = 7'h38;
		4'h8:	data_output_1 = 7'h00;
		4'h9:	data_output_1 = 7'h18;
	endcase
	case (data_input_2)
		4'h0:	data_output_2 = 7'h40;
		4'h1:	data_output_2 = 7'h79;
		4'h2:	data_output_2 = 7'h24;
		4'h3:	data_output_2 = 7'h30;
		4'h4:	data_output_2 = 7'h19;
		4'h5:	data_output_2 = 7'h12;
		4'h6:	data_output_2 = 7'h02;
		4'h7:	data_output_2 = 7'h38;
		4'h8:	data_output_2 = 7'h00;
		4'h9:	data_output_2 = 7'h18;
	endcase
	case (data_input_3)
		4'h0:	data_output_3 = 7'h40;
		4'h1:	data_output_3 = 7'h79;
		4'h2:	data_output_3 = 7'h24;
		4'h3:	data_output_3 = 7'h30;
		4'h4:	data_output_3 = 7'h19;
		4'h5:	data_output_3 = 7'h12;
		4'h6:	data_output_3 = 7'h02;
		4'h7:	data_output_3 = 7'h38;
		4'h8:	data_output_3 = 7'h00;
		4'h9:	data_output_3 = 7'h18;
	endcase
	case (data_input_4)
		4'h0:	data_output_4 = 7'h40;
		4'h1:	data_output_4 = 7'h79;
		4'h2:	data_output_4 = 7'h24;
		4'h3:	data_output_4 = 7'h30;
		4'h4:	data_output_4 = 7'h19;
		4'h5:	data_output_4 = 7'h12;
		4'h6:	data_output_4 = 7'h02;
		4'h7:	data_output_4 = 7'h38;
		4'h8:	data_output_4 = 7'h00;
		4'h9:	data_output_4 = 7'h18;
	endcase
	data_output [ 6: 0]	= data_output_1;
	data_output [13: 7]	= data_output_2;
	data_output [20:14]	= data_output_3;
	data_output [27:21]	= data_output_4;
	data_output [41:28]  = 14'h0;
end

endmodule
