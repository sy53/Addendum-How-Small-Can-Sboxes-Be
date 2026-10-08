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

module MOAI(
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);
assign out = ~((in1 | in2) & (~(in3 & in4)));
endmodule



module sbox_rectangle3(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10;

assign {x3,x2,x1,x0} = sbin;
assign sbout = {y3,y2,y1,y0};

/*
assign t0 = ~(x0 | x1);
assign t1 = ~((x3 | t0) & (~(x3 & t0)));
assign t2 = ~((x2 | t1) & (~(x2 & t1)));
assign t3 = ~((x1 | t2) & (~(x1 & t2)));
assign t4 = ~((x0 | t3) & (~(x0 & t3)));
assign t5 = ~(x2 & t1);
assign t6 = ~((t4 | t5) & (~(t4 & t5)));
assign t7 = ~(x1 | t1);
assign t8 = ~(t3 & t6);
assign t9 = ~((t1 | t8) & (~(t1 & t8)));
assign t10 = ~((t4 | t7) & (~(t4 & t7)));
*/

NOR nor_0 (.in1(x0), .in2(x1), .out(t0));
MOAI moai_1 (.in1(x3), .in2(t0), .in3(x3), .in4(t0), .out(t1));
MOAI moai_2 (.in1(x2), .in2(t1), .in3(x2), .in4(t1), .out(t2));
MOAI moai_3 (.in1(x1), .in2(t2), .in3(x1), .in4(t2), .out(t3));
MOAI moai_4 (.in1(x0), .in2(t3), .in3(x0), .in4(t3), .out(t4));
NAND nand_5 (.in1(x2), .in2(t1), .out(t5));
MOAI moai_6 (.in1(t4), .in2(t5), .in3(t4), .in4(t5), .out(t6));
NOR nor_7 (.in1(x1), .in2(t1), .out(t7));
NAND nand_8 (.in1(t3), .in2(t6), .out(t8));
MOAI moai_9 (.in1(t1), .in2(t8), .in3(t1), .in4(t8), .out(t9));
MOAI moai_10 (.in1(t4), .in2(t7), .in3(t4), .in4(t7), .out(t10));

assign y0 = t3;
assign y1 = t10;
assign y2 = t6;
assign y3 = t9;

endmodule
