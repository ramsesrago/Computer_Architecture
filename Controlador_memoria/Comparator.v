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

module Comparator (Tag1,Tag2, Match);

input [‘TAG] Tag1;
input [‘TAG] Tag2;

output Match;

wire Match = (Tag1 == Tag2);

endmodule
