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

module DataRam(Address, DataIn, DataOut, Write, Clk);
input [‘INDEX] Address;
input [‘DATA] DataIn;
input Write;
input Clk;

output [‘DATA] DataOut;

reg [‘DATA] DataOut;
reg [‘DATA] DataRam [‘CACHESIZE-1:0];

always @ (negedge Clk)
	if (Write)
		DataRam[Address]=DataIn; // write

always @ (posedge Clk)
	DataOut = DataRam [Address]; // read

endmodule
