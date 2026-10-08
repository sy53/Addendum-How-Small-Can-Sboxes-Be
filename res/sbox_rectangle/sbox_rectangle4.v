module NOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 | in2);
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



module sbox_rectangle4(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign t0 = ~(x2 | x3);
assign t1 = ~(x0 ^ t0);
assign t2 = ~(x1 ^ x2);
assign t3 = ~(t1 ^ t2);
assign t4 = ~(x3 ^ t3);
assign t5 = ~(x1 & t1);
assign t6 = ~(t4 ^ t5);
assign t7 = ~(x2 | t1);
assign t8 = ~(t3 & t6);
assign t9 = ~(t1 ^ t8);
assign t10 = ~(t4 ^ t7);
*/

NOR nor_0 (.in1(x2), .in2(x3), .out(t0));
XNOR xnor_1 (.in1(x0), .in2(t0), .out(t1));
XNOR xnor_2 (.in1(x1), .in2(x2), .out(t2));
XNOR xnor_3 (.in1(t1), .in2(t2), .out(t3));
XNOR xnor_4 (.in1(x3), .in2(t3), .out(t4));
NAND nand_5 (.in1(x1), .in2(t1), .out(t5));
XNOR xnor_6 (.in1(t4), .in2(t5), .out(t6));
NOR nor_7 (.in1(x2), .in2(t1), .out(t7));
NAND nand_8 (.in1(t3), .in2(t6), .out(t8));
XNOR xnor_9 (.in1(t1), .in2(t8), .out(t9));
XNOR xnor_10 (.in1(t4), .in2(t7), .out(t10));

assign y0 = t9;
assign y1 = t6;
assign y2 = t10;
assign y3 = t3;

endmodule
