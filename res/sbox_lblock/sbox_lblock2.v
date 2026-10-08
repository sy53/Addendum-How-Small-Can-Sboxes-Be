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



module sbox_lblock2(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign t0 = ~(x2 ^ x3);
assign t1 = x0 | x1;
assign t2 = ~(x1 & t0);
assign t3 = ~(x3 ^ t2);
assign t4 = ~(t0 ^ t1);
assign t5 = ~(x0 ^ t3);
assign t6 = x0 | t3;
assign t7 = ~(x1 ^ t6);
assign t8 = t4 | t5;
assign t9 = x0 ^ t8;
*/

XNOR xnor_0 (.in1(x2), .in2(x3), .out(t0));
OR or_1 (.in1(x0), .in2(x1), .out(t1));
NAND nand_2 (.in1(x1), .in2(t0), .out(t2));
XNOR xnor_3 (.in1(x3), .in2(t2), .out(t3));
XNOR xnor_4 (.in1(t0), .in2(t1), .out(t4));
XNOR xnor_5 (.in1(x0), .in2(t3), .out(t5));
OR or_6 (.in1(x0), .in2(t3), .out(t6));
XNOR xnor_7 (.in1(x1), .in2(t6), .out(t7));
OR or_8 (.in1(t4), .in2(t5), .out(t8));
XOR xor_9 (.in1(x0), .in2(t8), .out(t9));

assign y0 = t9;
assign y1 = t7;
assign y2 = t5;
assign y3 = t4;

endmodule
