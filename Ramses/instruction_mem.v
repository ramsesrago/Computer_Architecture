module instruction_mem (clk, addr, inst, inst_1, inst_2);

// Inputs 
input 				clk;
input 	[15: 0]	addr;

// Outputs
output 	[15: 0]	inst;
output 	[15: 0]	inst_1;
output 	[15: 0]	inst_2;

// Wires
// Registers
reg 		[14: 0]	addr_reg;
reg 		[15: 0]	Inst_mem		[ 0:256];
reg		[15: 0]	Inst_reg;
reg		[15: 0]	Inst_1_reg;
reg		[15: 0]	Inst_2_reg;

// Parameters
// Behavior

initial
begin
	$readmemb ("Imem.data", Inst_mem);
end

always @(posedge clk)
	begin
		addr_reg 	= addr	[15:1];
		Inst_reg 	= Inst_mem[addr_reg];
		Inst_1_reg 	= Inst_mem[addr_reg+1];
		Inst_2_reg 	= Inst_mem[addr_reg+2];
	end

assign	inst   = Inst_reg;
assign	inst_1 = Inst_1_reg;
assign	inst_2 = Inst_2_reg;

endmodule
