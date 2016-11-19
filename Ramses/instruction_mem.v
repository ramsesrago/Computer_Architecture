module instruction_mem (clk, addr, inst);

// Inputs 
input 				clk;
input 	[15: 0]	addr;

// Outputs
output 	[15: 0]	inst;

// Wires
// Registers
reg 		[14: 0]	addr_reg;
reg 		[15: 0]	Inst_mem		[ 0:256];
reg		[15: 0]	Inst_reg;

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
	end

assign	inst = Inst_reg;

endmodule
