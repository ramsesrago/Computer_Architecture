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

module TagRam(Address, TagIn, TagOut, Write, Clk);

input [‘INDEX]Address;
input [‘TAG] TagIn;
input Write;
input Clk;

output [‘TAG] TagOut;


reg [‘TAG] TagOut;
reg [‘TAG] TagRam [0:’CACHESIZE-1];

always @ (negedge Clk)
if (Write)
	TagRam[Address]=TagIn; // write

always @ (posedge Clk)
	TagOut = TagRam[Address]; // read

endmodule
