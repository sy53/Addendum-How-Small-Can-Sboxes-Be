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

module NOR3(
	input in1,
	input in2,
	input in3,
	output out
);
assign out = ~(in1 | in2 | in3);
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



module sbox_present1(
	input [3:0] sbin,
	output [3:0] sbout
);
	wire x0,x1,x2,x3,y0,y1,y2,y3;
	wire tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7,tmp8,tmp9,tmp10;

	assign {x0,x1,x2,x3} = sbin;
	assign sbout = {y0,y1,y2,y3};


OR or_0 (.in1(x1), .in2(x3), .out(tmp1));
MOAI moai_1 (.in1(tmp1), .in2(x2), .in3(tmp1), .in4(x2), .out(tmp2));
NOR nor_2 (.in1(x1), .in2(tmp2), .out(tmp3));
MOAI moai_3 (.in1(tmp3), .in2(x0), .in3(tmp3), .in4(x0), .out(tmp4));
MOAI moai_4 (.in1(tmp4), .in2(x3), .in3(tmp4), .in4(x3), .out(tmp5));
assign tmp6 = ~tmp4;
NOR nor_6 (.in1(tmp2), .in2(tmp6), .out(tmp7));
NOR nor_7 (.in1(tmp7), .in2(tmp5), .out(tmp8));
MOAI moai_8 (.in1(tmp8), .in2(x1), .in3(tmp8), .in4(x1), .out(y2));
MOAI moai_9 (.in1(tmp2), .in2(tmp5), .in3(tmp2), .in4(tmp5), .out(y3));
NOR nor_10 (.in1(y2), .in2(tmp6), .out(tmp9));
MOAI moai_11 (.in1(tmp9), .in2(tmp2), .in3(tmp9), .in4(tmp2), .out(y1));
NOR3 nor3_12 (.in1(y1), .in2(y2), .in3(y3), .out(tmp10));
MOAI moai_13 (.in1(tmp10), .in2(tmp6), .in3(tmp10), .in4(tmp6), .out(y0));



endmodule
