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

module XNOR(
	input in1,
	input in2,
	output out
);
assign out = ~(in1 ^ in2);
endmodule



module sbox_piccolo4(
	input [3:0] sbin,
	output [3:0] sbout
);

wire x0,x1,x2,x3,y0,y1,y2,y3;
wire t0,t1,t2,t3,t4,t5,t6,t7;

assign {x0,x1,x2,x3} = sbin;
assign sbout = {y0,y1,y2,y3};

/*
assign t0 = x0 | x1;
assign t1 = x1 | x2;
assign t2 = ~(x0 ^ t1);
assign t3 = ~(x3 ^ t0);
assign t4 = ~(x2 | t3);
assign t5 = t2 | t3;
assign t6 = ~(x2 ^ t5);
assign t7 = ~(x1 ^ t4);
*/

OR or_0 (.in1(x0), .in2(x1), .out(t0));
OR or_1 (.in1(x1), .in2(x2), .out(t1));
XNOR xnor_2 (.in1(x0), .in2(t1), .out(t2));
XNOR xnor_3 (.in1(x3), .in2(t0), .out(t3));
NOR nor_4 (.in1(x2), .in2(t3), .out(t4));
OR or_5 (.in1(t2), .in2(t3), .out(t5));
XNOR xnor_6 (.in1(x2), .in2(t5), .out(t6));
XNOR xnor_7 (.in1(x1), .in2(t4), .out(t7));

assign y0 = t3;
assign y1 = t2;
assign y2 = t7;
assign y3 = t6;

endmodule
