module OR(
	input in1,
	input in2,
	output out
);
assign out = in1 | in2;
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



module sbox_skinny3(
	input [3:0] sbin,
	output [3:0] sbout
);
	wire x0,x1,x2,x3,y0,y1,y2,y3;
	wire t0,t1,t2,t3,t4,t5,t6,t7;

	assign {x3,x2,x1,x0} = sbin;
	assign sbout = {y3,y2,y1,y0};

	/*
	assign t0 = x2 | x3;
	assign t1 = x1 | x2;
	assign t2 = ~((x3 | t1) & (~(x3 & t1)));
	assign t3 = ~((x0 | t0) & (~(x0 & t0)));
	assign t4 = x1 | t3;
	assign t5 = t2 | t3;
	assign t6 = ~((x1 | t5) & (~(x1 & t5)));
	assign t7 = ~((x2 | t4) & (~(x2 & t4)));
	*/

	OR or_0 (.in1(x2), .in2(x3), .out(t0));
	OR or_1 (.in1(x1), .in2(x2), .out(t1));
	MOAI moai_2 (.in1(x3), .in2(t1), .in3(x3), .in4(t1), .out(t2));
	MOAI moai_3 (.in1(x0), .in2(t0), .in3(x0), .in4(t0), .out(t3));
	OR or_4 (.in1(x1), .in2(t3), .out(t4));
	OR or_5 (.in1(t2), .in2(t3), .out(t5));
	MOAI moai_6 (.in1(x1), .in2(t5), .in3(x1), .in4(t5), .out(t6));
	MOAI moai_7 (.in1(x2), .in2(t4), .in3(x2), .in4(t4), .out(t7));

	assign y0 = t6;
	assign y1 = t7;
	assign y2 = t2;
	assign y3 = t3;


endmodule
