module bank_register (
				src_reg, dst_reg, clk, 
				wr_reg, wr_data, wr_en, a, b
);

// Inputs 
input		[ 3: 0]	src_reg; 	//Register to send to A
input		[ 3: 0]	dst_reg;		//Register to send to B
input 	[ 3: 0]  wr_reg;		//Register to store/write data
input		[15: 0]  wr_data;		//Data to be written
input 				wr_en;		//Signal to write result on register
input 				clk;			//System clock

// Outputs
output	[15: 0] 	a;
output 	[15: 0]	b;

// Registers
reg 		[15: 0]	regmem	[ 0: 15];	//Memory registers

//Behavior
assign 	a = regmem [src_reg];	//Always output a to ALU w/src_reg
assign	b = regmem [dst_reg];	//Always output b to ALU w/dst_reg

always @(posedge clk) 
	begin
		if (wr_en) 
		// control_unit.v to set what is the wr_reg to modify
			regmem[wr_reg] <= wr_data;
	end

	/*
	TODO: Need to add a MUX before wr_data, to choose between 
			PC, Status Register, General Registers
	*/
endmodule
