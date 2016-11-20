module bank_register (
				src_reg, dst_reg, clk, 
				wr_reg, wr_data, wr_en, a, b,
				pc_data_out, pc_inc, pc_data_in
);

// Inputs 
input		[ 3: 0]	src_reg; 	//Register to send to A
input		[ 3: 0]	dst_reg;		//Register to send to B
input 	[ 3: 0]  wr_reg;		//Register to store/write data
input		[15: 0]  wr_data;		//Data to be written
input		[15: 0]	pc_data_in;	//PC value to update
input 				wr_en;		//Signal to write result on register
input 				clk;			//System clock
input					pc_inc;		//Signal from control_unit.v to update pc

// Outputs
output	reg [15: 0] 	a;
output 	reg [15: 0]	b;
output	reg [15: 0]	pc_data_out;		//To program counter

// Registers
reg 		[15: 0]	regmem	[ 0: 15];	//Memory registers
reg		[15: 0]	regpc;

//	Parameters
parameter pc = 0;

//Behavior
always @(*)
begin
	a = regmem [src_reg];		//Always output a to ALU w/src_reg
	b = regmem [dst_reg];		//Always output b to ALU w/dst_reg
	pc_data_out = regmem [pc];	//Always output pc to pc + 2 operation
end

always @(posedge clk) 
	begin
		if (wr_en) 
		// control_unit.v to set what is the wr_reg to modify
			regmem[wr_reg] <= wr_data;
		//	control_unit.v to save new pc
		if (pc_inc)
			regmem[pc] <= pc_data_in;
	end

	/*
	TODO: Need to add a MUX before wr_data, to choose between 
			PC, Status Register, General Registers
	*/
endmodule
