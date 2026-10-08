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

module MOAI(
	input in1,
	input in2,
	input in3,
	input in4,
	output out
);
assign out = ~((in1 | in2) & (~(in3 & in4)));
endmodule



module sbox_piccolo3(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7;

assign {x3,x2,x1,x0} = sbin;
assign sbout = {y3,y2,y1,y0};

/*
assign t0 = x2 | x3;
assign t1 = ~((x0 | t0) & (~(x0 & t0)));
assign t2 = ~(x1 | t1);
assign t3 = x1 | x2;
assign t4 = ~((x2 | t2) & (~(x2 & t2)));
assign t5 = ~((x3 | t3) & (~(x3 & t3)));
assign t6 = t1 | t5;
assign t7 = ~((x1 | t6) & (~(x1 & t6)));
*/

OR or_0 (.in1(x2), .in2(x3), .out(t0));
MOAI moai_1 (.in1(x0), .in2(t0), .in3(x0), .in4(t0), .out(t1));
NOR nor_2 (.in1(x1), .in2(t1), .out(t2));
OR or_3 (.in1(x1), .in2(x2), .out(t3));
MOAI moai_4 (.in1(x2), .in2(t2), .in3(x2), .in4(t2), .out(t4));
MOAI moai_5 (.in1(x3), .in2(t3), .in3(x3), .in4(t3), .out(t5));
OR or_6 (.in1(t1), .in2(t5), .out(t6));
MOAI moai_7 (.in1(x1), .in2(t6), .in3(x1), .in4(t6), .out(t7));

assign y0 = t7;
assign y1 = t4;
assign y2 = t5;
assign y3 = t1;

endmodule
