module NOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 | in2);
endmodule

module OR(
	input in1,
	input in2,
	output out
);
assign out = in1 | in2;
endmodule

module NAND(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 & in2);
endmodule

module AND(
	input in1,
	input in2,
	output out
);
assign out = in1 & in2;
endmodule

module XNOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 ^ in2);
endmodule

module XOR(
	input in1,
	input in2,
	output out
);
assign out = in1 ^ in2;
endmodule



module sbox_rectangle2(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign t0 = ~(x1 ^ x2);
assign t1 = ~(x2 | x3);
assign t2 = x3 ^ t0;
assign t3 = x0 ^ t1;
assign t4 = x1 | t3;
assign t5 = ~(t2 ^ t4);
assign t6 = x0 & x2;
assign t7 = t0 ^ t3;
assign t8 = t2 ^ t6;
assign t9 = ~(t5 & t7);
assign t10 = t3 ^ t9;
*/

XNOR xor_0 (.in1(x1), .in2(x2), .out(t0));
NOR nor_1 (.in1(x2), .in2(x3), .out(t1));
XOR xor_2 (.in1(x3), .in2(t0), .out(t2));
XOR xor_3 (.in1(x0), .in2(t1), .out(t3));
OR or_4 (.in1(x1), .in2(t3), .out(t4));
XNOR xnor_5 (.in1(t2), .in2(t4), .out(t5));
AND and_6 (.in1(x0), .in2(x2), .out(t6));
XOR xor_7 (.in1(t0), .in2(t3), .out(t7));
XOR xor_8 (.in1(t2), .in2(t6), .out(t8));
NAND nand_9 (.in1(t5), .in2(t7), .out(t9));
XOR xor_10 (.in1(t3), .in2(t9), .out(t10));

assign y0 = t10;
assign y1 = t5;
assign y2 = t8;
assign y3 = t7;

endmodule
