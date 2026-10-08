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

module MOAI(
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);
assign out = ~((in1 | in2) & (~(in3 & in4)));
endmodule



module sbox_lblock1(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire tmp1,tmp2,tmp3,tmp4,tmp5,tmp6;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign tmp1 = ~(x2 ^ x3);
assign tmp2 = ~(x1 & tmp1);
assign tmp3 = ~((x3 | tmp2) & (~(x3 & tmp2)));
assign tmp4 = x0 | x1;
assign y3 = ~((tmp1 | tmp4) & (~(tmp1 & tmp4)));
assign y2 = ~((x0 | tmp3) & (~(x0 & tmp3)));
assign tmp5 = ~(y2 | y3);
assign y0 = ~((x0 | tmp5) & (~(x0 & tmp5)));
assign tmp6 = ~(y0 & y2);
assign y1 = ~((x1 | tmp6) & (~(x1 & tmp6)));
*/

XNOR xor_0 (.in1(x2), .in2(x3), .out(tmp1));
NAND nand_1 (.in1(x1), .in2(tmp1), .out(tmp2));
MOAI moai_2 (.in1(x3), .in2(tmp2), .in3(x3), .in4(tmp2), .out(tmp3));
OR or_3 (.in1(x0), .in2(x1), .out(tmp4));
MOAI moai_4 (.in1(tmp1), .in2(tmp4), .in3(tmp1), .in4(tmp4), .out(y3));
MOAI moai_5 (.in1(x0), .in2(tmp3), .in3(x0), .in4(tmp3), .out(y2));
NOR nor_6 (.in1(y2), .in2(y3), .out(tmp5));
MOAI moai_7 (.in1(x0), .in2(tmp5), .in3(x0), .in4(tmp5), .out(y0));
NAND nand_8 (.in1(y0), .in2(y2), .out(tmp6));
MOAI moai_9 (.in1(x1), .in2(tmp6), .in3(x1), .in4(tmp6), .out(y1));

endmodule
