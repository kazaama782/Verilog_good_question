`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2025 00:00:17
// Design Name: 
// Module Name: prime
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fa(s1,c2,a,b,cin);
input a,b,cin;
output s1,c2;
wire s0,c0,c1;
half_adder m0(s0,c0,a,b);
half_adder m1(s1,c1,s0,cin);
or m2(c2,c1,c0);
endmodule

module half_adder(s,cout,a,b);
input a,b;
output s,cout;
assign s=a^b;
assign cout=a&b;
endmodule




Testbench:-
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.06.2025 13:32:54
// Design Name: 
// Module Name: fa_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fa_tb;
reg a,b,cin;
wire s1,c2;
fa uut(s1,c2,a,b,cin);
initial
begin
$monitor($time,"s1=%b,c2=%b,a=%b,b=%b,cin=%b",s1,c2,a,b,cin);
#5 a=1;b=0;cin=0;
#5 a=0;b=1;
#5 $finish;
end
endmodule
