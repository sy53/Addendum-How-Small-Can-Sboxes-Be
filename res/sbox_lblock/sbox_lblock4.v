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

module XNOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 ^ in2);
endmodule



module sbox_lblock4(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign t0 = x0 | x1;
assign t1 = ~(x2 ^ x3);
assign t2 = ~(t0 ^ t1);
assign t3 = ~(x0 ^ x3);
assign t4 = ~(x1 & t1);
assign t5 = ~(t3 ^ t4);
assign t6 = ~(t2 | t3);
assign t7 = ~(x0 ^ t6);
assign t8 = ~(t5 & t7);
assign t9 = ~(x1 ^ t8);
*/

OR or_0 (.in1(x0), .in2(x1), .out(t0));
XNOR xnor_1 (.in1(x2), .in2(x3), .out(t1));
XNOR xnor_2 (.in1(t0), .in2(t1), .out(t2));
XNOR xnor_3 (.in1(x0), .in2(x3), .out(t3));
NAND nand_4 (.in1(x1), .in2(t1), .out(t4));
XNOR xnor_5 (.in1(t3), .in2(t4), .out(t5));
NOR nor_6 (.in1(t2), .in2(t3), .out(t6));
XNOR xnor_7 (.in1(x0), .in2(t6), .out(t7));
NAND nand_8 (.in1(t5), .in2(t7), .out(t8));
XNOR xnor_9 (.in1(x1), .in2(t8), .out(t9));

assign y0 = t7;
assign y1 = t9;
assign y2 = t5;
assign y3 = t2;

endmodule
