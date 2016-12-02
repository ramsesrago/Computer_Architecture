//Defines
‘define READ 1’b1
‘define WRITE 1’b0
‘define CACHESIZE 1024
‘define WAITSTATE 2’d2
‘define ADDR 15:0
‘define ADDRWIDTH 16
‘define INDEX 9:0
‘define TAG 15:10
‘define DATA 31:0
‘define DATAWIDTH 32
‘define PRESENT 1’b1
‘define ABSENT !’PRESENT

module ValidRam (Address, ValidIn, ValidOut,
						Write, Reset, Clk );
input [‘INDEX] Address;
input ValidIn;
input Write;
input Reset;
input Clk;

output validOut;

reg ValidOut;
reg [‘CACHESIZE-1:0] ValidBits;

integer i;

always @ (negedge Clk) // Write
	if (Write && !Reset)
		ValidBits[Address]=ValidIn; // write	
	else if (Reset)
		for (i=0;i<‘CACHESIZE;i=i+1)
			ValidBits[i]=‘ABSENT; //reset

always @ (posedge Clk)
ValidOut = ValidBits[Address]; // read

endmodule
