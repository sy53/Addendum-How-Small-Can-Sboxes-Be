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

module AND(
	input in1,
	input in2,
	output out
);
assign out = in1 & in2;
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



module sbox_rectangle1(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire tmp1,tmp2,tmp3,tmp4,tmp5,tmp6,tmp7;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign tmp1 = ~(x2 | x3);
assign tmp2 = ~((x0 | tmp1) & (~(x0 & tmp1)));
assign tmp3 = ~(x1 | tmp2);
assign tmp4 = ~((x3 | tmp3) & (~(x3 & tmp3)));
assign tmp5 = ~((x1 | x2) & (~(x1 & x2)));
assign y3 = ~((tmp2 | tmp5) & (~(tmp2 & tmp5)));
assign y1 = ~((x2 | tmp4) & (~(x2 & tmp4)));
assign tmp6 = tmp2 & y3;
assign y2 = ~((tmp4 | tmp6) & (~(tmp4 & tmp6)));
assign tmp7 = ~(y1 & y3);
assign y0 = ~((tmp2 | tmp7) & (~(tmp2 & tmp7)));
*/

NOR nor_0 (.in1(x2), .in2(x3), .out(tmp1));
MOAI moai_1 (.in1(x0), .in2(tmp1), .in3(x0), .in4(tmp1), .out(tmp2));
NOR nor_2 (.in1(x1), .in2(tmp2), .out(tmp3));
MOAI moai_3 (.in1(x3), .in2(tmp3), .in3(x3), .in4(tmp3), .out(tmp4));
MOAI moai_4 (.in1(x1), .in2(x2), .in3(x1), .in4(x2), .out(tmp5));
MOAI moai_5 (.in1(tmp2), .in2(tmp5), .in3(tmp2), .in4(tmp5), .out(y3));
MOAI moai_6 (.in1(x2), .in2(tmp4), .in3(x2), .in4(tmp4), .out(y1));
AND and_7 (.in1(tmp2), .in2(y3), .out(tmp6));
MOAI moai_8 (.in1(tmp4), .in2(tmp6), .in3(tmp4), .in4(tmp6), .out(y2));
NAND nand_9 (.in1(y1), .in2(y3), .out(tmp7));
MOAI moai_10 (.in1(tmp2), .in2(tmp7), .in3(tmp2), .in4(tmp7), .out(y0));

endmodule
