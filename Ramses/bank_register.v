module bank_register (
				src_reg, dst_reg, clk, 
				wr_reg, wr_data, wr_en, a, b,
				pc_data_out, pc_inc, pc_data_in, rst
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
input 				rst;			//Signal to reset all registers

// Outputs
output	reg [15: 0] a;
output 	reg [15: 0]	b;
output	reg [15: 0]	pc_data_out;		//To program counter

// Registers
reg 		[15: 0]	regmem	[ 0: 15];	//Memory registers
reg		[15: 0]	regpc;
reg		[ 3: 0]	i;

//	Parameters
parameter pc = 0;

//Behavior
initial 
begin
	regmem[pc] <= 16'b0000000000000000;
end

always @(posedge clk)
begin
	a = regmem [src_reg];		//Always output a to ALU w/src_reg
	b = regmem [dst_reg];		//Always output b to ALU w/dst_reg
	pc_data_out = regmem [pc];	//Always output pc to pc + 2 operation
	if (rst)
		begin
			for (i=4'd0; i<4'd15; i=i+1) 
				regmem[i] <= 16'b0000000000000000;
		end
	
	if (wr_en == 1'b1) 
		// control_unit.v to set what is the wr_reg to modify
		regmem[wr_reg] <= wr_data;
	
	else if (pc_inc == 1'b1)
		//	control_unit.v to save new pc
		regmem[pc] <= pc_data_in;
end

endmodule
