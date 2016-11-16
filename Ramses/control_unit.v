module control_unit (
				instruction, inst_load, clk,
				en_pc_2, read_reg, bank_register_rw,
				src_reg, dst_reg, wr_en, 
				op_code
);

// Inputs 
input [15: 0] instruction;
input inst_load; 
input clk;

//Outputs
output	pc_2_en; 
output	wr_en;
output	read_reg; 
output	bank_register_rw,	
output	[ 3: 0]	src_reg, 
output	[ 3: 0]	dst_reg, 
output	[ 5: 0]	op_code;

end module
