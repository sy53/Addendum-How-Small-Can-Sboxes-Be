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

module NAND3(
	input in1,
	input in2,
	input in3,
	output out
);
assign out = ~(in1 & in2 & in3);
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



module sbox_twine1(
	input [3:0] sbin,
	output [3:0] sbout
);
	wire x0,x1,x2,x3,y0,y1,y2,y3;
	wire tmp1,tmp2,tmp3,tmp4,tmp5,t1,t2,t3,t4;

	assign {x0,x1,x2,x3} = sbin;
	assign sbout = {y0,y1,y2,y3};


NOR nor_0 (.in1(x1), .in2(x2), .out(tmp1));
MOAI moai_1 (.in1(tmp1), .in2(x3), .in3(tmp1), .in4(x3), .out(t1));
OR or_2 (.in1(x0), .in2(t1), .out(tmp2));
MOAI moai_3 (.in1(tmp2), .in2(x1), .in3(tmp2), .in4(x1), .out(t2));
MOAI moai_4 (.in1(x2), .in2(t1), .in3(x2), .in4(t1), .out(t3));
MOAI moai_5 (.in1(t3), .in2(x0), .in3(t3), .in4(x0), .out(t4));
NAND3 nand3_6 (.in1(x2), .in2(t2), .in3(t4), .out(tmp3));
MOAI moai_7 (.in1(tmp3), .in2(t3), .in3(tmp3), .in4(t3), .out(y0));
NAND nand_8 (.in1(y0), .in2(t2), .out(tmp4));
MOAI moai_9 (.in1(tmp4), .in2(x2), .in3(tmp4), .in4(x2), .out(y1));
MOAI moai_10 (.in1(t2), .in2(t4), .in3(t2), .in4(t4), .out(y2));
NOR nor_11 (.in1(y1), .in2(y2), .out(tmp5));
MOAI moai_12 (.in1(tmp5), .in2(t2), .in3(tmp5), .in4(t2), .out(y3));



endmodule
